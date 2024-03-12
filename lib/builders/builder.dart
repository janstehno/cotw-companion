// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/error.dart';
import 'package:cotwcompanion/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

abstract class BuilderBuilder extends StatefulWidget {
  final String builderId;

  const BuilderBuilder({
    Key? key,
    required this.builderId,
  }) : super(key: key);
}

abstract class BuilderBuilderState extends State<BuilderBuilder> {
  final GlobalKey<ProgressBarState> progressBarKey = GlobalKey<ProgressBarState>();
  late final List<dynamic> loadedData;

  void updateProgress(int id, dynamic data) {
    loadedData[id] = data;
    progressBarKey.currentState?.rebuild(id);
  }

  void initializeData(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {}

  loadData(BuildContext context) async {}

  buildFutureWidget(BuildContext context) {}

  Widget _buildLoadingWidget(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    if (snapshot.hasError) {
      return WidgetError(
        code: "Ex${widget.builderId}001",
        error: "${snapshot.error}",
        stack: "${snapshot.stackTrace}",
      );
    } else if (!snapshot.hasData) {
      return WidgetError(
        code: "Ex${widget.builderId}002",
        error: "Snapshot has no data.",
      );
    } else if (snapshot.data!.length != loadedData.length) {
      return WidgetError(
        code: "Ex${widget.builderId}003",
        error: "Snapshot data length is not correct.",
      );
    } else {
      initializeData(snapshot, context);
      return buildFutureWidget(context);
    }
  }

  Widget _buildWidgets(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Interface.body,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: ProgressBar(key: progressBarKey, data: loadedData.length),
        ),
        FutureBuilder(
          future: loadData(context),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox.shrink();
            } else {
              return _buildLoadingWidget(snapshot, context);
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
