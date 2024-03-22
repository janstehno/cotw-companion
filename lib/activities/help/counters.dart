import 'package:cotwcompanion/activities/help/help.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle_icon.dart';
import 'package:cotwcompanion/widgets/text/text_pattern.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityHelpCounters extends ActivityHelp {
  const ActivityHelpCounters({
    super.key,
  });

  List<Widget> _listChangeValue() {
    return [
      WidgetSubtitleIcon(
        tr("HELP_CHANGE_VALUE"),
        icon: Assets.graphics.icons.number,
      ),
      WidgetPadding.h30v20(
        child: Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            WidgetTextPattern(tr("HELP_ADD_VALUE")),
            WidgetTextPattern(tr("HELP_SUBTRACT_VALUE")),
          ],
        ),
      ),
    ];
  }

  @override
  List<Widget> listHelp() {
    return [
      buildAdd(),
      ..._listChangeValue(),
      ...listEdit(),
      ...listReorder(),
      ...listDeleteSwipeLeft(),
    ];
  }
}
