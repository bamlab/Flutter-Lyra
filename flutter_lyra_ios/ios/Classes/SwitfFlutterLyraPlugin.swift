import Flutter
import UIKit
import LyraPaymentSDK

public class SwiftFlutterLyraPlugin: NSObject, FlutterPlugin, LyraHostApi {
        
    var lyraKey: LyraKeyInterface? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let api : LyraHostApi & NSObjectProtocol = SwiftFlutterLyraPlugin.init()
        
        LyraHostApiSetup(messenger, api);
    }
    
    public func initializeLyraKey(_ lyraKey: LyraKeyInterface, completion: @escaping (LyraKeyInterface?, FlutterError?) -> Void)
    {
        do {
            let options = Converters.initializeOptionsFromInterface(
                optionsInterface: lyraKey.options
            )
                        
            try Lyra.initialize(
                lyraKey.publicKey,
                options
            )
            
            self.lyraKey = lyraKey
            
            completion(
                lyraKey,
                nil
            )
        } catch let error  {
            completion(
                nil,
                FlutterError(
                    code: "initialization_error_code",
                    message: error.localizedDescription,
                    details: nil
                )
            )
        }
    }
    
    public func getFormTokenVersion(completion: @escaping (NSNumber?, FlutterError?) -> Void) {
        if (self.lyraKey == nil) {
            completion(
                nil,
                FlutterError(
                    code: "lyra_not_initialized_error_code",
                    message: "You should initialize Lyra first",
                    details: nil
                )
            )
            return
        }

        let formTokenVersion = Lyra.getFormTokenVersion()
        
        completion(
            NSNumber(value: formTokenVersion),
            nil
        )
    }
    
    public func processRequest(_ request: ProcessRequestInterface, completion: @escaping (String?, FlutterError?) -> Void) {
        if (self.lyraKey == nil) {
            completion(
                nil,
                FlutterError(
                    code: "lyra_not_initialized_error_code",
                    message: "You should initialize Lyra first",
                    details: nil
                )
            )
            return
        }

        guard let viewController = Self.resolveRootViewController() else {
            completion(
                nil,
                FlutterError(
                    code: "no_root_view_controller_error_code",
                    message: "Could not find a root view controller to present the payment form",
                    details: nil
                )
            )
            return
        }


        // If the request has a timeout argument, launch a timer that will cancel the process after the given time.
        var cancelProcessWork: DispatchWorkItem? = nil
        let timeoutInSeconds = request.timeoutInSeconds

        if (timeoutInSeconds != nil) {
            // The [cancelProcessWork] will read the current state of the application (wether it is on foreground or not)
            // and cancel the process if the app is on foreground.
            // If not, it will wait for the app to be foregrounded and then cancel the process.
            cancelProcessWork = DispatchWorkItem(block: {
                let state = UIApplication.shared.applicationState
                if state == .active {
                    self.cancelLyraProcess()
                } else {
                    NotificationCenter.default.addObserver(
                        self,
                        selector: #selector(self.cancelLyraProcess),
                        name: UIApplication.didBecomeActiveNotification,
                        object: nil
                    )
                }
            })
            
            let dispatchTime: DispatchTime = .now() + DispatchTimeInterval.seconds(timeoutInSeconds!.intValue)
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: cancelProcessWork!)
        }
        
        do {
            try Lyra.process(
                viewController,
                request.formToken,
                onSuccess: { ( _ lyraResponse: LyraResponse) -> Void in
                    cancelProcessWork?.cancel()
                    completion(
                        lyraResponse.getResponseDataString(),
                        nil
                    )
                },
                onError: { (_ error: LyraError, _ lyraResponse: LyraResponse?) -> Void in
                    cancelProcessWork?.cancel()
                    // We do not complete with error if errorCode is "MOB_013".
                    // This error indicate that the payment process cannot be cancelled.
                    // After this error, normal SDK behavior continues:
                    // if the payment completes successfully then the onSuccess handler will be called.
                    // if the payment is failed. Depending on the error, the payment form remains displayed or the onError handler will be called.
                    if(error.errorCode != "MOB_013") {
                        completion(
                            nil,
                            Converters.parseError(
                                lyraError: error,
                                errorCodesInterface: request.errorCodes,
                                defaultFlutterError: FlutterError(
                                    code: error.errorCode,
                                    message: error.errorMessage,
                                    details: nil
                                )
                            )
                        )
                    }
                }
            )
            
        } catch {
            cancelProcessWork?.cancel()
            completion(
                nil,
                FlutterError(
                    code: "lyra_process_error_code",
                    message: "An unknown error occured",
                    details: nil
                )
            )
        }
    }
    
    @objc func cancelLyraProcess() {
        Lyra.cancelProcess()
    }

    /// Resolves the root view controller used to present the payment form.
    ///
    /// Under the UIScene-based lifecycle the app window is owned by the active
    /// scene, so `UIApplication.shared.delegate?.window` is `nil`. We therefore
    /// look up the window from the connected scenes first, and only fall back to
    /// the AppDelegate window for apps still using the legacy lifecycle.
    static func resolveRootViewController() -> UIViewController? {
        let windows = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .flatMap { $0.windows }

        let window = windows.first(where: { $0.isKeyWindow }) ?? windows.first

        return window?.rootViewController
            ?? UIApplication.shared.delegate?.window??.rootViewController
    }
}
