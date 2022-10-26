import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';

import 'flutter_lyra_platform.dart';

/// An implementation of [FlutterLyraPlatform] that uses method channels.
class MethodChannelFlutterLyra extends FlutterLyraPlatform {
  /// {@template flutter_lyra.methodChannelFlutterLyra.methodChannel}
  /// The method channel used to interact with the native platform.
  /// {@endtemplate}
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_lyra');
}
