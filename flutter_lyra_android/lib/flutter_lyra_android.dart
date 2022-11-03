import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';

/// The Android implementation of [FlutterLyraPlatform].
class FlutterLyraAndroid extends FlutterLyraPlatform {
  @override
  Never parseError(Object error, StackTrace stackTrace) {
    if (error is PlatformException) {
      final errorMessage = error.message;
      if (errorMessage != null) {
        if (errorMessage.contains(errorCodesInterface.paymentCancelledByUser)) {
          throw PaymentCancelledByUserExceptionInterface();
        }
      }
    }
    return Error.throwWithStackTrace(error, stackTrace);
  }

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_lyra_android');

  /// Registers this class as the default instance of [FlutterLyraPlatform]
  static void registerWith() {
    FlutterLyraPlatform.instance = FlutterLyraAndroid();
  }
}
