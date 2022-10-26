import 'package:flutter/material.dart';
import 'package:flutter_payzen/flutter_payzen.dart';

import '../const.dart';
import '../methods/initialize_method.dart';

enum PayzenMethod {
  initialize,
}

class PayzenMethodsView extends StatefulWidget {
  const PayzenMethodsView({
    required this.dataSet,
    super.key,
  });

  final DataSet dataSet;

  @override
  State<PayzenMethodsView> createState() => _PayzenMethodsViewState();
}

class _PayzenMethodsViewState extends State<PayzenMethodsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var selectedPayzenMethod = PayzenMethod.initialize;

  void setSelectedPayzenMethod(PayzenMethod newSelectedReachFiveMethod) =>
      setState(() {
        selectedPayzenMethod = newSelectedReachFiveMethod;
      });

  Lyra? lyra;

  void setLyra(Lyra newLyra) => setState(() {
        lyra = newLyra;
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
          DropdownButton<PayzenMethod>(
            value: selectedPayzenMethod,
            items: PayzenMethod.values
                .map(
                  (lyraMethod) => DropdownMenuItem<PayzenMethod>(
                    value: lyraMethod,
                    child: Text(lyraMethod.name),
                  ),
                )
                .toList(),
            onChanged: (lyraMethod) =>
                lyraMethod != null ? setSelectedPayzenMethod(lyraMethod) : null,
          ),
          Expanded(
            child: _PayzenMethodView(
              dataSet: widget.dataSet,
              payzenMethod: selectedPayzenMethod,
              lyra: lyra,
              setLyra: setLyra,
            ),
          ),
        ],
      ),
    );
  }
}

class _PayzenMethodView extends StatelessWidget {
  const _PayzenMethodView({
    required this.dataSet,
    required this.payzenMethod,
    required this.lyra,
    required this.setLyra,
  });

  final DataSet dataSet;

  final PayzenMethod payzenMethod;

  final Lyra? lyra;
  final void Function(Lyra) setLyra;

  @override
  Widget build(BuildContext context) {
    final payzenMethod = this.payzenMethod;
    final lyra = this.lyra;

    switch (payzenMethod) {
      case PayzenMethod.initialize:
        return InitializeMethod(
          dataSet: dataSet,
          lyra: lyra,
          setLyra: setLyra,
        );
    }
  }
}
