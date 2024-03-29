import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lyra/flutter_lyra.dart';

import '../const.dart';
import '../widgets/snackbar.dart';

class ProcessWithTimeoutMethod extends StatefulWidget {
  const ProcessWithTimeoutMethod({
    required this.dataSet,
    required this.lyra,
    required this.formToken,
    super.key,
  });

  final DataSet dataSet;
  final Lyra lyra;
  final String formToken;

  @override
  State<ProcessWithTimeoutMethod> createState() =>
      _ProcessWithTimeoutMethodState();
}

class _ProcessWithTimeoutMethodState extends State<ProcessWithTimeoutMethod> {
  bool areInteractionsDisabled = false;

  String? lyraResponse;

  void setLyraResponse(String newLyraResponse) {
    setState(() {
      lyraResponse = newLyraResponse;
    });
  }

  Future<void> process() async {
    setState(() {
      areInteractionsDisabled = true;
    });

    try {
      final result = await widget.lyra.process(
        widget.formToken,
        timeout: const Duration(seconds: 10),
      );

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
      setState(() {
        areInteractionsDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lyraResponse = this.lyraResponse;

    return ListView(
      children: [
        ElevatedButton(
          onPressed: !areInteractionsDisabled ? process : null,
          child: const Text('Process your payment'),
        ),
        if (lyraResponse != null) ...[
          const SizedBox(height: 32),
          Text(lyraResponse),
        ],
      ],
    );
  }
}
