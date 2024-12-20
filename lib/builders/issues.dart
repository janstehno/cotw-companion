import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/lists/repository/items.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:flutter/material.dart';

class BuilderIssues extends BuilderBuilder {
  const BuilderIssues({
    super.key,
  }) : super("RI");

  @override
  State<StatefulWidget> createState() => BuilderIssuesState();
}

class BuilderIssuesState extends BuilderBuilderState {
  final List<dynamic> issues = [];

  @override
  void initializeData(AsyncSnapshot<Map<String, dynamic>> snapshot, BuildContext context) {
    issues.clear();
    issues.addAll(snapshot.data!["issues"] ?? []);
  }

  @override
  Future<Map<String, dynamic>> loadData() async {
    List<dynamic> issues = await Utils.getOpenIssues();
    updateProgress("issues", issues);
    await Future.delayed(const Duration(seconds: 1), () {});
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) => ListItems("REPO:ISSUES", items: issues);
}
