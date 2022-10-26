import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';

import 'helpers/lyra_options_converter.dart';
import 'models/lyra_initialize_options.dart';

FlutterLyraPlatform get _platform => FlutterLyraPlatform.instance;

/// {@template flutter_lyra.lyra}
/// [Lyra], class used to call every lyra native sdk methods
/// {@endtemplate}
class Lyra {
  /// [Lyra] default constructor
  const Lyra({
    required this.publicKey,
    required this.options,
  });

  /// @template flutter_lyra.lyra.publicKey}
  /// [Lyra] public key used when initializing the instance
  /// {@endtemplate}
  final String publicKey;

  /// @template flutter_lyra.lyra.options}
  /// [Lyra] list of options used when initializing the instance
  /// {@endtemplate}
  final LyraInitializeOptions options;

  /// @template flutter_lyra.lyra.getFormTokenVersion}
  /// Get the form token version link to this sdk version
  ///
  /// You need to add it to your paiement request
  /// {@endtemplate}
  Future<int> getFormTokenVersion() async {
    final formTokenVersion = await _platform.getFormTokenVersion();

    return formTokenVersion;
  }
}

/// {@template flutter_lyra.lyraManager}
/// [LyraManager], class used to initialize each instance of [Lyra]
/// {@endtemplate}
class LyraManager {
  /// {@template flutter_lyra.lyraManager.initialize}
  /// initialize function used to create an instance of [Lyra]
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
