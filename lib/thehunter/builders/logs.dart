// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_log.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/logs.dart';
import 'package:cotwcompanion/thehunter/model/log.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BuilderLogs extends StatelessWidget {
  final bool trophyLodge;

  const BuilderLogs({Key? key, required this.trophyLodge}) : super(key: key);

  Future<Widget> _forcedDelay() async {
    return await Future.delayed(const Duration(seconds: 1), () => ActivityLogs(trophyLodge: trophyLodge));
  }

  Widget _buildWidgets() {
    return FutureBuilder(
        future: Future.wait([LogHelper.readLogs(), _forcedDelay()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return WidgetError(text: snapshot.error.toString());
          } else if (snapshot.hasData) {
            var logs = snapshot.data![0] as List<Log>;
            var widget = snapshot.data![1] as Widget;
            LogHelper.setLogs(logs, context);
            return widget;
          } else {
            return Container(padding: const EdgeInsets.all(30), color: Color(Values.colorBody), child: SpinKitThreeBounce(size: 30, color: Color(Values.colorDark)));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
