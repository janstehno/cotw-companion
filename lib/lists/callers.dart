// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/caller.dart';
import 'package:cotwcompanion/widgets/filters/picker_text.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCallers extends StatefulWidget {
  const ListCallers({
    Key? key,
  }) : super(key: key);

  @override
  ListCallersState createState() => ListCallersState();
}

class ListCallersState extends State<ListCallers> {
  final TextEditingController _controller = TextEditingController();
  final List<Caller> _callers = [];

  late final bool _imperials;

  @override
  void initState() {
    _imperials = Provider.of<Settings>(context, listen: false).getImperialUnits;
    _controller.addListener(() => _filter());
    super.initState();
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _filter() {
    setState(() {
      _callers.clear();
      _callers.addAll(HelperFilter.filterCallers(_controller.text, context));
    });
  }

  List<Widget> _buildFilters() {
    return [
      FilterPickerText(
        text: tr('caller_range'),
        icon: "assets/graphics/icons/range.svg",
        values: const [150, 200, 250, 500],
        keys: _imperials
            ? [
                "164 ${tr('yards')}",
                "218 ${tr('yards')}",
                "273 ${tr('yards')}",
                "546 ${tr('yards')}",
              ]
            : [
                "150 ${tr('meters')}",
                "200 ${tr('meters')}",
                "250 ${tr('meters')}",
                "500 ${tr('meters')}",
              ],
        filterKey: FilterKey.callersEffectiveRange,
      ),
    ];
  }

  void _buildFilter() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityFilter(filters: _buildFilters(), filter: _filter)));
  }

  Widget _buildList() {
    _filter();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _callers.length,
        itemBuilder: (context, index) {
          return EntryCaller(index: index, caller: _callers[index], callback: _focus);
        });
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr('callers'),
        context: context,
      ),
      searchController: _controller,
      filter: _buildFilter,
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
