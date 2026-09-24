import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/lyra.g.dart',
    kotlinOut:
        '../flutter_lyra_android/android/src/main/kotlin/tech/bam/flutter_lyra/android/LyraApi.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'tech.bam.flutter_lyra.android',
    ),
    swiftOut:
        '../flutter_lyra_ios/ios/flutter_lyra_ios/Sources/flutter_lyra_ios/LyraApi.g.swift',
  ),
)
class ErrorCodesInterface {
  const ErrorCodesInterface({
    required this.paymentCancelledByUser,
  });

  final String paymentCancelledByUser;
}

class LyraInitializeOptionsInterface {
  const LyraInitializeOptionsInterface({
    required this.apiServerName,
    required this.nfcEnabled,
    required this.cardScanningEnabled,
    required this.applePayMerchantId,
    required this.applePayMerchantName,
  });

  final String apiServerName;
  final bool? nfcEnabled;
  final bool? cardScanningEnabled;
  final String? applePayMerchantId;
  final String? applePayMerchantName;
}

class LyraKeyInterface {
  const LyraKeyInterface({
    required this.publicKey,
    required this.options,
  });

  final String publicKey;
  final LyraInitializeOptionsInterface options;
}

class ProcessRequestInterface {
  const ProcessRequestInterface({
    required this.formToken,
    required this.errorCodes,
    this.timeoutInSeconds,
  });

  final String formToken;
  final ErrorCodesInterface errorCodes;
  final int? timeoutInSeconds;
}

@HostApi()
abstract class LyraHostApi {
  @asyncCallback
  LyraKeyInterface initialize(LyraKeyInterface lyraKey);

  @asyncCallback
  int getFormTokenVersion();

  @asyncCallback
  String process(ProcessRequestInterface request);
}
