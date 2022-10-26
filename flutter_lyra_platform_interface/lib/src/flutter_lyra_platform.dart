import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../flutter_lyra_platform_interface.dart';
import 'method_channel_flutter_lyra.dart';

/// {@template flutter_lyra.flutterLyraPlatform}
/// The interface that implementations of flutter_lyra must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `FlutterLyra`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
/// this interface will be broken by newly added [FlutterLyraPlatform] methods
/// {@endtemplate}
abstract class FlutterLyraPlatform extends PlatformInterface {
  /// Constructs a [FlutterLyraPlatform].
  FlutterLyraPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterLyraPlatform _instance = MethodChannelFlutterLyra();

  /// The default instance of [FlutterLyraPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterLyra].
  static FlutterLyraPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterLyraPlatform] when they register themselves.
  static set instance(FlutterLyraPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  static LyraHostApi _lyraHostApi = LyraHostApi();

  /// The default instance of [LyraHostApi] to use
  LyraHostApi get lyraHostApi => _lyraHostApi;

  /// You can use this to set another instance of [LyraHostApi] to use
  ///
  /// This only for a test usage
  @visibleForTesting
  set lyraHostApi(LyraHostApi newLyraHostApi) {
    _lyraHostApi = newLyraHostApi;
  }

  /// {@macro flutter_lyra.lyraManager.initialize}
  Future<LyraKeyInterface> initialize({
    required String publicKey,
    required LyraInitializeOptionsInterface options,
  }) =>
      lyraHostApi
          .initialize(LyraKeyInterface(publicKey: publicKey, options: options));

  /// {@macro flutter_lyra.lyraManager.getFormTokenVersion}
  Future<int> getFormTokenVersion() => lyraHostApi.getFormTokenVersion();
}
