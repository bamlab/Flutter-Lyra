import LyraPaymentSDK

class Converters {
    static func parseError(
                lyraError: LyraError,
                errorCodesInterface: ErrorCodesInterface,
                defaultError: PigeonError
        ) -> PigeonError {
            if (lyraError.errorCode == "MOB_009") {
                return PigeonError(
                    code: errorCodesInterface.paymentCancelledByUser,
                    message: lyraError.errorMessage,
                    details: nil
                )
            }
            return defaultError
        }
    
    static func initializeOptionsFromInterface(
        optionsInterface: LyraInitializeOptionsInterface
    ) -> InitOptions {
        return InitOptions(
            cardScanningEnabled: optionsInterface.cardScanningEnabled ?? false,
            applePayMerchantId: optionsInterface.applePayMerchantId ?? "",
            applePayMerchantName: optionsInterface.applePayMerchantName ?? ""
        )
    }
}
