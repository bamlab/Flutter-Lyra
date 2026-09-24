package tech.bam.flutter_lyra.android

import com.lyra.sdk.Lyra
import com.lyra.sdk.exception.LyraException

class Converters {
    companion object {
        fun parseError(
            lyraError: LyraException,
            errorCodesInterface: ErrorCodesInterface,
            defaultFlutterError: FlutterError
        ): FlutterError {
            if (lyraError.errorCode == "MOB_009") {
                return FlutterError(
                    code = errorCodesInterface.paymentCancelledByUser,
                    message = lyraError.errorMessage,
                    details = null
                )
            }
            return defaultFlutterError
        }

        fun initializeOptionsFromInterface(
            optionsInterface: LyraInitializeOptionsInterface
        ): HashMap<String, Any?> {
            val options = HashMap<String, Any?>()

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

        fun processOptionsFromInterface(
            optionsInterface: LyraProcessOptionsInterface?
        ): HashMap<String, Any?> {
            val options = HashMap<String, Any?>()

            optionsInterface?.customPayButtonLabel?.let {
                options[Lyra.CUSTOM_PAY_BUTTON_LABEL] = it
            }
            optionsInterface?.customHeaderLabel?.let {
                options[Lyra.CUSTOM_HEADER_LABEL] = it
            }
            optionsInterface?.customPopupLabel?.let {
                options[Lyra.CUSTOM_POPUP_LABEL] = it
            }

            return options
        }
    }
}