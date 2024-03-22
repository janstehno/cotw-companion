import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:flutter/material.dart';

class WidgetTitleTap extends WidgetTitle {
  final Widget? _content;
  final Function _onTap;

  const WidgetTitleTap(
    super.text, {
    super.key,
    Widget? content,
    required Function onTap,
  })  : _content = content,
        _onTap = onTap;

  @override
  Widget? buildAfter() {
    if (_content != null) return _content!;
    return super.buildAfter();
  }

  @override
  Widget buildContainer() {
    return GestureDetector(
      onTap: () => _onTap(),
      child: SizedBox(
        height: height,
        child: WidgetPadding.h30(
          background: titleBackground,
          child: buildRow(),
        ),
      ),
    );
  }
}
