import 'package:flutter/material.dart';
import 'package:flutter_lyra/flutter_lyra.dart';

import '../const.dart';
import '../widgets/snackbar.dart';

class GetFormTokenVersionMethod extends StatefulWidget {
  const GetFormTokenVersionMethod({
    required this.dataSet,
    required this.lyra,
    required this.formTokenVersion,
    required this.setFormTokenVersion,
    super.key,
  });

  final DataSet dataSet;
  final Lyra lyra;
  final int? formTokenVersion;
  final void Function(int newFormTokenVersion) setFormTokenVersion;

  @override
  State<GetFormTokenVersionMethod> createState() =>
      _GetFormTokenVersionMethodState();
}

class _GetFormTokenVersionMethodState extends State<GetFormTokenVersionMethod> {
  bool areInteractionsDisabled = false;

  Future<void> getFormTokenVersion() async {
    setState(() {
      areInteractionsDisabled = true;
    });

    try {
      final result = await widget.lyra.getFormTokenVersion();

      widget.setFormTokenVersion(result);

      if (mounted) {
        showExampleSnackBar(
          context,
          message: 'Success - getFormTokenVersion - ${widget.dataSet.name}',
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
    final formTokenVersion = widget.formTokenVersion;
    final isButtonDisabled =
        areInteractionsDisabled || formTokenVersion != null;

    return ListView(
      children: [
        if (formTokenVersion != null) ...[
          Text('formTokenVersion :$formTokenVersion'),
          const SizedBox(height: 32),
        ],
        ElevatedButton(
          onPressed: !isButtonDisabled ? getFormTokenVersion : null,
          child: Text(
            formTokenVersion == null
                ? 'Get Form Token Version'
                : "You've already got your form token version",
          ),
        ),
      ],
    );
  }
}
