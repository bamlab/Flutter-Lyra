import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLyraHostApi extends Mock implements LyraHostApi {}

class TestFlutterLyra extends FlutterLyraPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('FlutterLyraPlatformInterface', () {
    late FlutterLyraPlatform flutterLyraPlatform;
    late LyraHostApi mockLyraHostApi;

    setUp(() {
      flutterLyraPlatform = TestFlutterLyra();
      FlutterLyraPlatform.instance = flutterLyraPlatform;

      mockLyraHostApi = MockLyraHostApi();

      flutterLyraPlatform.lyraHostApi = mockLyraHostApi;
    });

    tearDown(() {
      reset(mockLyraHostApi);
    });

    group('initialize', () {
      test('returns correct lyra config', () async {
        const publicKey = 'publicKey';
        final options = LyraInitializeOptionsInterface(
          apiServerName: 'apiServerName',
          cardScanningEnabled: true,
          nfcEnabled: false,
        );

        final lyraKeyInterface =
            LyraKeyInterface(publicKey: publicKey, options: options);

        registerFallbackValue(lyraKeyInterface);
        when(() => mockLyraHostApi.initialize(any()))
            .thenAnswer((_) async => lyraKeyInterface);

        final receivedLyraKeyInterface =
            await FlutterLyraPlatform.instance.initialize(
          publicKey: publicKey,
          options: options,
        );

        expect(lyraKeyInterface, receivedLyraKeyInterface);
      });
    });
  });
}
