// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/help/help.dart';
import 'package:flutter/material.dart';

class ActivityHelpMap extends ActivityHelp {
  const ActivityHelpMap({
    super.key,
  });

  @override
  Widget buildBody() {
    return Column(children: [
      buildZonesDisclaimer(),
      buildFullscreen(),
      buildZoom(),
      buildShowZoneType(),
      buildShowCircles(),
      buildZoneCount(),
    ]);
  }
}
