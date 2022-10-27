import 'package:equatable/equatable.dart';

/// List of the lyra options you can use during lyra initialization
class LyraInitializeOptions extends Equatable {
  /// [LyraInitializeOptions] default constructor
  const LyraInitializeOptions({
    required this.apiServerName,
    this.nfcEnabled,
    this.cardScanningEnabled,
  });

  /// a [String] that match your api server name
  final String apiServerName;

  /// on Android only, a [bool] to enable nfc
  ///
  /// Default to false
  ///
  /// android.permission.NFC must be added on AndroidManifest file
  final bool? nfcEnabled;

  /// a [bool] to allow card scanning
  ///
  /// Default to false
  ///
  /// on Android, cards-camera-recognizer dependency
  /// must be added on gradle file
  final bool? cardScanningEnabled;

  @override
  List<Object?> get props => [
        apiServerName,
        nfcEnabled,
        cardScanningEnabled,
      ];
}
