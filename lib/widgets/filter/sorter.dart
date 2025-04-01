import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/button/switch_sort.dart';
import 'package:flutter/material.dart';

class WidgetFilterSorter extends StatefulWidget {
  final Filter _filter;
  final List<SortKey> _sortKeys;
  final List<String> _icons;

  const WidgetFilterSorter({
    super.key,
    required Filter filter,
    required List<SortKey> sortKeys,
    required List<String> icons,
  })  : _filter = filter,
        _sortKeys = sortKeys,
        _icons = icons;

  Filter get filter => _filter;

  List<SortKey> get sortKeys => _sortKeys;

  List<String> get icons => _icons;

  @override
  State<StatefulWidget> createState() => WidgetFilterSorterState();
}

class WidgetFilterSorterState extends State<WidgetFilterSorter> {
  late final List<SortKey> _sortKeys;

  @override
  void initState() {
    _sortKeys = widget.sortKeys;
    super.initState();
  }

  Widget _buildSwitch(SortKey key) {
    return WidgetSwitchSort(
      widget.icons.elementAt(_sortKeys.indexOf(key)),
      color: Interface.alwaysDark,
      background: Interface.disabled,
      activeColor: Interface.alwaysDark,
      activeBackground: Interface.primary,
      orderNumber: widget.filter.sortIndex(key),
      isAscended: widget.filter.isAscended(key),
      isActive: widget.filter.isSortedBy(key),
      onTap: () {
        setState(() {
          widget.filter.sortBy(key);
        });
      },
    );
  }

  List<Widget> _listSwitches(BuildContext context) {
    return _sortKeys.map((key) => _buildSwitch(key)).toList();
  }

  Widget _buildResetButton() {
    return WidgetButtonIcon(
      Assets.graphics.icons.reload,
      color: Interface.alwaysDark,
      background: Interface.primary,
      onTap: () {
        setState(() {
          widget.filter.resetSort();
        });
      },
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetPadding.h30v20(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.start,
        children: [
          ..._listSwitches(context),
          _buildResetButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
