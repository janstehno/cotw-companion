// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/logs.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BuilderLogs extends StatelessWidget {
  final bool trophyLodge;

  const BuilderLogs({
    Key? key,
    required this.trophyLodge,
  }) : super(key: key);

  Future<Widget> _forcedDelay() async {
    return await Future.delayed(const Duration(seconds: 1), () => ActivityLogs(trophyLodge: trophyLodge));
  }

  Widget _buildWidgets() {
    return FutureBuilder(
        future: Future.wait([HelperLog.readLogs(), _forcedDelay()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return WidgetError(text: snapshot.error.toString());
          } else if (snapshot.hasData) {
            var logs = snapshot.data![0] as List<Log>;
            var widget = snapshot.data![1] as Widget;
            HelperLog.setLogs(logs);
            return widget;
          } else {
            return Container(
              padding: const EdgeInsets.all(30),
              color: Interface.mainBody,
              child: SpinKitThreeBounce(size: 30, color: Interface.dark),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
