// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_searchbar.dart';
import 'package:flutter/material.dart';

class WidgetScaffold extends StatelessWidget {
  final WidgetAppBar appBar;
  final List<Widget> children;
  final TextEditingController? searchBarController;
  final bool showSearchBar;

  const WidgetScaffold({Key? key, required this.appBar, required this.children, this.searchBarController, this.showSearchBar = false})
      : super(key: key);

  Widget _buildWidgets() {
    return Scaffold(
        backgroundColor: Color(Values.colorBody),
        appBar: AppBar(toolbarHeight: 0, backgroundColor: Color(Values.colorPrimary)),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          showSearchBar ? appBar : Container(),
          showSearchBar
              ? WidgetSearchBar(
                  background: Values.colorSearchBackground, color: Values.colorSearch, controller: searchBarController ?? TextEditingController())
              : Container(),
          Expanded(
              child: Container(
                  color: Color(Values.colorBody),
                  child: SingleChildScrollView(child: Column(children: [showSearchBar ? Container() : appBar, Column(children: children)]))))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
