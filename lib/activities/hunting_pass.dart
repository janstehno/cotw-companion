import 'package:cotwcompanion/activities/filter/hunting_pass/hunting_pass.dart';
import 'package:cotwcompanion/filters/hunting_pass.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/hunting_pass.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu_item.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/fullscreen/hunting_pass.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityHuntingPass extends StatefulWidget {
  const ActivityHuntingPass({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => ActivityHuntingPassState();
}

class ActivityHuntingPassState extends State<ActivityHuntingPass> {
  final HelperHuntingPass _helperHuntingPass = HelperHuntingPass();
  final FilterHuntingPass _filterHuntingPass = HelperFilter.filterHuntingPass;

  final double menuHeight = Values.menuBar;

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
            _helperHuntingPass.generateHuntingPass(_filterHuntingPass, context);
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

  void buildFilter() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => ActivityFilterHuntingPass(
          filter: HelperFilter.filterHuntingPass,
          onConfirm: () {
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
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
