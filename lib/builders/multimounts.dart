// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/lists/other/multimounts.dart';
import 'package:cotwcompanion/miscellaneous/helpers/multimounts.dart';
import 'package:cotwcompanion/model/multimount.dart';
import 'package:flutter/material.dart';

class BuilderMultimounts extends BuilderBuilder {
  const BuilderMultimounts({
    super.key,
  }) : super(builderId: "MM");

  @override
  State<StatefulWidget> createState() => BuilderPlannerState();
}

class BuilderPlannerState extends BuilderBuilderState {
  late final HelperMultimounts _helperMultimounts;

  @override
  void initState() {
    _helperMultimounts = HelperMultimounts();
    loadedData = [null];
    super.initState();
  }

  @override
  void initializeData(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    List<Multimount> multimounts = snapshot.data![0] ?? [];
    _helperMultimounts.setMultimounts(multimounts);
  }

  @override
  Future<List<dynamic>> loadData(BuildContext context) async {
    List<Multimount> multimounts = await _helperMultimounts.readMultimounts();
    updateProgress(0, multimounts);
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) {
    return ListMultimounts(helperMultimounts: _helperMultimounts);
  }
}
