import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle_icon.dart';
import 'package:cotwcompanion/widgets/text/text_pattern.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class ActivityHelp extends StatelessWidget {
  const ActivityHelp({
    super.key,
  });

  Widget buildAdd() {
    return WidgetSubtitleIcon(
      tr("HELP_ADD"),
      icon: Assets.graphics.icons.plus,
    );
  }

  List<Widget> listEdit() {
    return [
      WidgetSubtitleIcon(
        tr("HELP_EDIT"),
        icon: Assets.graphics.icons.edit,
      ),
      WidgetPadding.h30v20(
        child: WidgetTextPattern(
          tr("HELP_EDIT_SWIPE_RIGHT"),
        ),
      ),
    ];
  }

  List<Widget> listReorder() {
    return [
      WidgetSubtitleIcon(
        tr("HELP_ENTRY_MOVE"),
        icon: Assets.graphics.icons.sort,
      ),
      WidgetPadding.h30v20(
        child: WidgetTextPattern(
          tr("HELP_ENTRY_REORDER_INFO"),
        ),
      ),
    ];
  }

  List<Widget> listDeleteSwipeLeft() {
    return [
      WidgetSubtitleIcon(
        tr("HELP_REMOVE_ALL"),
        icon: Assets.graphics.icons.removeBin,
      ),
      WidgetPadding.h30v20(
        child: WidgetTextPattern(
          tr("HELP_REMOVE_ONE_SWIPE_LEFT"),
        ),
      ),
    ];
  }

  Widget buildSearch() {
    return WidgetSubtitleIcon(
      tr("HELP_SEARCH"),
      icon: Assets.graphics.icons.search,
    );
  }

  List<Widget> listImportExport() {
    return [
      WidgetSubtitleIcon(
        tr("FILE_EXPORT"),
        icon: Assets.graphics.icons.export,
      ),
      WidgetSubtitleIcon(
        tr("FILE_IMPORT"),
        icon: Assets.graphics.icons.import,
      ),
      WidgetPadding.h30v20(
        child: Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            WidgetTextPattern(tr("HELP_EXPORT")),
            WidgetTextPattern(tr("HELP_IMPORT")),
            WidgetTextPattern(tr("HELP_PERMISSION")),
          ],
        ),
      ),
    ];
  }

  List<Widget> listHelp();

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr("HELP"),
        context: context,
      ),
      children: listHelp(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
