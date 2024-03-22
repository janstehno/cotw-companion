import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetItem extends StatelessWidget {
  final int _index;
  final String _text;
  final String? _icon;
  final String? _buttonIcon;
  final List<WidgetTag> _tags;
  final Function _onTap;
  final Function? _onButtonTap;

  const WidgetItem(
    int i, {
    super.key,
    required String text,
    String? icon,
    String? buttonIcon,
    List<WidgetTag> tags = const [],
    required Function onTap,
    Function? onButtonTap,
  })  : _index = i,
        _text = text,
        _icon = icon,
        _buttonIcon = buttonIcon,
        _tags = tags,
        _onTap = onTap,
        _onButtonTap = onButtonTap;

  double get _iconSize => 70;

  Widget _buildName() {
    return WidgetText(
      _text,
      color: Interface.dark,
      style: Style.normal.s18.w300,
      maxLines: _icon != null ? 3 : 2,
    );
  }

  Widget _buildIcon() {
    return WidgetIcon.withSize(
      _icon!,
      color: Interface.dark,
      size: _iconSize,
    );
  }

  Widget _buildNameIcon() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _buildName()),
        if (_icon != null) ...[
          const SizedBox(width: 30),
          _buildIcon(),
        ],
      ],
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      alignment: WrapAlignment.start,
      children: _tags,
    );
  }

  Widget _buildButton() {
    return Container(
      width: _iconSize,
      alignment: Alignment.bottomCenter,
      child: WidgetButtonIcon(
        _buttonIcon!,
        color: Interface.alwaysDark,
        background: Interface.primary,
        onTap: () => _onButtonTap!(),
      ),
    );
  }

  Widget _buildTagsButton() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: _buttonIcon != null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildTags()),
        if (_buttonIcon != null) ...[
          const SizedBox(width: 30),
          _buildButton(),
        ],
      ],
    );
  }

  Widget _buildWidgets() {
    return GestureDetector(
      onTap: () => _onTap(),
      child: WidgetPadding.a30(
        background: Utils.backgroundAt(_index),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNameIcon(),
            const SizedBox(height: 30),
            _buildTagsButton(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
