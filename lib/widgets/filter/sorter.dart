import 'package:collection/collection.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/button/switch_sort.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:flutter/material.dart';

class WidgetFilterSorter extends StatefulWidget {
  final FilterKey _filterKey;
  final String _icon;
  final String _text;
  final List<String> _icons;
  final List<bool> _criteria;
  final List<String> _preferences;

  const WidgetFilterSorter(
    FilterKey filterKey, {
    super.key,
    required String icon,
    required String text,
    required List<String> icons,
    required List<bool> criteria,
    required List<String> preferences,
  })  : _filterKey = filterKey,
        _icon = icon,
        _text = text,
        _icons = icons,
        _criteria = criteria,
        _preferences = preferences;

  FilterKey get filterKey => _filterKey;

  String get icon => _icon;

  String get text => _text;

  List<String> get icons => _icons;

  List<bool> get criteria => _criteria;

  List<String> get preferences => _preferences;

  @override
  State<StatefulWidget> createState() => WidgetFilterSorterState();
}

class WidgetFilterSorterState extends State<WidgetFilterSorter> {
  List<int> get values => HelperFilter.getDefaultListKeys(widget.filterKey);

  double _getSwitchSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemsBetween = (values.length - 1) * 10 + 30 * 2;
    double availableWidth = screenWidth - itemsBetween;
    double itemsWidth = values.length * Values.tapSize;
    double calcWidth = availableWidth / values.length;
    return availableWidth > itemsWidth ? Values.tapSize : calcWidth;
  }

  Widget _buildSwitch(
    int i,
    int order,
    bool ascended,
    bool active,
    int key,
    bool criteria,
    String preference,
    double size,
  ) {
    return SizedBox(
      width: size,
      height: size,
      child: WidgetSwitchSort(
        widget.icons.elementAt(i),
        color: Interface.alwaysDark,
        background: Interface.disabled,
        activeColor: Interface.alwaysDark,
        activeBackground: Interface.primary,
        orderNumber: order,
        isAscended: ascended,
        isActive: active,
        onTap: () => setState(() => HelperFilter.useSort(widget.filterKey, key, criteria, preference)),
      ),
    );
  }

  List<Widget> _listSwitches(BuildContext context) {
    return values.mapIndexed((i, e) {
      int key = values.elementAt(i);
      bool criteria = widget.criteria.elementAt(i);
      String preference = widget.preferences.elementAt(i);
      int order = HelperFilter.getSortValue(widget.filterKey, key, "order");
      bool ascended = HelperFilter.getSortValue(widget.filterKey, key, "ascended");
      bool active = HelperFilter.getSortValue(widget.filterKey, key, "active");
      return _buildSwitch(i, order, ascended, active, key, criteria, preference, _getSwitchSize(context));
    }).toList();
  }

  Widget _buildResetButton() {
    return WidgetButtonIcon(
      Assets.graphics.icons.reload,
      color: Interface.alwaysDark,
      background: Interface.primary,
      onTap: () => setState(() => HelperFilter.resetSort(widget.filterKey)),
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return Column(
      children: [
        WidgetTitleIcon(
          widget.text,
          icon: widget.icon,
        ),
        WidgetPadding.h30v20(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            children: [
              ..._listSwitches(context),
              _buildResetButton(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
