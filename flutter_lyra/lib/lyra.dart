import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';

import 'helpers/adapt_errors.dart';
import 'helpers/lyra_options_converter.dart';
import 'models/lyra_initialize_options.dart';

FlutterLyraPlatform get _platform => FlutterLyraPlatform.instance;

/// {@template flutter_lyra.lyra}
/// [Lyra], class used to call every lyra native sdk methods
///
/// There is only one native instance of [Lyra]
/// So every flutter instance created with this constructor
/// use the same native [Lyra] instance
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

  /// @template flutter_lyra.lyra.process}
  /// Process the paiement
  ///
  /// [timeout] is the duration after which the process will timeout and the
  /// process will be cancelled.
  ///
  /// If not specified, the process will not timeout.
  /// {@endtemplate}
  Future<String> process(
    String formToken, {
    Duration? timeout,
  }) async {
    try {
      final lyraResponse = await _platform.process(
        formToken,
        timeout: timeout,
      );

      return lyraResponse;
    } catch (error, stackTrace) {
      try {
        _platform.parseError(error, stackTrace);
      } catch (interfaceError, interfaceStackTrace) {
        adaptErrors(
          error: interfaceError,
          stackTrace: interfaceStackTrace,
        );
      }
    }
  }
}

/// {@template flutter_lyra.lyraManager}
/// [LyraManager], class used to initialize each instance of [Lyra]
/// {@endtemplate}
class LyraManager {
  /// {@template flutter_lyra.lyraManager.initialize}
  /// initialize function used to create an instance of [Lyra]
  ///
  /// on Android, this function can throw an uncatchable error
  /// Be sure to give the correct publicKey and options
  /// (It won't throw any errors if you are not connected to internet)
  // TODO: catch the errors on Android
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
