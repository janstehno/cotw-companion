// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/help/abstract_help.dart';
import 'package:flutter/material.dart';

class ActivityHelpLogs extends ActivityHelp {
  const ActivityHelpLogs({
    super.key,
  });

  @override
  Widget buildBody() {
    return Column(children: [
      buildSearch(),
      buildSeparator(),
      buildAdd(),
      buildStats(),
      buildChangeView(),
      buildShowDate(),
      buildTrophyLodge(),
      buildEdit(),
      buildDeleteDoubleTap(),
      buildImportExport(),
    ]);
  }
}
