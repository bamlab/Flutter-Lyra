import 'package:flutter/foundation.dart';
import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';

import '../flutter_lyra.dart';

/// Used to be the link between the [LyraInitializeOptionsInterface]
/// and the [LyraInitializeOptions] exported from this package
class LyraInitializeOptionsConverter {
  /// convert a [LyraInitializeOptions] to a [LyraInitializeOptionsInterface]
  static LyraInitializeOptionsInterface toInterface(
    LyraInitializeOptions lyraInitializeOptions,
  ) =>
      LyraInitializeOptionsInterface(
        apiServerName: lyraInitializeOptions.apiServerName,
        cardScanningEnabled: lyraInitializeOptions.cardScanningEnabled,
        nfcEnabled: lyraInitializeOptions.nfcEnabled,
        applePayMerchantId: defaultTargetPlatform == TargetPlatform.iOS
            ? lyraInitializeOptions.applePayMerchantId
            : null,
        applePayMerchantName: defaultTargetPlatform == TargetPlatform.iOS
            ? lyraInitializeOptions.applePayMerchantName
            : null,
      );

  /// convert a [LyraInitializeOptionsInterface] to a [LyraInitializeOptions]
  static LyraInitializeOptions fromInterface(
    LyraInitializeOptionsInterface lyraInitializeOptionInterface,
  ) =>
      LyraInitializeOptions(
        apiServerName: lyraInitializeOptionInterface.apiServerName,
        cardScanningEnabled: lyraInitializeOptionInterface.cardScanningEnabled,
        nfcEnabled: lyraInitializeOptionInterface.nfcEnabled,
        applePayMerchantId: lyraInitializeOptionInterface.applePayMerchantId,
        applePayMerchantName:
            lyraInitializeOptionInterface.applePayMerchantName,
      );
}
