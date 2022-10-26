import 'package:flutter/material.dart';
import 'package:flutter_lyra/flutter_lyra.dart';

import '../const.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/snackbar.dart';

class InitializeMethod extends StatefulWidget {
  const InitializeMethod({
    required this.dataSet,
    required this.lyra,
    required this.setLyra,
    super.key,
  });

  final DataSet dataSet;
  final Lyra? lyra;
  final void Function(Lyra lyra) setLyra;

  @override
  State<InitializeMethod> createState() => _InitializeMethodState();
}

class _InitializeMethodState extends State<InitializeMethod> {
  bool areInteractionsDisabled = false;

  late String publicKey = widget.dataSet.initialPublicKey;
  late String apiServerName = widget.dataSet.initialApiServerName;
  var nfcEnabled = false;
  var cardScanningEnabled = false;

  void setPublicKey(String newPublicKey) => setState(() {
        publicKey = newPublicKey;
      });

  void setApiServerName(String newApiServerName) => setState(() {
        apiServerName = newApiServerName;
      });

  void setNfcEnabled({required bool newNfcEnabled}) => setState(() {
        nfcEnabled = newNfcEnabled;
      });

  void setCardScanningEnabled({required bool newCardScanningEnabled}) =>
      setState(() {
        cardScanningEnabled = newCardScanningEnabled;
      });

  Future<void> initializeLyra() async {
    setState(() {
      areInteractionsDisabled = true;
    });

    try {
      final result = await LyraManager().initialize(
        publicKey: publicKey,
        options: LyraInitializeOptions(
          apiServerName: apiServerName,
          nfcEnabled: nfcEnabled,
          cardScanningEnabled: cardScanningEnabled,
        ),
      );

      widget.setLyra(result);

      if (mounted) {
        showExampleSnackBar(
          context,
          message: 'Success - Initialization - ${widget.dataSet.name}',
          type: SnackbarType.success,
        );
      }
    } catch (error) {
      if (mounted) {
        showExampleSnackBar(
          context,
          message: error.toString(),
          type: SnackbarType.error,
        );
      }
    } finally {
      setState(() {
        areInteractionsDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lyra = widget.lyra;
    final isButtonDisabled = areInteractionsDisabled || lyra != null;

    return ListView(
      children: [
        if (lyra == null) ...[
          CustomTextField(
            value: publicKey,
            hintText: 'publicKey',
            setValue: setPublicKey,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            value: apiServerName,
            hintText: 'apiServerName',
            setValue: setApiServerName,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('nfcEnabled'),
            value: nfcEnabled,
            onChanged: (value) => setNfcEnabled(newNfcEnabled: value),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('cardScanningEnabled'),
            value: cardScanningEnabled,
            onChanged: (value) =>
                setCardScanningEnabled(newCardScanningEnabled: value),
          ),
        ] else ...[
          Text('publicKey :${lyra.publicKey}'),
          const SizedBox(height: 16),
          Text('apiServerName :${lyra.options.apiServerName}'),
          const SizedBox(height: 16),
          Text(
            'nfcEnabled :${lyra.options.nfcEnabled}',
          ),
          const SizedBox(height: 16),
          Text('cardScanningEnabled :${lyra.options.cardScanningEnabled}'),
        ],
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: !isButtonDisabled ? initializeLyra : null,
          child: Text(
            lyra == null ? 'Get Lyra Config' : 'Lyra is already initialized',
          ),
        ),
      ],
    );
  }
}
