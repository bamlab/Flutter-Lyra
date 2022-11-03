import LyraPaymentSDK

public class Converters {
    static public func parseError(
                lyraError: LyraError,
                errorCodesInterface: ErrorCodesInterface,
                defaultFlutterError: FlutterError
        ) -> FlutterError {
            if (lyraError.errorCode == "MOB_009") {
                return FlutterError(
                    code: errorCodesInterface.paymentCancelledByUser,
                    message: lyraError.errorMessage,
                    details: nil
                )
            }
            return defaultFlutterError
        }
    
    static public func initializeOptionsFromInterface(
        optionsInterface: LyraInitializeOptionsInterface
    ) -> [String : Any] {
        var options = [String : Any]()
        
        options[Lyra.apiServerName] = optionsInterface.apiServerName
        
        let cardScanningEnabled = optionsInterface.cardScanningEnabled
        if (cardScanningEnabled != nil) {
            options[Lyra.cardScanningEnabled] = cardScanningEnabled
        }
        
        return options
    }
}
