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
  });

  final String apiServerName;
  final bool? nfcEnabled;
  final bool? cardScanningEnabled;
  final String? applePayMerchantId;
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
  @async
  LyraKeyInterface initialize(LyraKeyInterface lyraKey);

  @async
  int getFormTokenVersion();

  @async
  String process(ProcessRequestInterface request);
}
