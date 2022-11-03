import 'package:flutter/services.dart';
import 'package:flutter_lyra_ios/flutter_lyra_ios.dart';
import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterLyraIOS', () {
    const kPlatformName = 'iOS';
    late FlutterLyraIOS flutterLyra;
    late List<MethodCall> log;

    setUp(() async {
      flutterLyra = FlutterLyraIOS();

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
      FlutterLyraIOS.registerWith();
      expect(FlutterLyraPlatform.instance, isA<FlutterLyraIOS>());
    });

    group('can parse an error', () {
      test('random error', () {
        final exception = Exception();

        Object? error;

        try {
          FlutterLyraIOS().parseError(exception, StackTrace.fromString('test'));
        } catch (e) {
          error = e;
        }

        expect(exception, error);
      });

      test('random platform exception', () {
        final exception = PlatformException(code: 'code');

        Object? error;

        try {
          FlutterLyraIOS().parseError(exception, StackTrace.fromString('test'));
        } catch (e) {
          error = e;
        }

        expect(exception, error);
      });

      test('$PaymentCancelledByUserExceptionInterface', () {
        final exception = PlatformException(
          code: errorCodesInterface.paymentCancelledByUser,
        );

        Object? error;

        try {
          FlutterLyraIOS().parseError(exception, StackTrace.fromString('test'));
        } catch (e) {
          error = e;
        }

        expect(error, isA<PaymentCancelledByUserExceptionInterface>());
      });
    });
  });
}
