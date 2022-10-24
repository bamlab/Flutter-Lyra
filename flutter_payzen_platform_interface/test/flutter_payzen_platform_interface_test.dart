import 'package:flutter_payzen_platform_interface/flutter_payzen_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPayzenHostApi extends Mock implements PayzenHostApi {}

class TestFlutterPayzen extends FlutterPayzenPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('FlutterPayzenPlatformInterface', () {
    late FlutterPayzenPlatform flutterPayzenPlatform;
    late PayzenHostApi mockPayzenHostApi;

    setUp(() {
      flutterPayzenPlatform = TestFlutterPayzen();
      FlutterPayzenPlatform.instance = flutterPayzenPlatform;

      mockPayzenHostApi = MockPayzenHostApi();

      flutterPayzenPlatform.payzenHostApi = mockPayzenHostApi;
    });

    tearDown(() {
      reset(mockPayzenHostApi);
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
        when(() => mockPayzenHostApi.initialize(any()))
            .thenAnswer((_) async => lyraKeyInterface);

        final receivedLyraKeyInterface =
            await FlutterPayzenPlatform.instance.initialize(
          publicKey: publicKey,
          options: options,
        );

        expect(lyraKeyInterface, receivedLyraKeyInterface);
      });
    });
  });
}
