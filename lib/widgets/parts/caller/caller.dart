import 'package:cotwcompanion/activities/detail/caller.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/widgets/parts/items/item.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetCaller extends StatelessWidget {
  final int _index;
  final Caller _caller;
  final Function _onTap;

  const WidgetCaller(
    Caller caller, {
    super.key,
    required int i,
    required Function onTap,
  })  : _caller = caller,
        _index = i,
        _onTap = onTap;

  bool imperialUnits(BuildContext context) {
    return Provider.of<Settings>(context, listen: false).imperialUnits;
  }

  void onTap(BuildContext context) {
    _onTap();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (e) => ActivityDetailCaller(_caller)),
    );
  }

  List<WidgetTag> _listTags(BuildContext context) {
    return [
      if (_caller.isFromDlc)
        WidgetTag.big(
          icon: Assets.graphics.icons.dlc,
          color: Interface.alwaysDark,
          background: Interface.primary,
        ),
      WidgetTag.big(
        icon: Assets.graphics.icons.range,
        value: _caller.getRange(imperialUnits(context)),
        color: Interface.dark,
        background: Interface.tag,
      )
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetItem(
      _index,
      text: _caller.name,
      icon: Graphics.getCallerIcon(_caller),
      tags: _listTags(context),
      onTap: () => onTap(context),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
