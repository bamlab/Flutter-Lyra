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
        
        options[LyraInitOptions.apiServerName] = optionsInterface.apiServerName
        
        let cardScanningEnabled = optionsInterface.cardScanningEnabled
        if (cardScanningEnabled != nil) {
            options[LyraInitOptions.cardScanningEnabled] = cardScanningEnabled
        }
        
        let applePayMerchantId = optionsInterface.applePayMerchantId
        if (applePayMerchantId != nil) {
            options[LyraInitOptions.applePayMerchantId] = applePayMerchantId
        }

        let applePayMerchantName = optionsInterface.applePayMerchantName
        if (applePayMerchantName != nil) {
            options[LyraInitOptions.applePayMerchantName] = applePayMerchantName
        }
        
        return options
    }
}
