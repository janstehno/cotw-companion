import 'package:cotwcompanion/activities/entries/enumerators.dart';
import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/helpers/enumerator.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:flutter/material.dart';

class BuilderEnumerators extends BuilderBuilder {
  const BuilderEnumerators({
    super.key,
  }) : super("E");

  @override
  State<StatefulWidget> createState() => BuilderEnumeratorsState();
}

class BuilderEnumeratorsState extends BuilderBuilderState {
  final HelperEnumerator _helperEnumerator = HelperEnumerator();

  @override
  void initializeData(AsyncSnapshot<Map<String, dynamic>> snapshot, BuildContext context) {
    List<Enumerator> enumerators = snapshot.data!["enumerators"] ?? [];
    _helperEnumerator.setEnumerators(enumerators);
  }

  @override
  Future<Map<String, dynamic>> loadData() async {
    List<Enumerator> enumerators = await _helperEnumerator.readFile();
    updateProgress("enumerators", enumerators);
    await Future.delayed(const Duration(seconds: 1), () {});
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) {
    return ActivityEnumerators(helperEnumerator: _helperEnumerator);
  }
}
