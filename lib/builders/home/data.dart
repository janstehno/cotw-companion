// Copyright (c) 2023 Jan Stehno

import 'dart:async';

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class BuilderData extends StatelessWidget {
  final List<Future<dynamic>> _toLoad;
  final Widget _nextWidget;
  final double _indicatorSize = 20;

  const BuilderData({
    Key? key,
    required toLoad,
    required nextWidget,
  })  : _toLoad = toLoad,
        _nextWidget = nextWidget,
        super(key: key);

  void initializeData(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {}

  Widget _loadingScreen() {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Container(
          color: Interface.body,
          padding: const EdgeInsets.all(30),
          child: SpinKitThreeBounce(
            size: _indicatorSize,
            color: Interface.dark,
          ),
        );
      },
    );
  }

  Widget _buildHome(AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    if (snapshot.hasError) {
      return WidgetError(
        code: "Ex0001",
        error: "${snapshot.error}",
        stack: "${snapshot.stackTrace}",
      );
    } else if (!snapshot.hasData) {
      return const WidgetError(
        code: "Ex0002",
        error: "Snapshot has no data.",
      );
    } else if (snapshot.data!.length != _toLoad.length) {
      return const WidgetError(
        code: "Ex0003",
        error: "Snapshot data length is not correct.",
      );
    } else {
      initializeData(snapshot, context);
      return _nextWidget;
    }
  }

  Widget _buildWidgets(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(_toLoad),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _loadingScreen();
        } else {
          return _buildHome(snapshot, context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
