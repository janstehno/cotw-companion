import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/hunting_pass.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu_item.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/filter/switch_hunting_pass.dart';
import 'package:cotwcompanion/widgets/fullscreen/hunting_pass.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityHuntingPass extends StatefulWidget {
  final HelperHuntingPass _helperHuntingPass;

  const ActivityHuntingPass({
    super.key,
    required HelperHuntingPass helperHuntingPass,
  }) : _helperHuntingPass = helperHuntingPass;

  HelperHuntingPass get helperHuntingPass => _helperHuntingPass;

  @override
  State<StatefulWidget> createState() => ActivityHuntingPassState();
}

class ActivityHuntingPassState extends State<ActivityHuntingPass> {
  late final HelperHuntingPass _helperHuntingPass;

  final double menuHeight = Values.menuBar;

  final List<List<dynamic>> _filters = [
    ["PASS_DLC", FilterKey.huntingPassRandomAllowedDlc],
    ["PASS_RESERVE", FilterKey.huntingPassRandomReserve],
    ["PASS_ANIMAL", FilterKey.huntingPassRandomAnimal],
    ["PASS_WEAPON", FilterKey.huntingPassRandomWeapon],
    ["PASS_RIFLE", FilterKey.weaponsRifles],
    ["PASS_SHOTGUN", FilterKey.weaponsShotguns],
    ["PASS_HANDGUN", FilterKey.weaponsHandguns],
    ["PASS_BOW_CROSSBOW", FilterKey.weaponsBows],
    ["PASS_AMMO", FilterKey.huntingPassRandomAmmo],
    ["PASS_DISTANCE", FilterKey.huntingPassRandomDistance],
    ["PASS_DOG", FilterKey.huntingPassRandomAllowedDog],
    ["PASS_CALLERS", FilterKey.huntingPassRandomAllowedCallers],
    ["PASS_SCOPES", FilterKey.huntingPassRandomAllowedScopes],
    ["PASS_ATV", FilterKey.huntingPassRandomAllowedAtv],
    ["PASS_STRUCTURES", FilterKey.huntingPassRandomAllowedStructures],
    ["PASS_FAST_TRAVEL", FilterKey.huntingPassRandomAllowedFastTravel],
    ["PASS_DAY_TIME", FilterKey.huntingPassRandomAllowedDayTime],
  ];

  @override
  void initState() {
    _helperHuntingPass = widget.helperHuntingPass;
    super.initState();
  }

  WidgetMenuBarItem _buildMenuFilter() {
    return WidgetMenuBarItem(
      barButton: WidgetButtonIcon(
        Assets.graphics.icons.filter,
        color: Interface.light,
        background: Interface.dark,
        onTap: () => buildFilter(),
      ),
    );
  }

  WidgetMenuBarItem _buildMenuGenerate() {
    return WidgetMenuBarItem(
      barButton: WidgetButtonIcon(
        Assets.graphics.icons.pass,
        color: Interface.alwaysDark,
        background: Interface.primary,
        onTap: () {
          setState(() {
            _helperHuntingPass.generateHuntingPass(context);
            setState(() {});
          });
        },
      ),
    );
  }

  List<WidgetMenuBarItem> _listMenuBarItems() {
    return [
      _buildMenuFilter(),
      _buildMenuGenerate(),
    ];
  }

  WidgetMenuBar _buildMenu() {
    return WidgetMenuBar(items: _listMenuBarItems());
  }

  Widget _buildFilterSwitch(int i, List<dynamic> e) {
    return WidgetFilterSwitchHuntingPass(
      e.elementAt(1),
      i: i,
      text: tr(e.elementAt(0)),
      helperHuntingPass: _helperHuntingPass,
    );
  }

  List<Widget> listFilters() => _filters.mapIndexed((i, e) => _buildFilterSwitch(i, e)).toList();

  void buildFilter() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => ActivityFilter(
          filters: listFilters(),
          filter: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildMenuBar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: menuHeight,
          width: MediaQuery.of(context).size.width,
          color: Interface.search,
        ),
        _buildMenu(),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      color: Interface.body,
      child: Column(
        children: [
          WidgetAppBar(
            tr("HUNTING_PASS"),
            context: context,
          ),
          if (_helperHuntingPass.huntingPass != null)
            Expanded(child: WidgetHuntingPass(huntingPass: _helperHuntingPass.huntingPass!))
          else
            const Spacer(),
          _buildMenuBar(),
        ],
      ),
    );
  }

  Widget _buildWidgets() {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
