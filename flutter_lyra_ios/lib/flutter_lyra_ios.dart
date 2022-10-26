import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';

/// The iOS implementation of [FlutterLyraPlatform].
class FlutterLyraIOS extends FlutterLyraPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_lyra_ios');

  /// Registers this class as the default instance of [FlutterLyraPlatform]
  static void registerWith() {
    FlutterLyraPlatform.instance = FlutterLyraIOS();
  }
}
