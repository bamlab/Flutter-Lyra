import Flutter
import UIKit
import LyraPaymentSDK

public class SwiftFlutterPayzenPlugin: NSObject, FlutterPlugin, PayzenHostApi {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let api : PayzenHostApi & NSObjectProtocol = SwiftFlutterPayzenPlugin.init()
        
        PayzenHostApiSetup(messenger, api);
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
}
