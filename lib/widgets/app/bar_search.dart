import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text_field.dart';
import 'package:flutter/material.dart';

class WidgetSearchBar extends StatelessWidget {
  final TextEditingController _controller;
  final Function? _onFilter;
  final bool _filterChanged;

  const WidgetSearchBar({
    super.key,
    required TextEditingController controller,
    Function? onFilterTap,
    bool filterChanged = false,
  })  : _controller = controller,
        _onFilter = onFilterTap,
        _filterChanged = filterChanged;

  double get _height => Values.searchBar;

  Widget _buildSearchIcon() {
    return Container(
      width: 25,
      alignment: Alignment.center,
      child: WidgetIcon(
        Assets.graphics.icons.search,
        color: Interface.dark,
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: WidgetTextField(textController: _controller),
    );
  }

  Widget _buildRemoveIcon() {
    return Container(
      width: 25,
      alignment: Alignment.center,
      child: WidgetButtonIcon(
        Assets.graphics.icons.menuClose,
        color: Interface.disabled,
        background: Interface.transparent,
        size: 15,
        onTap: () => _controller.text = "",
      ),
    );
  }

  Widget _buildFilterIcon() {
    return Container(
      width: 25,
      alignment: Alignment.center,
      child: WidgetButtonIcon(
        Assets.graphics.icons.filter,
        color: _filterChanged ? Interface.primary : Interface.dark,
        background: Interface.transparent,
        onTap: () => _onFilter!(),
      ),
    );
  }

  Widget _buildWidgets() {
    return SizedBox(
      height: _height,
      child: WidgetPadding.h30(
        background: Interface.search,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildSearchIcon(),
            Expanded(child: _buildTextField()),
            _buildRemoveIcon(),
            if (_onFilter != null) _buildFilterIcon(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
