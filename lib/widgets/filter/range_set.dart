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
  final TextEditingController _controllerMin = TextEditingController();
  final TextEditingController _controllerMax = TextEditingController();

  num get min => HelperFilter.getDefaultValue(widget.filterKeyLower);

  num get max => HelperFilter.getDefaultValue(widget.filterKeyUpper);

  @override
  void initState() {
    _initializeMinController();
    _initializeMaxController();
    super.initState();
  }

  void _initializeMinController() {
    double minValue = HelperFilter.getDoubleValue(widget.filterKeyLower);
    int minIntValue = HelperFilter.getIntValue(widget.filterKeyLower);
    if (widget.decimal) {
      _controllerMin.text = minValue == min ? "" : minValue.toString().replaceFirst(".0", "");
    } else {
      _controllerMin.text = minIntValue == min ? "" : minIntValue.toString();
    }
    _controllerMin.addListener(() => _changeMinValue());
  }

  void _initializeMaxController() {
    double maxValue = HelperFilter.getDoubleValue(widget.filterKeyUpper);
    int maxIntValue = HelperFilter.getIntValue(widget.filterKeyUpper);
    if (widget.decimal) {
      _controllerMax.text = maxValue == max ? "" : maxValue.toString().replaceFirst(".0", "");
    } else {
      _controllerMax.text = maxIntValue == max ? "" : maxIntValue.toString();
    }
    _controllerMax.addListener(() => _changeMaxValue());
  }

  void _changeMinValue() {
    num newMin;
    if (widget.decimal) {
      newMin = _controllerMin.text.isEmpty ? min.toDouble() : double.tryParse(_controllerMin.text) ?? min.toDouble();
    } else {
      newMin = _controllerMin.text.isEmpty ? min.toInt() : int.tryParse(_controllerMin.text) ?? min.toInt();
    }
    setState(() => HelperFilter.changeNumValue(widget.filterKeyLower, newMin));
  }

  void _changeMaxValue() {
    num newMax;
    if (widget.decimal) {
      newMax = _controllerMax.text.isEmpty ? max.toDouble() : double.tryParse(_controllerMax.text) ?? max.toDouble();
    } else {
      newMax = _controllerMax.text.isEmpty ? max.toInt() : int.tryParse(_controllerMax.text) ?? max.toInt();
    }
    setState(() => HelperFilter.changeNumValue(widget.filterKeyUpper, newMax));
  }

  Widget _buildMinTextField() {
    return WidgetTextFieldIndicator(
      icon: Assets.graphics.icons.rangeMin,
      textController: _controllerMin,
      correct: _controllerMin.text.isNotEmpty ? (double.tryParse(_controllerMin.text) ?? min - 1) >= min : true,
    );
  }

  Widget _buildMaxTextField() {
    return WidgetTextFieldIndicator(
      icon: Assets.graphics.icons.rangeMax,
      textController: _controllerMax,
      correct: _controllerMax.text.isNotEmpty ? (double.tryParse(_controllerMax.text) ?? max + 1) <= max : true,
    );
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        WidgetTitleIcon(
          widget.text,
          icon: widget.icon,
        ),
        Row(
          children: [
            Expanded(child: _buildMinTextField()),
            Expanded(child: _buildMaxTextField()),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
