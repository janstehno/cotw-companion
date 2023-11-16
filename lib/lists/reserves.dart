// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/reserve.dart';
import 'package:cotwcompanion/widgets/filters/range_auto.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListReserves extends StatefulWidget {
  const ListReserves({
    Key? key,
  }) : super(key: key);

  @override
  ListReservesState createState() => ListReservesState();
}

class ListReservesState extends State<ListReserves> {
  final TextEditingController _controller = TextEditingController();
  final List<Reserve> _reserves = [];

  @override
  void initState() {
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
      _reserves.clear();
      _reserves.addAll(HelperFilter.filterReserves(_controller.text, context));
    });
  }

  List<Widget> _buildFilters() {
    return [
      FilterRangeAuto(
        text: tr("wildlife"),
        icon: "assets/graphics/icons/target.svg",
        filterKeyLower: FilterKey.reservesCountMin,
        filterKeyUpper: FilterKey.reservesCountMax,
      )
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
        itemCount: _reserves.length,
        itemBuilder: (context, index) {
          return EntryReserve(index: index, reserve: _reserves[index], callback: _focus);
        });
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr("reserves"),
        context: context,
      ),
      searchController: _controller,
      filterChanged: HelperFilter.reserveFiltersChanged(),
      filter: _buildFilter,
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
