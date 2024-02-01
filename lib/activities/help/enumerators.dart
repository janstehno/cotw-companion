// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/help/help.dart';
import 'package:flutter/material.dart';

class ActivityHelpEnumerators extends ActivityHelp {
  const ActivityHelpEnumerators({
    super.key,
  });

  @override
  Widget buildBody() {
    return Column(children: [
      buildSearch(),
      buildAdd(),
      buildEdit(),
      buildMove(),
      buildDeleteSwipeLeft(),
      buildImportExport(),
    ]);
  }
}
