import 'package:flutter_payzen/flutter_payzen.dart';
import 'package:flutter_payzen/helpers/lyra_options_converter.dart';
import 'package:flutter_payzen_platform_interface/flutter_payzen_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

mixin PlatformInterfaceMockMixin on Mock implements MockPlatformInterfaceMixin {
}

class MockFlutterPayzenPlatform extends Mock
    with PlatformInterfaceMockMixin
    implements FlutterPayzenPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterPayzen', () {
    late FlutterPayzenPlatform flutterPayzenPlatform;

    setUp(() {
      flutterPayzenPlatform = MockFlutterPayzenPlatform();
      FlutterPayzenPlatform.instance = flutterPayzenPlatform;
    });

    group('initialize', () {
      test('returns correct reachFive instance', () async {
        const publicKey = 'publicKey';
        const options = LyraInitializeOptions(
          apiServerName: 'apiServerName',
          cardScanningEnabled: true,
          nfcEnabled: false,
        );

        final lyraKeyInterface = LyraKeyInterface(
          publicKey: publicKey,
          options: LyraInitializeOptionsConverter.toInterface(options),
        );

        registerFallbackValue(
          lyraKeyInterface.options,
        );
        when(
          () => flutterPayzenPlatform.initialize(
            publicKey: publicKey,
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => lyraKeyInterface,
        );

        final lyraReceived = await LyraManager().initialize(
          publicKey: publicKey,
          options: options,
        );

        expect(
          lyraKeyInterface.publicKey,
          lyraReceived.publicKey,
        );
      });
    });
  });
}
