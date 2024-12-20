import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/lists/repository/items.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:flutter/material.dart';

class BuilderDiscussions extends BuilderBuilder {
  const BuilderDiscussions({
    super.key,
  }) : super("RD");

  @override
  State<StatefulWidget> createState() => BuilderDiscussionsState();
}

class BuilderDiscussionsState extends BuilderBuilderState {
  final List<dynamic> discussions = [];

  @override
  void initializeData(AsyncSnapshot<Map<String, dynamic>> snapshot, BuildContext context) {
    discussions.clear();
    discussions.addAll(snapshot.data!["discussions"] ?? []);
  }

  @override
  Future<Map<String, dynamic>> loadData() async {
    List<dynamic> issues = await Utils.getOpenDiscussions();
    updateProgress("discussions", issues);
    await Future.delayed(const Duration(seconds: 1), () {});
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) => ListItems("REPO:DISCUSSIONS", items: discussions);
}
