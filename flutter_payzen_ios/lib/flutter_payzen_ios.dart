// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payzen_platform_interface/flutter_payzen_platform_interface.dart';
import 'package:flutter_payzen_platform_interface/info.dart';

/// The iOS implementation of [FlutterPayzenPlatform].
class FlutterPayzenIOS extends FlutterPayzenPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_payzen_ios');

  /// Registers this class as the default instance of [FlutterPayzenPlatform]
  static void registerWith() {
    FlutterPayzenPlatform.instance = FlutterPayzenIOS();
  }

  @override
  Future<Infos?> search() {
    return InfosApi().search();
  }
}
