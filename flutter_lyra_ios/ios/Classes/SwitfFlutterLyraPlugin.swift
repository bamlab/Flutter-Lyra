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
        }
        
        let viewController = ((UIApplication.shared.delegate?.window!)!).rootViewController
        
        do {
            try Lyra.process(
                viewController!,
                request.formToken,
                onSuccess: { ( _ lyraResponse: LyraResponse) -> Void in
                    completion(
                        lyraResponse.getResponseDataString(),
                        nil
                    )
                },
                onError: { (_ error: LyraError, _ lyraResponse: LyraResponse?) -> Void in
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
    
    public func cancelProcess(completion: @escaping (FlutterError?) -> Void) {
        if (self.lyraKey == nil) {
            completion(
                FlutterError(
                    code: "lyra_not_initialized_error_code",
                    message: "You should initialize Lyra first",
                    details: nil
                )
            )
        }
        
        Lyra.cancelProcess()
        completion(nil)
    }
    
}
