// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_payzen_platform_interface/info.dart';
import 'package:flutter_payzen_platform_interface/src/method_channel_flutter_payzen.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of flutter_payzen must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `FlutterPayzen`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
/// this interface will be broken by newly added [FlutterPayzenPlatform] methods
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

  /// Return Informations
  Future<Infos?> search();
}
