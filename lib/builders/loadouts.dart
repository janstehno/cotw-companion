// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/loadouts.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BuilderLoadouts extends StatelessWidget {
  const BuilderLoadouts({
    Key? key,
  }) : super(key: key);

  Future<Widget> _forcedDelay() async {
    return await Future.delayed(const Duration(seconds: 1), () => const ActivityLoadouts());
  }

  Widget _buildWidgets() {
    return FutureBuilder(
        future: Future.wait([HelperLoadout.readLoadouts(), _forcedDelay()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return WidgetError(text: snapshot.error.toString());
          } else if (snapshot.hasData) {
            var loadouts = snapshot.data![0] as List<Loadout>;
            var widget = snapshot.data![1] as Widget;
            HelperLoadout.setLoadouts(loadouts);
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
