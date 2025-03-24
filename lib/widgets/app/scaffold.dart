import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/bar_scroll.dart';
import 'package:cotwcompanion/widgets/app/bar_search.dart';
import 'package:flutter/material.dart';

class WidgetScaffold extends StatelessWidget {
  final WidgetAppBar? _appBar;
  final List<Widget> _items;
  final Function? _onFilterTap;
  final bool _filterChanged;
  final TextEditingController? _searchController;

  const WidgetScaffold({
    super.key,
    WidgetAppBar? appBar,
    required List<Widget> children,
    Function? onFilterTap,
    bool filterChanged = false,
    TextEditingController? searchController,
  })  : _appBar = appBar,
        _items = children,
        _onFilterTap = onFilterTap,
        _filterChanged = filterChanged,
        _searchController = searchController;

  Widget _buildAppBar() {
    return _appBar ?? const SizedBox.shrink();
  }

  Widget _buildSearchBar() {
    return WidgetSearchBar(
      controller: _searchController ?? TextEditingController(),
      filterChanged: _filterChanged,
      onFilterTap: _onFilterTap,
    );
  }

  Widget _buildBody() {
    return Container(
      color: Interface.body,
      child: Column(
        children: [
          Expanded(
            child: WidgetScrollBar(
              child: ListView.builder(
                itemCount: 2 + _items.length,
                itemBuilder: (context, i) {
                  if (i == 0) return _buildAppBar();
                  if (i == 1) {
                    if (_searchController != null) return _buildSearchBar();
                    return const SizedBox.shrink();
                  }
                  return _items.elementAt(i - 2);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgets() {
    return Scaffold(
      appBar: AppBar(),
      extendBody: true,
      backgroundColor: Interface.transparent,
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
