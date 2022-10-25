import LyraPaymentSDK

public class Converters {
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
