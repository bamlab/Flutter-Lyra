import 'package:flutter_lyra_platform_interface/src/method_channel_flutter_lyra.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('$MethodChannelFlutterLyra parseError method throw an error', () async {
    Object? error;
    try {
      MethodChannelFlutterLyra()
          .parseError('erreur', StackTrace.fromString('stackTrace'));
    } catch (e) {
      error = e;
    }

    expect(error, isA<UnimplementedError>());
  });
}
