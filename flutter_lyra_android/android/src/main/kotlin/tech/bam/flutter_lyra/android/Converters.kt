package tech.bam.flutter_lyra.android

import com.lyra.sdk.Lyra

class Converters {
    companion object {
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