import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class ListDlcContent extends StatelessWidget {
  final List<int> _list;
  final ItemType _type;

  const ListDlcContent({
    super.key,
    required List<int> list,
    required ItemType type,
  })  : _list = list,
        _type = type;

  String _getName(int i) {
    switch (_type) {
      case ItemType.reserve:
        return HelperJSON.getReserve(i)!.name;
      case ItemType.animal:
        return HelperJSON.getAnimal(i)!.name;
      case ItemType.weapon:
        return HelperJSON.getWeapon(i)!.name;
      case ItemType.caller:
        return HelperJSON.getCaller(i)!.name;
      default:
        throw UnimplementedError();
    }
  }

  Widget _buildItem(int i) {
    return WidgetMargin.bottom(
      3,
      child: WidgetText(
        _getName(i),
        color: Interface.dark,
        style: Style.normal.s16.w300,
      ),
    );
  }

  List<Widget> _listItems() {
    return _list.sorted((a, b) => _getName(a).compareTo(_getName(b))).map((e) => _buildItem(e)).toList();
  }

  Widget _buildWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _listItems(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
