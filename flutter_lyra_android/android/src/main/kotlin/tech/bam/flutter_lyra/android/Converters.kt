package tech.bam.flutter_lyra.android

import com.lyra.sdk.Lyra
import com.lyra.sdk.exception.LyraException

class Converters {
    companion object {
        fun parseError(
            lyraError: LyraException,
            errorCodesInterface: LyraApi.ErrorCodesInterface,
            defaultFlutterError: FlutterError
        ): FlutterError {
            if (lyraError.errorCode == "MOB_009") {
                return FlutterError(
                    code = lyraError.errorCode,
                    message = "${errorCodesInterface.paymentCancelledByUser} - ${lyraError.errorMessage}",
                    details = null
                )
            }
            return defaultFlutterError
        }

        fun initializeOptionsFromInterface(
            optionsInterface: LyraApi.LyraInitializeOptionsInterface
        ): HashMap<String, Any> {
            val options = HashMap<String, Any>()

            options[Lyra.OPTION_API_SERVER_NAME] = optionsInterface.apiServerName

            val cardScanningEnabled = optionsInterface.cardScanningEnabled
            if (cardScanningEnabled != null) {
                options[Lyra.OPTION_CARD_SCANNING_ENABLED] = cardScanningEnabled
            }

            val nfcEnabled = optionsInterface.nfcEnabled
            if (nfcEnabled != null) {
                options[Lyra.OPTION_NFC_ENABLED] = nfcEnabled
            }

            return options
        }
    }
}