// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:flutter/material.dart';

class WidgetScaffold extends StatelessWidget {
  final WidgetAppBar? appBar;
  final List<Widget>? children;
  final TextEditingController? searchBarController;
  final bool showSearchBar, hasCustomBody;
  final Widget? body;

  const WidgetScaffold({
    Key? key,
    required this.appBar,
    required this.children,
    this.searchBarController,
    this.showSearchBar = false,
    this.hasCustomBody = false,
    this.body,
  }) : super(key: key);

  const WidgetScaffold.withSearch({
    Key? key,
    required this.appBar,
    required this.children,
    required this.searchBarController,
    this.showSearchBar = true,
    this.hasCustomBody = false,
    this.body,
  }) : super(key: key);

  const WidgetScaffold.withCustomBody({
    Key? key,
    this.appBar,
    this.children,
    this.searchBarController,
    this.showSearchBar = false,
    this.hasCustomBody = true,
    required this.body,
  }) : super(key: key);

  Widget _buildAppBar() {
    return appBar ?? Container();
  }

  Widget _buildWidgets() {
    return Scaffold(
        backgroundColor: Interface.mainBody,
        appBar: AppBar(toolbarHeight: 0, backgroundColor: Interface.primary),
        body: hasCustomBody
            ? body ?? Container()
            : Column(mainAxisSize: MainAxisSize.max, children: [
                showSearchBar ? _buildAppBar() : Container(),
                showSearchBar
                    ? WidgetSearchBar(
                        background: Interface.searchBackground,
                        color: Interface.search,
                        controller: searchBarController ?? TextEditingController(),
                      )
                    : Container(),
                Expanded(
                    child: Container(
                        color: Interface.mainBody,
                        child: WidgetScrollbar(
                            child: SingleChildScrollView(
                                child: Column(children: [
                          showSearchBar ? Container() : _buildAppBar(),
                          Column(children: children ?? []),
                        ])))))
              ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
