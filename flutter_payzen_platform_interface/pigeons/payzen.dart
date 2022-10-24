import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/payzen.g.dart',
    javaOut:
        '../flutter_payzen_android/android/src/main/java/tech/bam/flutter_payzen/android/PayzenApi.java',
    javaOptions: JavaOptions(
      package: 'tech.bam.flutter_payzen.android',
      className: 'PayzenApi',
    ),
    objcHeaderOut: '../flutter_payzen_ios/ios/Classes/payzen_api.h',
    objcSourceOut: '../flutter_payzen_ios/ios/Classes/payzen_api.m',
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
abstract class PayzenHostApi {
  @async
  LyraKeyInterface initialize(LyraKeyInterface lyraKey);
}
