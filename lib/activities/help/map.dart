import 'package:cotwcompanion/activities/help/help.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle_icon.dart';
import 'package:cotwcompanion/widgets/text/text_pattern.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityHelpMap extends ActivityHelp {
  const ActivityHelpMap({
    super.key,
  });

  List<Widget> _listFullscreen() {
    return [
      WidgetSubtitleIcon(
        tr("INTERFACE"),
        icon: Assets.graphics.icons.fullscreen,
      ),
      WidgetPadding.h30v20(child: WidgetTextPattern(tr("HELP_INTERFACE"))),
    ];
  }

  List<Widget> _listZoom() {
    return [
      WidgetSubtitleIcon(
        tr("PERFORMANCE_MODE"),
        icon: Assets.graphics.icons.hammer,
      ),
      WidgetPadding.h30v20(
        child: Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            WidgetTextPattern(tr("HELP_PERFORMANCE_MODE")),
            WidgetTextPattern(tr("HELP_PERFORMANCE_MODE_FIRST_ZOOM")),
            WidgetTextPattern(tr("HELP_PERFORMANCE_MODE_SECOND_ZOOM")),
            WidgetTextPattern(tr("HELP_PERFORMANCE_MODE_THIRD_ZOOM")),
          ],
        ),
      ),
    ];
  }

  List<Widget> _listZoneType() {
    return [
      WidgetSubtitleIcon(
        tr("HELP_NEED_ZONE"),
        icon: Assets.graphics.icons.zoneFeed,
      ),
      WidgetPadding.h30v20(child: WidgetTextPattern(tr("HELP_NEED_ZONE_INFO"))),
    ];
  }

  List<Widget> _listCircles() {
    return [
      WidgetSubtitleIcon(
        tr("HELP_CIRCLES"),
        icon: Assets.graphics.icons.other,
      ),
      WidgetPadding.h30v20(child: WidgetTextPattern(tr("HELP_CIRCLES_INFO"))),
    ];
  }

  List<Widget> _listZonesDisclaimer() {
    return [
      WidgetSubtitleIcon(
        tr("ANIMAL_NEED_ZONES"),
        icon: Assets.graphics.icons.needZones,
      ),
      WidgetPadding.h30v20(child: WidgetTextPattern(tr("HELP_ZONES_DISCLAIMER"))),
    ];
  }

  List<Widget> _listZoneCount() {
    return [
      WidgetSubtitleIcon(
        tr("HELP_ZONE_COUNT"),
        icon: Assets.graphics.icons.stats,
      ),
      WidgetPadding.h30v20(child: WidgetTextPattern(tr("HELP_ZONE_COUNT_INFO"))),
    ];
  }

  @override
  List<Widget> listHelp() {
    return [
      ..._listZonesDisclaimer(),
      ..._listFullscreen(),
      ..._listZoom(),
      ..._listZoneType(),
      ..._listCircles(),
      ..._listZoneCount(),
    ];
  }
}
