// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/entries/enumerators.dart';
import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:flutter/material.dart';

class BuilderEnumerators extends BuilderBuilder {
  const BuilderEnumerators({
    super.key,
  }) : super(builderId: "E");

  @override
  State<StatefulWidget> createState() => BuilderEnumeratorsState();
}

class BuilderEnumeratorsState extends BuilderBuilderState {
  late final HelperEnumerator _helperEnumerator;

  @override
  void initState() {
    _helperEnumerator = HelperEnumerator();
    loadedData = [null];
    super.initState();
  }

  @override
  void initializeData(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    List<Enumerator> enumerators = snapshot.data![0] ?? [];
    _helperEnumerator.setEnumerators(enumerators);
  }

  @override
  Future<List<dynamic>> loadData(BuildContext context) async {
    List<Enumerator> enumerators = await _helperEnumerator.readFile();
    updateProgress(0, enumerators);
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) {
    return ActivityEnumerators(helperEnumerator: _helperEnumerator);
  }
}
