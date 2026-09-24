import 'package:flutter_lyra/models/lyra_process_options.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LyraProcessOptions', () {
    test('instances with same fields are equal', () async {
      const firstInstance = LyraProcessOptions(
        customPayButtonLabel: 'customPayButtonLabel',
        customHeaderLabel: 'customHeaderLabel',
        customPopupLabel: 'customPopupLabel',
      );
      const secondInstance = LyraProcessOptions(
        customPayButtonLabel: 'customPayButtonLabel',
        customHeaderLabel: 'customHeaderLabel',
        customPopupLabel: 'customPopupLabel',
      );

      expect(firstInstance == secondInstance, isTrue);
    });

    test('instances with differents fields are not equal', () async {
      const firstInstance = LyraProcessOptions(
        customPayButtonLabel: 'customPayButtonLabel',
      );
      const secondInstance = LyraProcessOptions(
        customPayButtonLabel: 'customPayButtonLabel2',
      );

      expect(firstInstance == secondInstance, isFalse);
    });
  });
}
