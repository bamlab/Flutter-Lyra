import 'package:flutter/material.dart';
import 'package:flutter_lyra/flutter_lyra.dart';

import '../const.dart';
import '../methods/get_form_token_version.dart';
import '../methods/initialize_method.dart';

enum LyraMethod {
  initialize,
  getFormTokenVersion,
}

class LyraMethodsView extends StatefulWidget {
  const LyraMethodsView({
    required this.dataSet,
    super.key,
  });

  final DataSet dataSet;

  @override
  State<LyraMethodsView> createState() => _LyraMethodsViewState();
}

class _LyraMethodsViewState extends State<LyraMethodsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var selectedLyraMethod = LyraMethod.initialize;

  void setSelectedLyraMethod(LyraMethod newSelectedLyraMethod) => setState(() {
        selectedLyraMethod = newSelectedLyraMethod;
      });

  Lyra? lyra;

  void setLyra(Lyra newLyra) => setState(() {
        lyra = newLyra;
      });

  int? formTokenVersion;

  void setFormTokenVersion(int newFormTokenVersion) => setState(() {
        formTokenVersion = newFormTokenVersion;
      });

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final lyra = this.lyra;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          const SizedBox(width: double.infinity),
          DropdownButton<LyraMethod>(
            value: selectedLyraMethod,
            items: LyraMethod.values
                .map(
                  (lyraMethod) => DropdownMenuItem<LyraMethod>(
                    value: lyraMethod,
                    child: Text(lyraMethod.name),
                  ),
                )
                .toList(),
            onChanged: (lyraMethod) =>
                lyraMethod != null ? setSelectedLyraMethod(lyraMethod) : null,
          ),
          Expanded(
            child: _LyraMethodView(
              dataSet: widget.dataSet,
              lyraMethod: selectedLyraMethod,
              lyra: lyra,
              setLyra: setLyra,
              formTokenVersion: formTokenVersion,
              setFormTokenVersion: setFormTokenVersion,
            ),
          ),
        ],
      ),
    );
  }
}

class _LyraMethodView extends StatelessWidget {
  const _LyraMethodView({
    required this.dataSet,
    required this.lyraMethod,
    required this.lyra,
    required this.setLyra,
    required this.formTokenVersion,
    required this.setFormTokenVersion,
  });

  final DataSet dataSet;

  final LyraMethod lyraMethod;

  final Lyra? lyra;
  final void Function(Lyra) setLyra;

  final int? formTokenVersion;
  final void Function(int) setFormTokenVersion;

  @override
  Widget build(BuildContext context) {
    final lyraMethod = this.lyraMethod;
    final lyra = this.lyra;

    switch (lyraMethod) {
      case LyraMethod.initialize:
        return InitializeMethod(
          dataSet: dataSet,
          lyra: lyra,
          setLyra: setLyra,
        );
      case LyraMethod.getFormTokenVersion:
        if (lyra != null) {
          return GetFormTokenVersionMethod(
            dataSet: dataSet,
            lyra: lyra,
            formTokenVersion: formTokenVersion,
            setFormTokenVersion: setFormTokenVersion,
          );
        }
        return const Text('You should initialize Lyra');
    }
  }
}
