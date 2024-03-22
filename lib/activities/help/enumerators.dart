import 'package:cotwcompanion/activities/help/help.dart';
import 'package:flutter/material.dart';

class ActivityHelpEnumerators extends ActivityHelp {
  const ActivityHelpEnumerators({
    super.key,
  });

  @override
  List<Widget> listHelp() {
    return [
      buildSearch(),
      buildAdd(),
      ...listEdit(),
      ...listReorder(),
      ...listDeleteSwipeLeft(),
      ...listImportExport(),
    ];
  }
}
