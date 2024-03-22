import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/helpers/multimounts.dart';
import 'package:cotwcompanion/lists/other/multimounts.dart';
import 'package:cotwcompanion/model/translatable/multimount.dart';
import 'package:flutter/material.dart';

class BuilderMultimounts extends BuilderBuilder {
  const BuilderMultimounts({
    super.key,
  }) : super("MM");

  @override
  State<StatefulWidget> createState() => BuilderPlannerState();
}

class BuilderPlannerState extends BuilderBuilderState {
  final HelperMultimounts _helperMultimounts = HelperMultimounts();

  @override
  void initializeData(AsyncSnapshot<Map<String, dynamic>> snapshot, BuildContext context) {
    List<Multimount> multimounts = snapshot.data!["multimounts"] ?? [];
    _helperMultimounts.setMultimounts(multimounts);
  }

  @override
  Future<Map<String, dynamic>> loadData() async {
    List<Multimount> multimounts = await _helperMultimounts.readMultimounts();
    updateProgress("multimounts", multimounts);
    await Future.delayed(const Duration(seconds: 1), () {});
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) => ListMultimounts(helperMultimounts: _helperMultimounts);
}
