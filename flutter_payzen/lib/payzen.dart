import 'package:flutter_payzen_platform_interface/flutter_payzen_platform_interface.dart';

import 'helpers/lyra_options_converter.dart';
import 'models/lyra_initialize_options.dart';

FlutterPayzenPlatform get _platform => FlutterPayzenPlatform.instance;

/// {@template flutter_payzen.lyra}
/// [Lyra], class used to call every reachFive native sdk methods
/// {@endtemplate}
class Lyra {
  /// [Lyra] default constructor
  const Lyra({
    required this.publicKey,
    required this.options,
  });

  /// @template flutter_payzen.lyra.publicKey}
  /// [Lyra] public key used when initializing the instance
  /// {@endtemplate}
  final String publicKey;

  /// @template flutter_payzen.lyra.options}
  /// [Lyra] list of options used when initializing the instance
  /// {@endtemplate}
  final LyraInitializeOptions options;
}

/// {@template flutter_payzen.lyraManager}
/// ReachFiveManager, class used to initialize each instance of ReachFive
/// {@endtemplate}
class LyraManager {
  /// {@template flutter_payzen.lyraManager.initialize}
  /// initialize function used to create an instance of ReachFive
  /// {@endtemplate}
  Future<Lyra> initialize({
    required String publicKey,
    required LyraInitializeOptions options,
  }) async {
    final lyraKeyInterface = await _platform.initialize(
      publicKey: publicKey,
      options: LyraInitializeOptionsConverter.toInterface(options),
    );

    return Lyra(
      publicKey: lyraKeyInterface.publicKey,
      options: LyraInitializeOptionsConverter.fromInterface(
        lyraKeyInterface.options,
      ),
    );
  }
}
