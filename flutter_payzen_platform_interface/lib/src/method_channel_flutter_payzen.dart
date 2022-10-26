import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';

import 'flutter_payzen_platform.dart';

/// An implementation of [FlutterPayzenPlatform] that uses method channels.
class MethodChannelFlutterPayzen extends FlutterPayzenPlatform {
  /// {@template flutter_payzen.methodChannelFlutterPayzen.methodChannel}
  /// The method channel used to interact with the native platform.
  /// {@endtemplate}
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_payzen');
}
