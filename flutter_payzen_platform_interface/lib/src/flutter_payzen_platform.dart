import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../flutter_payzen_platform_interface.dart';
import 'method_channel_flutter_payzen.dart';

/// {@template flutter_payzen.flutterPayzenPlatform}
/// The interface that implementations of flutter_payzen must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `FlutterPayzen`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
/// this interface will be broken by newly added [FlutterPayzenPlatform] methods
/// {@endtemplate}
abstract class FlutterPayzenPlatform extends PlatformInterface {
  /// Constructs a FlutterPayzenPlatform.
  FlutterPayzenPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPayzenPlatform _instance = MethodChannelFlutterPayzen();

  /// The default instance of [FlutterPayzenPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPayzen].
  static FlutterPayzenPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterPayzenPlatform] when they register themselves.
  static set instance(FlutterPayzenPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  static PayzenHostApi _payzenHostApi = PayzenHostApi();

  /// The default instance of [PayzenHostApi] to use
  PayzenHostApi get payzenHostApi => _payzenHostApi;

  /// You can use this to set another instance of [PayzenHostApi] to use
  ///
  /// This only for a test usage
  @visibleForTesting
  set payzenHostApi(PayzenHostApi newPayzenHostApi) {
    _payzenHostApi = newPayzenHostApi;
  }

  /// {@macro flutter_payzen.lyraManager.initialize}
  Future<LyraKeyInterface> initialize({
    required String publicKey,
    required LyraInitializeOptionsInterface options,
  }) {
    return payzenHostApi
        .initialize(LyraKeyInterface(publicKey: publicKey, options: options));
  }
}
