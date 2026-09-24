import 'package:equatable/equatable.dart';

/// List of the lyra options you can use when processing a payment
class LyraProcessOptions extends Equatable {
  /// [LyraProcessOptions] default constructor
  const LyraProcessOptions({
    this.customPayButtonLabel,
    this.customHeaderLabel,
    this.customPopupLabel,
  });

  /// a [String] to replace the label of the pay button
  final String? customPayButtonLabel;

  /// a [String] to replace the header label of the payment form
  final String? customHeaderLabel;

  /// a [String] to replace the label of the payment form popup
  final String? customPopupLabel;

  @override
  List<Object?> get props => [
        customPayButtonLabel,
        customHeaderLabel,
        customPopupLabel,
      ];
}
