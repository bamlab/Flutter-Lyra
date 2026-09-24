import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';

import '../models/lyra_process_options.dart';

/// Used to be the link between the [LyraProcessOptionsInterface]
/// and the [LyraProcessOptions] exported from this package
class LyraProcessOptionsConverter {
  /// convert a [LyraProcessOptions] to a [LyraProcessOptionsInterface]
  static LyraProcessOptionsInterface toInterface(
    LyraProcessOptions lyraProcessOptions,
  ) =>
      LyraProcessOptionsInterface(
        customPayButtonLabel: lyraProcessOptions.customPayButtonLabel,
        customHeaderLabel: lyraProcessOptions.customHeaderLabel,
        customPopupLabel: lyraProcessOptions.customPopupLabel,
      );
}
