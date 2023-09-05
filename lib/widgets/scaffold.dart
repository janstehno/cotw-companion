// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:flutter/material.dart';

class WidgetScaffold extends StatelessWidget {
  final WidgetAppBar? appBar;
  final Widget body;
  final TextEditingController? searchBarController;
  final bool withSearchBar, appBarScroll, customBody;

  const WidgetScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.searchBarController,
    this.withSearchBar = false,
    this.appBarScroll = true,
    this.customBody = false,
  }) : super(key: key);

  Widget _buildAppBar() {
    return appBar ?? Container();
  }

  Widget _buildSearchBar() {
    return WidgetSearchBar(
      controller: searchBarController ?? TextEditingController(),
    );
  }

  Widget _buildAppBarScroll() {
    return Column(children: [
      Expanded(
          child: Container(
        color: Interface.body,
        child: WidgetScrollbar(
            child: SingleChildScrollView(
          child: Column(children: [
            _buildAppBar(),
            withSearchBar ? _buildSearchBar() : Container(),
            body,
          ]),
        )),
      ))
    ]);
  }

  Widget _buildAppBarNotScroll() {
    return Column(children: [
      Expanded(
          child: Container(
        color: Interface.body,
        child: Column(children: [
          _buildAppBar(),
          withSearchBar ? _buildSearchBar() : Container(),
          Expanded(
              child: WidgetScrollbar(
                  child: SingleChildScrollView(
            child: Column(children: [
              body,
            ]),
          ))),
        ]),
      ))
    ]);
  }

  Widget _buildCustom() {
    return Column(children: [
      Expanded(
          child: Container(
        color: Interface.body,
        child: body,
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
      body: customBody
          ? _buildCustom()
          : appBarScroll
              ? _buildAppBarScroll()
              : _buildAppBarNotScroll(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
