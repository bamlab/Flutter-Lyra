import 'package:flutter_lyra/flutter_lyra.dart';
import 'package:flutter_lyra/helpers/lyra_options_converter.dart';
import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

mixin PlatformInterfaceMockMixin on Mock implements MockPlatformInterfaceMixin {
}

class MockFlutterLyraPlatform extends Mock
    with PlatformInterfaceMockMixin
    implements FlutterLyraPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterLyra', () {
    late FlutterLyraPlatform flutterLyraPlatform;
    late String publicKey;
    late LyraInitializeOptions options;
    late Lyra lyra;

    setUp(() {
      flutterLyraPlatform = MockFlutterLyraPlatform();
      FlutterLyraPlatform.instance = flutterLyraPlatform;

      publicKey = 'publicKey';
      options = const LyraInitializeOptions(
        apiServerName: 'apiServerName',
        cardScanningEnabled: true,
        nfcEnabled: false,
      );

      lyra = Lyra(publicKey: publicKey, options: options);
    });

    group('initialize', () {
      test('returns correct lyra instance', () async {
        final lyraKeyInterface = LyraKeyInterface(
          publicKey: publicKey,
          options: LyraInitializeOptionsConverter.toInterface(options),
        );

        registerFallbackValue(
          lyraKeyInterface.options,
        );
        when(
          () => flutterLyraPlatform.initialize(
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

        expect(
          LyraInitializeOptionsConverter.fromInterface(
            lyraKeyInterface.options,
          ),
          lyraReceived.options,
        );
      });
    });

    group('getFormTokenVersion', () {
      test('returns correct form token version', () async {
        const formTokenVersion = 3;

        when(
          flutterLyraPlatform.getFormTokenVersion,
        ).thenAnswer(
          (_) async => formTokenVersion,
        );

        final receivedFormTokenVersion = await lyra.getFormTokenVersion();

        expect(
          formTokenVersion,
          receivedFormTokenVersion,
        );
      });
    });

    group('cancelProcess', () {
      test('calls the platform cancelProcess api', () async {
        when(flutterLyraPlatform.cancelProcess).thenAnswer(
          (_) async {},
        );

        await lyra.cancelProcess();

        verify(flutterLyraPlatform.cancelProcess).called(1);
      });

      test('parse throw error', () async {
        when(flutterLyraPlatform.cancelProcess).thenThrow(Exception());

        registerFallbackValue(
          StackTrace.fromString('test'),
        );
        when(
          () => flutterLyraPlatform.parseError(any(), any()),
        ).thenThrow(Exception());

        try {
          await lyra.cancelProcess();
        } catch (_) {}

        verify(() => flutterLyraPlatform.parseError(any(), any())).called(1);
      });
    });

    group('process', () {
      test('returns correct lyra response string', () async {
        const formToken = 'formToken';
        const lyraResponse = 'lyraResponse';

        when(
          () => flutterLyraPlatform.process(formToken),
        ).thenAnswer(
          (_) async => lyraResponse,
        );

        final receivedLyraResponse = await lyra.process(formToken);

        expect(
          lyraResponse,
          receivedLyraResponse,
        );
      });

      test('parse throw error', () async {
        const formToken = 'formToken';

        when(
          () => flutterLyraPlatform.process(formToken),
        ).thenThrow(Exception());

        registerFallbackValue(
          StackTrace.fromString('test'),
        );
        when(
          () => flutterLyraPlatform.parseError(any(), any()),
        ).thenThrow(Exception());

        try {
          await lyra.process(formToken);
        } catch (_) {}

        verify(() => flutterLyraPlatform.parseError(any(), any())).called(1);
      });
    });
  });
}
