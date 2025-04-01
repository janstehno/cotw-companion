import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/section/section_tap_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class ActivityFilter<T> extends StatefulWidget {
  final Filter<T> _filter;
  final Function _onConfirm;

  const ActivityFilter({
    super.key,
    required Filter<T> filter,
    required Function onConfirm,
  })  : _filter = filter,
        _onConfirm = onConfirm;

  Filter<T> get filter => _filter;

  Function get onConfirm => _onConfirm;
}

abstract class ActivityFilterState<T> extends State<ActivityFilter> {
  List<Widget> get filters;

  @override
  void dispose() {
    widget.filter.save();
    super.dispose();
  }

  void _onReset() {
    setState(() {
      widget.filter.reset();
    });
  }

  void switchOperation(FilterKey key) {
    setState(() {
      widget.filter.switchOperation(key);
    });
  }

  Widget _buildReset() {
    return WidgetSectionTapIcon(
      tr("RESET"),
      color: Interface.alwaysDark,
      background: Interface.primaryDark,
      icon: Assets.graphics.icons.reload,
      onTap: () => _onReset(),
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr("FILTER"),
        icon: Assets.graphics.icons.accept,
        context: context,
        onTap: () {
          widget.onConfirm();
          Navigator.pop(context);
        },
      ),
      children: [
        _buildReset(),
        ...filters,
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
