// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/help/abstract_help.dart';
import 'package:flutter/material.dart';

class ActivityHelpMap extends ActivityHelp {
  const ActivityHelpMap({
    super.key,
  });

  @override
  Widget buildBody() {
    return Column(children: [
      buildFullscreen(),
      buildZoom(),
      buildShowZoneType(),
      buildShowCircles(),
      buildAccuracy(),
    ]);
  }
}
