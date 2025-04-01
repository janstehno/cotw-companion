import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/text/text_field_indicator.dart';
import 'package:flutter/material.dart';

class WidgetFilterRangeSet<E> extends StatefulWidget {
  final Filter<E> _filter;
  final FilterKey _filterKeyLower;
  final FilterKey _filterKeyUpper;
  final bool _decimal;

  const WidgetFilterRangeSet({
    super.key,
    required Filter<E> filter,
    required FilterKey filterKeyLower,
    required FilterKey filterKeyUpper,
    required bool decimal,
  })  : _filter = filter,
        _filterKeyLower = filterKeyLower,
        _filterKeyUpper = filterKeyUpper,
        _decimal = decimal;

  Filter<E> get filter => _filter;

  FilterKey get filterKeyLower => _filterKeyLower;

  FilterKey get filterKeyUpper => _filterKeyUpper;

  bool get decimal => _decimal;

  @override
  State<StatefulWidget> createState() => WidgetFilterRangeSetState();
}

class WidgetFilterRangeSetState extends State<WidgetFilterRangeSet> {
  final TextEditingController _controllerMin = TextEditingController();
  final TextEditingController _controllerMax = TextEditingController();

  num get defaultMin => widget.filter.defaultValueOf(widget.filterKeyLower);

  num get min => widget.filter.valueOf(widget.filterKeyLower);

  num get defaultMax => widget.filter.defaultValueOf(widget.filterKeyUpper);

  num get max => widget.filter.valueOf(widget.filterKeyUpper);

  @override
  void initState() {
    _initializeControllers();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WidgetFilterRangeSet oldWidget) {
    _updateControllers();
    super.didUpdateWidget(oldWidget);
  }

  void _updateControllers() {
    _controllerMin.text = defaultMin == min ? "" : min.toString();
    _controllerMax.text = defaultMax == max ? "" : max.toString();
  }

  void _initializeControllers() {
    _controllerMin.addListener(() => _changeMinValue());
    _controllerMax.addListener(() => _changeMaxValue());
    _updateControllers();
  }

  void _changeMinValue() {
    num newMin;
    if (widget.decimal) {
      newMin = _controllerMin.text.isEmpty ? defaultMin : double.tryParse(_controllerMin.text) ?? min.toDouble();
    } else {
      newMin = _controllerMin.text.isEmpty ? defaultMin : int.tryParse(_controllerMin.text) ?? min.toInt();
    }
    setState(() => widget.filter.setValue(widget.filterKeyLower, newMin));
  }

  void _changeMaxValue() {
    num newMax;
    if (widget.decimal) {
      newMax = _controllerMax.text.isEmpty ? defaultMax : double.tryParse(_controllerMax.text) ?? max.toDouble();
    } else {
      newMax = _controllerMax.text.isEmpty ? defaultMax : int.tryParse(_controllerMax.text) ?? max.toInt();
    }
    setState(() => widget.filter.setValue(widget.filterKeyUpper, newMax));
  }

  Widget _buildMinTextField() {
    return WidgetTextFieldIndicator(
      icon: Assets.graphics.icons.rangeMin,
      textController: _controllerMin,
      decimal: widget.decimal,
      noIndicator: true,
    );
  }

  Widget _buildMaxTextField() {
    return WidgetTextFieldIndicator(
      icon: Assets.graphics.icons.rangeMax,
      textController: _controllerMax,
      decimal: widget.decimal,
      noIndicator: true,
    );
  }

  Widget _buildWidgets() {
    return Row(
      children: [
        Expanded(child: _buildMinTextField()),
        Expanded(child: _buildMaxTextField()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
