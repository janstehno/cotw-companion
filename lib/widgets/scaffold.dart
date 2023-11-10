// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:flutter/material.dart';

class WidgetScaffold extends StatefulWidget {
  final WidgetAppBar? appBar;
  final Widget body;
  final Function? filter;
  final bool filterChanged;
  final TextEditingController? searchController;
  final bool customBody, appBarFixed;

  const WidgetScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.filter,
    this.filterChanged = false,
    this.searchController,
    this.customBody = false,
    this.appBarFixed = false,
  }) : super(key: key);

  @override
  WidgetScaffoldState createState() => WidgetScaffoldState();
}

class WidgetScaffoldState extends State<WidgetScaffold> {
  Widget _buildAppBar() {
    return widget.appBar ?? const SizedBox.shrink();
  }

  Widget _buildSearchBar() {
    return WidgetSearchBar(
      controller: widget.searchController ?? TextEditingController(),
      filterChanged: widget.filterChanged,
      onFilter: widget.filter,
    );
  }

  Widget _buildWithoutSearch() {
    return Column(children: [
      widget.appBarFixed ? _buildAppBar() : const SizedBox.shrink(),
      Expanded(
          child: Container(
        color: Interface.body,
        child: WidgetScrollbar(
            child: SingleChildScrollView(
          child: Column(children: [
            widget.appBarFixed ? const SizedBox.shrink() : _buildAppBar(),
            widget.body,
          ]),
        )),
      ))
    ]);
  }

  Widget _buildWithSearch() {
    return Column(children: [
      Expanded(
          child: Container(
        color: Interface.body,
        child: Stack(children: [
          Column(children: [
            _buildAppBar(),
            _buildSearchBar(),
            Expanded(
                child: WidgetScrollbar(
                    child: SingleChildScrollView(
              child: Column(children: [
                widget.body,
              ]),
            ))),
          ]),
        ]),
      ))
    ]);
  }

  Widget _buildCustomBody() {
    return Column(children: [
      Expanded(
          child: Container(
        color: Interface.body,
        child: widget.body,
      ))
    ]);
  }

  Widget _buildWidgets() {
    return Scaffold(
      backgroundColor: Interface.body,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Interface.primary,
      ),
      body: widget.customBody
          ? _buildCustomBody()
          : widget.searchController == null
              ? _buildWithoutSearch()
              : _buildWithSearch(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
