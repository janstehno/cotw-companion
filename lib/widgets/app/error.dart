import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  final String _code;
  final String _error;
  final String? _stack;

  const WidgetError({
    super.key,
    required String code,
    required String error,
    String? stack,
  })  : _code = code,
        _error = error,
        _stack = stack;

  Widget _buildInfo() {
    return WidgetPadding.a30(
      child: Column(
        children: [
          WidgetText(
            "Error has occurred. Please restart the application. Don't forget to contact me about any problems.",
            textAlign: TextAlign.start,
            color: Interface.dark,
            style: Style.normal.s16.w300,
            autoSize: false,
          ),
          if (_error.isNotEmpty) ...[
            const SizedBox(height: 20),
            WidgetText(
              _error,
              textAlign: TextAlign.start,
              color: Interface.dark,
              style: Style.normal.s16.w300,
              autoSize: false,
            ),
          ]
        ],
      ),
    );
  }

  List<Widget> _listStack() {
    return [
      const WidgetTitle("Stack"),
      WidgetPadding.a30(
        child: WidgetText(
          _stack!,
          color: Interface.dark,
          style: Style.normal.s16.w300,
          autoSize: false,
        ),
      ),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        _code,
        context: context,
      ),
      children: [
        _buildInfo(),
        if (_stack != null) ..._listStack(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
