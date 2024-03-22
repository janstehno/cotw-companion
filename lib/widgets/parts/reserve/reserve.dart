import 'package:cotwcompanion/activities/detail/reserve.dart';
import 'package:cotwcompanion/builders/map.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/parts/items/item.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:flutter/material.dart';

class WidgetReserve extends StatelessWidget {
  final int _index;
  final Reserve _reserve;
  final Function _onTap;

  const WidgetReserve(
    Reserve reserve, {
    super.key,
    required int i,
    required Function onTap,
  })  : _reserve = reserve,
        _index = i,
        _onTap = onTap;

  void _onButtonTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (e) => BuilderMap(reserve: _reserve)));
  }

  List<WidgetTag> _listTags() {
    return [
      if (_reserve.isFromDlc)
        WidgetTag.big(
          icon: Assets.graphics.icons.dlc,
          color: Interface.alwaysDark,
          background: Interface.primary,
        ),
      WidgetTag.big(
        icon: Assets.graphics.icons.target,
        value: _reserve.count.toString(),
        color: Interface.dark,
        background: Interface.tag,
      )
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetItem(
      _index,
      text: _reserve.name,
      icon: Graphics.getReserveIcon(_reserve),
      buttonIcon: Assets.graphics.icons.map,
      tags: _listTags(),
      onTap: () {
        _onTap();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (e) => ActivityDetailReserve(_reserve)),
        );
      },
      onButtonTap: () => _onButtonTap(context),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
