import Flutter
import UIKit

public class SwiftFlutterPayzenPlugin: NSObject, FlutterPlugin, InfosApi {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let messenger : FlutterBinaryMessenger = registrar.messenger()
    let api : InfosApi & NSObjectProtocol = SwiftFlutterPayzenPlugin.init()

    InfosApiSetup(messenger, api);
  }

  public func searchWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> Infos? {
    let infos = Infos()
    infos.info1 = "info1"
    infos.info2 = "info2"

    return infos
  }
}
