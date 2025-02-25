import 'package:cotwcompanion/builders/map.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_animals.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_callers.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_environment.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_missions.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_weapons.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:cotwcompanion/widgets/title/title_image_tap.dart';
import 'package:cotwcompanion/widgets/title/title_switch_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailReserve extends StatefulWidget {
  final Reserve _reserve;

  const ActivityDetailReserve(
    Reserve reserve, {
    super.key,
  }) : _reserve = reserve;

  Reserve get reserve => _reserve;

  @override
  State<StatefulWidget> createState() => ActivityDetailReserveState();
}

class ActivityDetailReserveState extends State<ActivityDetailReserve> {
  bool _withDlc = false;

  void _toggleDlc() {
    setState(() {
      _withDlc = !_withDlc;
    });
  }

  Widget _buildMap(BuildContext context) {
    return WidgetTitleImageTap(
      tr("MAP"),
      titleColor: Interface.alwaysLight,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (e) => BuilderMap(reserve: widget.reserve)),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Image.asset(
              Graphics.getTile(widget.reserve, -1, 2, 2),
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Image.asset(
              Graphics.getTile(widget.reserve, 0, 2, 2),
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Image.asset(
              Graphics.getTile(widget.reserve, 1, 2, 2),
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _listEnvironment() {
    return [
      WidgetTitle(tr("ENVIRONMENT")),
      ListReserveEnvironment(widget.reserve),
    ];
  }

  Widget _buildMissions(BuildContext context) {
    return WidgetTitleImageTap(
      tr("MISSIONS"),
      titleColor: Interface.alwaysLight,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (e) => ListReserveMissions(widget.reserve)),
        );
      },
      child: Image.asset(
        Assets.graphics.images.hunting.path,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  List<Widget> _listAnimals() {
    return [
      WidgetTitle(tr("WILDLIFE")),
      ListReserveAnimals(widget.reserve),
    ];
  }

  List<Widget> _listCallers() {
    return [
      WidgetTitle(
        tr("RECOMMENDED_CALLERS"),
        subtext: tr("CALLER_STRENGTH"),
      ),
      ListReserveCallers(widget.reserve),
    ];
  }

  List<Widget> _listWeapons() {
    return [
      WidgetTitleSwitchIcon(
        tr("RECOMMENDED_WEAPONS"),
        subtext: "${tr("WEAPON_EFFECTIVE_RANGE")} & ${tr("WEAPON_PENETRATION")} ",
        icon: Assets.graphics.icons.dlc,
        isActive: _withDlc,
        alignRight: true,
        onTap: _toggleDlc,
      ),
      WidgetSubtitle(tr("WEAPONS_RIFLES")),
      ListReserveWeapons(widget.reserve, weaponType: WeaponType.rifle, withDlc: _withDlc),
      WidgetSubtitle(tr("WEAPONS_SHOTGUNS")),
      ListReserveWeapons(widget.reserve, weaponType: WeaponType.shotgun, withDlc: _withDlc),
      WidgetSubtitle(tr("WEAPONS_HANDGUNS")),
      ListReserveWeapons(widget.reserve, weaponType: WeaponType.handgun, withDlc: _withDlc),
      WidgetSubtitle(tr("WEAPONS_BOWS_CROSSBOWS")),
      ListReserveWeapons(widget.reserve, weaponType: WeaponType.bow, withDlc: _withDlc),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        widget.reserve.name,
        context: context,
      ),
      children: [
        _buildMap(context),
        ..._listEnvironment(),
        _buildMissions(context),
        ..._listAnimals(),
        ..._listCallers(),
        ..._listWeapons(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
