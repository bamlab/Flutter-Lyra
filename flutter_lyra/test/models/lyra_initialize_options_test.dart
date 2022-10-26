import 'package:flutter_lyra/models/lyra_initialize_options.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LyraInitializeOptions', () {
    test('instances with same fields are equal', () async {
      const firstInstance = LyraInitializeOptions(
        apiServerName: 'apiServerName',
        nfcEnabled: true,
        cardScanningEnabled: false,
      );
      const secondInstance = LyraInitializeOptions(
        apiServerName: 'apiServerName',
        nfcEnabled: true,
        cardScanningEnabled: false,
      );

      expect(firstInstance == secondInstance, isTrue);
    });

    test('instances with differents fields are not equal', () async {
      const firstInstance = LyraInitializeOptions(
        apiServerName: 'apiServerName',
        nfcEnabled: true,
        cardScanningEnabled: false,
      );
      const secondInstance = LyraInitializeOptions(
        apiServerName: 'apiServerName2',
        nfcEnabled: false,
        cardScanningEnabled: true,
      );

      expect(firstInstance == secondInstance, isFalse);
    });
  });
}
