// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/help/abstract_help.dart';
import 'package:flutter/material.dart';

class ActivityHelpCounters extends ActivityHelp {
  const ActivityHelpCounters({
    super.key,
  });

  @override
  Widget buildBody() {
    return Column(children: [
      buildAdd(),
      buildChangeValue(),
      buildEdit(),
      buildMove(),
      buildDeleteSwipeLeft(),
    ]);
  }
}
