import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lyra/flutter_lyra.dart';

import '../const.dart';
import '../widgets/snackbar.dart';

class ProcessThenCancelMethod extends StatefulWidget {
  const ProcessThenCancelMethod({
    required this.dataSet,
    required this.lyra,
    required this.formToken,
    super.key,
  });

  final DataSet dataSet;
  final Lyra lyra;
  final String formToken;

  @override
  State<ProcessThenCancelMethod> createState() =>
      _ProcessThenCancelMethodMethodState();
}

class _ProcessThenCancelMethodMethodState
    extends State<ProcessThenCancelMethod> {
  bool areInteractionsDisabled = false;

  String? lyraResponse;
  Timer? timer;

  void setLyraResponse(String newLyraResponse) {
    setState(() {
      lyraResponse = newLyraResponse;
    });
  }

  Future<void> process() async {
    timer = Timer(const Duration(seconds: 15), widget.lyra.cancelProcess);
    setState(() {
      areInteractionsDisabled = true;
    });

    try {
      final result = await widget.lyra.process(widget.formToken);

      setLyraResponse(result);

      if (mounted) {
        showExampleSnackBar(
          context,
          message: 'Success - process - ${widget.dataSet.name}',
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
      timer?.cancel();
      setState(() {
        areInteractionsDisabled = false;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lyraResponse = this.lyraResponse;

    return ListView(
      children: [
        ElevatedButton(
          onPressed: !areInteractionsDisabled ? process : null,
          child: const Text('Process your payment then cancel'),
        ),
        if (lyraResponse != null) ...[
          const SizedBox(height: 32),
          Text(lyraResponse),
        ],
      ],
    );
  }
}
