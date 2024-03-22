import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFilter extends StatelessWidget {
  final List<Widget> _filters;
  final Function _filter;

  const ActivityFilter({
    super.key,
    required List<Widget> filters,
    required Function filter,
  })  : _filters = filters,
        _filter = filter;

  List<Widget> get filters => _filters;

  Function get filter => _filter;

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr("FILTER"),
        icon: Assets.graphics.icons.accept,
        context: context,
        onTap: () {
          _filter();
          Navigator.pop(context);
        },
      ),
      children: _filters,
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
