// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/services.dart';
import 'package:flutter_lyra_android/flutter_lyra_android.dart';
import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterLyraAndroid', () {
    const kPlatformName = 'Android';
    late FlutterLyraAndroid flutterLyra;
    late List<MethodCall> log;

    setUp(() async {
      flutterLyra = FlutterLyraAndroid();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
          .setMockMethodCallHandler(flutterLyra.methodChannel,
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
      FlutterLyraAndroid.registerWith();
      expect(FlutterLyraPlatform.instance, isA<FlutterLyraAndroid>());
    });

    group('can parse an error', () {
      test('random error', () {
        final exception = Exception();

        Object? error;

        try {
          FlutterLyraAndroid()
              .parseError(exception, StackTrace.fromString('test'));
        } catch (e) {
          error = e;
        }

        expect(exception, error);
      });

      test('random platform exception', () {
        final exception = PlatformException(code: 'code');

        Object? error;

        try {
          FlutterLyraAndroid()
              .parseError(exception, StackTrace.fromString('test'));
        } catch (e) {
          error = e;
        }

        expect(exception, error);
      });

      test('$PaymentCancelledByUserExceptionInterface', () {
        final exception = PlatformException(
          code:
              '''tech.bam.flutter_lyra.android.FlutterError: payment_cancelled_by_user_code - Payment cancelled''',
          message: 'FlutterError',
        );

        Object? error;

        try {
          FlutterLyraAndroid()
              .parseError(exception, StackTrace.fromString('test'));
        } catch (e) {
          error = e;
        }

        expect(error, isA<PaymentCancelledByUserExceptionInterface>());
      });
    });
  });
}
