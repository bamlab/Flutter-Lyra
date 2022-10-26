import 'package:flutter/material.dart';

import 'const.dart';
import 'views/lyra_methods_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSet = DataSets.firstDataSet;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Lyra Example \n ${dataSet.name}'),
        ),
        body: LyraMethodsView(
          dataSet: dataSet,
        ),
      ),
    );
  }
}
