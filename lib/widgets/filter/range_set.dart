import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/text/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:flutter/material.dart';

class WidgetFilterRangeSet extends StatefulWidget {
  final FilterKey _filterKeyLower;
  final FilterKey _filterKeyUpper;
  final String _icon;
  final String _text;
  final bool _decimal;

  const WidgetFilterRangeSet(
    FilterKey filterKeyLower,
    FilterKey filterKeyUpper, {
    super.key,
    required String icon,
    required String text,
    required bool decimal,
  })  : _filterKeyLower = filterKeyLower,
        _filterKeyUpper = filterKeyUpper,
        _icon = icon,
        _text = text,
        _decimal = decimal;

  FilterKey get filterKeyLower => _filterKeyLower;

  FilterKey get filterKeyUpper => _filterKeyUpper;

  String get icon => _icon;

  String get text => _text;

  bool get decimal => _decimal;

  @override
  State<StatefulWidget> createState() => WidgetFilterRangeSetState();
}

class WidgetFilterRangeSetState extends State<WidgetFilterRangeSet> {
  num get min => HelperFilter.getDefaultValue(widget.filterKeyLower);

  num get max => HelperFilter.getDefaultValue(widget.filterKeyUpper);

  TextEditingController _initializeMinController() {
    final TextEditingController controllerMin = TextEditingController();
    double minValue = HelperFilter.getDoubleValue(widget.filterKeyLower);
    int minIntValue = HelperFilter.getIntValue(widget.filterKeyLower);
    if (widget.decimal) {
      controllerMin.text = minValue == min ? "" : minValue.toString().replaceFirst(".0", "");
    } else {
      controllerMin.text = minIntValue == min ? "" : minIntValue.toString();
    }
    controllerMin.addListener(() => _changeMinValue(controllerMin));
    return controllerMin;
  }

  TextEditingController _initializeMaxController() {
    final TextEditingController controllerMax = TextEditingController();
    double maxValue = HelperFilter.getDoubleValue(widget.filterKeyUpper);
    int maxIntValue = HelperFilter.getIntValue(widget.filterKeyUpper);
    if (widget.decimal) {
      controllerMax.text = maxValue == max ? "" : maxValue.toString().replaceFirst(".0", "");
    } else {
      controllerMax.text = maxIntValue == max ? "" : maxIntValue.toString();
    }
    controllerMax.addListener(() => _changeMaxValue(controllerMax));
    return controllerMax;
  }

  void _changeMinValue(TextEditingController controllerMin) {
    num newMin;
    if (widget.decimal) {
      newMin = controllerMin.text.isEmpty ? min.toDouble() : double.tryParse(controllerMin.text) ?? min.toDouble();
    } else {
      newMin = controllerMin.text.isEmpty ? min.toInt() : int.tryParse(controllerMin.text) ?? min.toInt();
    }
    setState(() => HelperFilter.changeNumValue(widget.filterKeyLower, newMin));
  }

  void _changeMaxValue(TextEditingController controllerMax) {
    num newMax;
    if (widget.decimal) {
      newMax = controllerMax.text.isEmpty ? max.toDouble() : double.tryParse(controllerMax.text) ?? max.toDouble();
    } else {
      newMax = controllerMax.text.isEmpty ? max.toInt() : int.tryParse(controllerMax.text) ?? max.toInt();
    }
    setState(() => HelperFilter.changeNumValue(widget.filterKeyUpper, newMax));
  }

  Widget _buildMinTextField(TextEditingController controllerMin) {
    return WidgetTextFieldIndicator(
      icon: Assets.graphics.icons.rangeMin,
      textController: controllerMin,
      correct: controllerMin.text.isNotEmpty ? (double.tryParse(controllerMin.text) ?? min - 1) >= min : true,
    );
  }

  Widget _buildMaxTextField(TextEditingController controllerMax) {
    return WidgetTextFieldIndicator(
      icon: Assets.graphics.icons.rangeMax,
      textController: controllerMax,
      correct: controllerMax.text.isNotEmpty ? (double.tryParse(controllerMax.text) ?? max + 1) <= max : true,
    );
  }

  Widget _buildWidgets() {
    final TextEditingController controllerMin = _initializeMinController();
    final TextEditingController controllerMax = _initializeMaxController();
    return Column(
      children: [
        WidgetTitleIcon(
          widget.text,
          icon: widget.icon,
        ),
        Row(
          children: [
            Expanded(child: _buildMinTextField(controllerMin)),
            Expanded(child: _buildMaxTextField(controllerMax)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
