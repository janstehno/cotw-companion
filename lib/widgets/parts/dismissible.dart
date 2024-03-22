import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class WidgetDismissible extends StatefulWidget {
  final int _index;
  final Function? _callback;
  final BuildContext _context;
  final double? _height;
  final bool? _disabled;

  const WidgetDismissible(
    int i, {
    super.key,
    required Function? callback,
    required BuildContext context,
    double? height,
    bool? disabled,
  })  : _index = i,
        _callback = callback,
        _context = context,
        _height = height,
        _disabled = disabled;

  int get i => _index;

  Function? get callback => _callback;

  BuildContext get context => _context;

  double get height => _height ?? Values.section;

  bool get isDisabled => _disabled ?? false;
}

abstract class WidgetDismissibleState extends State<WidgetDismissible> {
  void undo();

  void onTap();

  void onDoubleTap();

  void startToEnd();

  void endToStart();

  Widget buildEntry();

  Widget _buildEditBackground() {
    return WidgetPadding.h30(
      background: Interface.green,
      child: WidgetIcon(
        Assets.graphics.icons.edit,
        color: Interface.alwaysDark,
      ),
    );
  }

  Widget buildDeleteBackground() {
    return WidgetPadding.h30(
      alignment: Alignment.centerRight,
      background: Interface.red,
      child: WidgetIcon(
        Assets.graphics.icons.removeBin,
        color: Interface.alwaysDark,
      ),
    );
  }

  Widget _buildEntryBackground() {
    return Container(
      constraints: BoxConstraints(minHeight: widget.height),
      color: Utils.backgroundAt(widget.i),
      child: buildEntry(),
    );
  }

  Widget _buildDismissible() {
    if (widget.isDisabled) return _buildEntryBackground();
    return Dismissible(
      key: Key(widget.key.toString()),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          startToEnd();
        } else {
          endToStart();
        }
        return false;
      },
      background: _buildEditBackground(),
      secondaryBackground: buildDeleteBackground(),
      child: _buildEntryBackground(),
    );
  }

  Widget _buildWidgets() {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: _buildDismissible(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
