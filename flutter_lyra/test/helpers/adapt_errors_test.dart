import 'package:flutter_lyra/helpers/adapt_errors.dart';
import 'package:flutter_lyra/models/errors.dart';
import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$adaptErrors', () {
    test('random error', () async {
      const Object error = 'error';
      final stackTrace = StackTrace.fromString('test');

      var hasError = false;

      try {
        adaptErrors(
          error: error,
          stackTrace: stackTrace,
        );
      } catch (e, st) {
        expect(error, e);
        expect(stackTrace, st);

        hasError = true;
      }

      expect(hasError, isTrue);
    });

    test('$PaymentCancelledByUserException', () async {
      Object? error;

      try {
        adaptErrors(
          error: PaymentCancelledByUserExceptionInterface(),
          stackTrace: StackTrace.fromString('test'),
        );
      } catch (e) {
        error = e;
      }

      expect(error, isA<PaymentCancelledByUserException>());
    });
  });
}
