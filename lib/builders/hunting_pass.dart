import 'package:cotwcompanion/activities/hunting_pass.dart';
import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/helpers/hunting_pass.dart';
import 'package:flutter/material.dart';

class BuilderHuntingPass extends BuilderBuilder {
  const BuilderHuntingPass({
    super.key,
  }) : super("P");

  @override
  State<StatefulWidget> createState() => BuilderHuntingPassState();
}

class BuilderHuntingPassState extends BuilderBuilderState {
  late final HelperHuntingPass _helperHuntingPass;

  @override
  void initState() {
    _helperHuntingPass = HelperHuntingPass();
    super.initState();
  }

  @override
  void initializeData(AsyncSnapshot<Map<String, dynamic>> snapshot, BuildContext context) {
    Map<String, dynamic> huntingPassFilter = snapshot.data!["huntingPassFilter"] ?? {};
    _helperHuntingPass.initFilter(huntingPassFilter);
  }

  @override
  Future<Map<String, dynamic>> loadData() async {
    Map<String, dynamic> huntingPassFilter = await _helperHuntingPass.readFilterFile();
    updateProgress("huntingPassFilter", huntingPassFilter);
    await Future.delayed(const Duration(seconds: 1), () {});
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) => ActivityHuntingPass(helperHuntingPass: _helperHuntingPass);
}
