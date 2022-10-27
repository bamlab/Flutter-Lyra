import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/lyra.g.dart',
    javaOut:
        '../flutter_lyra_android/android/src/main/java/tech/bam/flutter_lyra/android/LyraApi.java',
    javaOptions: JavaOptions(
      package: 'tech.bam.flutter_lyra.android',
      className: 'LyraApi',
    ),
    objcHeaderOut: '../flutter_lyra_ios/ios/Classes/lyra_api.h',
    objcSourceOut: '../flutter_lyra_ios/ios/Classes/lyra_api.m',
  ),
)
class LyraInitializeOptionsInterface {
  const LyraInitializeOptionsInterface({
    required this.apiServerName,
    required this.nfcEnabled,
    required this.cardScanningEnabled,
  });

  final String apiServerName;
  final bool? nfcEnabled;
  final bool? cardScanningEnabled;
}

class LyraKeyInterface {
  const LyraKeyInterface({
    required this.publicKey,
    required this.options,
  });

  final String publicKey;
  final LyraInitializeOptionsInterface options;
}

@HostApi()
abstract class LyraHostApi {
  @async
  LyraKeyInterface initialize(LyraKeyInterface lyraKey);

  @async
  int getFormTokenVersion();
}
