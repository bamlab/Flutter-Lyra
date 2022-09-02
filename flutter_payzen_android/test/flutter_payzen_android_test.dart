// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/services.dart';
import 'package:flutter_payzen_android/flutter_payzen_android.dart';
import 'package:flutter_payzen_platform_interface/flutter_payzen_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterPayzenAndroid', () {
    const kPlatformName = 'Android';
    late FlutterPayzenAndroid flutterPayzen;
    late List<MethodCall> log;

    setUp(() async {
      flutterPayzen = FlutterPayzenAndroid();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
          .setMockMethodCallHandler(flutterPayzen.methodChannel,
              (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      FlutterPayzenAndroid.registerWith();
      expect(FlutterPayzenPlatform.instance, isA<FlutterPayzenAndroid>());
    });
  });
}
