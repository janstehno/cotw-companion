import 'package:cotwcompanion/activities/help/help.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle_icon.dart';
import 'package:cotwcompanion/widgets/text/text_pattern.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityHelpLogs extends ActivityHelp {
  const ActivityHelpLogs({
    super.key,
  });

  Widget _buildStats() {
    return WidgetSubtitleIcon(
      tr("STATS"),
      icon: Assets.graphics.icons.stats,
    );
  }

  Widget _buildChangeView() {
    return WidgetSubtitleIcon(
      tr("HELP_CHANGE_VIEW"),
      icon: Assets.graphics.icons.viewSemiCompact,
    );
  }

  Widget _buildShowDate() {
    return WidgetSubtitleIcon(
      tr("ENTRY_DATE"),
      icon: Assets.graphics.icons.sortDate,
    );
  }

  List<Widget> _listDeleteDoubleTap() {
    return [
      WidgetSubtitleIcon(
        tr("HELP_REMOVE_ALL"),
        icon: Assets.graphics.icons.removeBin,
      ),
      WidgetPadding.h30v20(child: WidgetTextPattern(tr("HELP_REMOVE_ONE_DOUBLE_TAP"))),
    ];
  }

  Widget _buildSeparator() {
    return WidgetSubtitleIcon(
      tr("HELP_SEPARATOR"),
      icon: Assets.graphics.icons.separator,
    );
  }

  List<Widget> _listTrophyLodge() {
    return [
      WidgetSubtitleIcon(
        tr("HELP_TROPHY_LODGE"),
        icon: Assets.graphics.icons.trophyLodge,
      ),
      WidgetPadding.h30v20(child: WidgetTextPattern(tr("HELP_TROPHY_LODGE_MOVE"))),
    ];
  }

  @override
  List<Widget> listHelp() {
    return [
      buildSearch(),
      _buildSeparator(),
      buildAdd(),
      _buildStats(),
      _buildChangeView(),
      _buildShowDate(),
      ..._listTrophyLodge(),
      ...listEdit(),
      ..._listDeleteDoubleTap(),
      ...listImportExport(),
    ];
  }
}
