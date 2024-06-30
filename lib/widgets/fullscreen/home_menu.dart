import 'package:cotwcompanion/activities/about.dart';
import 'package:cotwcompanion/activities/entries/loadouts.dart';
import 'package:cotwcompanion/activities/entries/logs.dart';
import 'package:cotwcompanion/activities/need_zones.dart';
import 'package:cotwcompanion/activities/search.dart';
import 'package:cotwcompanion/activities/settings.dart';
import 'package:cotwcompanion/builders/enumerators.dart';
import 'package:cotwcompanion/builders/hunting_pass.dart';
import 'package:cotwcompanion/builders/multimounts.dart';
import 'package:cotwcompanion/builders/planner.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/lists/home/callers.dart';
import 'package:cotwcompanion/lists/home/reserves.dart';
import 'package:cotwcompanion/lists/home/weapons.dart';
import 'package:cotwcompanion/lists/home/wildlife.dart';
import 'package:cotwcompanion/lists/other/dlcs.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/parts/home/menu.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/text/text_tap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetHomeMenu extends StatefulWidget {
  final Function _callback;

  const WidgetHomeMenu({
    super.key,
    required Function callback,
  }) : _callback = callback;

  Function get callback => _callback;

  @override
  WidgetHomeMenuState createState() => WidgetHomeMenuState();
}

class WidgetHomeMenuState extends State<WidgetHomeMenu> {
  final List<List<dynamic>> _general = [
    ["RESERVES", Assets.graphics.icons.reserve, const ListReserves()],
    ["WILDLIFE", Assets.graphics.icons.wildlife, const ListWildlife()],
    ["WEAPONS", Assets.graphics.icons.weapon, const ListWeapons()],
    ["CALLERS", Assets.graphics.icons.caller, const ListCallers()],
    ["SEARCH", Assets.graphics.icons.search, const ActivitySearch()],
  ];

  final List<List<dynamic>> _tools = [
    ["ANIMAL_NEED_ZONES", Assets.graphics.icons.needZones, const ActivityNeedZones()],
    ["TROPHY_LODGE", Assets.graphics.icons.trophyLodge, const ActivityLogs(trophyLodge: true)],
    ["LOGBOOK", Assets.graphics.icons.catchBook, const ActivityLogs(trophyLodge: false)],
    ["LOADOUTS", Assets.graphics.icons.loadout, const ActivityLoadouts()],
    ["COUNTERS", Assets.graphics.icons.number, const BuilderEnumerators()],
    ["HUNTING_PASS", Assets.graphics.icons.pass, const BuilderHuntingPass()],
    ["PLANNER", Assets.graphics.icons.planner, const BuilderPlanner()],
  ];

  final List<List<dynamic>> _other = [
    ["CONTENT_MATMATS_MULTIMOUNTS", Assets.graphics.icons.hammer, const BuilderMultimounts()],
    ["CONTENT_DOWNLOADABLE_CONTENT", Assets.graphics.icons.dlc, const ListDlcs()],
  ];

  Widget _buildMenuItem(String text, String icon, Widget activity, BuildContext context) {
    return WidgetSectionMenu(tr(text), icon: icon, onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (e) => activity));
    });
  }

  Widget _buildHeader() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WidgetIcon.withSize(
          Assets.graphics.icons.wildlife,
          color: Interface.dark,
          size: Values.menu,
        ),
        WidgetButtonIcon(
          Assets.graphics.icons.menuClose,
          color: Interface.dark,
          background: Interface.transparent,
          onTap: () {
            widget.callback();
          },
        ),
      ],
    );
  }

  List<Widget> _listGeneral() {
    return [
      WidgetMargin.fromLTRB(
        0,
        40,
        0,
        10,
        child: WidgetText(
          tr("GENERAL").toUpperCase(),
          color: Interface.dark,
          style: Style.condensed.s24.w600,
        ),
      ),
      ..._general.map((e) => _buildMenuItem(e.elementAt(0), e.elementAt(1), e.elementAt(2), context)),
    ];
  }

  List<Widget> _listTools() {
    return [
      WidgetMargin.fromLTRB(
        0,
        30,
        0,
        10,
        child: WidgetText(
          tr("TOOLS").toUpperCase(),
          color: Interface.dark,
          style: Style.condensed.s24.w600,
        ),
      ),
      ..._tools.map((e) => _buildMenuItem(e.elementAt(0), e.elementAt(1), e.elementAt(2), context)),
    ];
  }

  List<Widget> _listOther() {
    return [
      WidgetMargin.fromLTRB(
        0,
        30,
        0,
        10,
        child: WidgetText(
          tr("OTHER").toUpperCase(),
          color: Interface.dark,
          style: Style.condensed.s24.w600,
        ),
      ),
      ..._other.map((e) => _buildMenuItem(e.elementAt(0), e.elementAt(1), e.elementAt(2), context)),
    ];
  }

  List<Widget> _listUncategorized() {
    return [
      WidgetSectionMenu(tr("SETTINGS"), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => ActivitySettings(callback: () {
              setState(() {});
            }),
          ),
        );
      }),
      WidgetSectionMenu(tr("ABOUT"), onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (e) => const ActivityAbout()));
      }),
    ];
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WidgetTextTap(
          tr("WIKI").toUpperCase(),
          color: Interface.dark.withOpacity(0.8),
          style: Style.normal.s8.w500,
          onTap: () => Utils.redirectTo(
            Uri.parse("https://github.com/janstehno/cotw-companion/wiki"),
          ),
        ),
        const SizedBox(width: 10),
        WidgetTextTap(
          tr("PATCH_NOTES").toUpperCase(),
          color: Interface.dark.withOpacity(0.8),
          style: Style.normal.s8.w500,
          onTap: () => Utils.redirectTo(
            Uri.parse("https://github.com/janstehno/cotw-companion/wiki/Patch-notes"),
          ),
        ),
        const SizedBox(width: 10),
        WidgetTextTap(
          tr("IDEAS").toUpperCase(),
          color: Interface.dark.withOpacity(0.8),
          style: Style.normal.s8.w500,
          onTap: () => Utils.redirectTo(
            Uri.parse("https://github.com/janstehno/cotw-companion/discussions"),
          ),
        ),
        const SizedBox(width: 10),
        WidgetTextTap(
          tr("ISSUES").toUpperCase(),
          color: Interface.dark.withOpacity(0.8),
          style: Style.normal.s8.w500,
          onTap: () => Utils.redirectTo(
            Uri.parse("https://github.com/janstehno/cotw-companion/issues"),
          ),
        ),
      ],
    );
  }

  List<Widget> _listItems(BuildContext context) {
    return [
      _buildHeader(),
      ..._listGeneral(),
      ..._listTools(),
      ..._listOther(),
      const SizedBox(height: 30),
      ..._listUncategorized(),
      const SizedBox(height: 30),
      _buildFooter(),
      const SizedBox(height: 15),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: WidgetPadding.all(
          40,
          background: Interface.body,
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _listItems(context),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
