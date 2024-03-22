import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetMapAnimal extends StatelessWidget {
  final String _name;
  final Color _color;
  final int _drinkZones;
  final int _feedZones;
  final int _restZones;

  const WidgetMapAnimal({
    super.key,
    required String name,
    required Color color,
    required int drinkZones,
    required int feedZones,
    required int restZones,
  })  : _name = name,
        _color = color,
        _drinkZones = drinkZones,
        _feedZones = feedZones,
        _restZones = restZones;

  Widget _buildSum(int sum, Color color) {
    return Container(
      width: 25,
      alignment: Alignment.center,
      child: WidgetText(
        sum == 0 ? "-" : sum.toString(),
        color: color,
        style: Style.normal.s12.w500,
      ),
    );
  }

  Widget _listSeparateZones() {
    return Wrap(
      spacing: 3,
      children: [
        _buildSum(_drinkZones, Interface.zoneDrink),
        _buildSum(_feedZones, Interface.zoneFeed),
        _buildSum(_restZones, Interface.zoneRest),
      ],
    );
  }

  Widget _buildZonesSum() {
    return _buildSum(_drinkZones + _feedZones + _restZones, _color);
  }

  List<Widget> _listRow(BuildContext context) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    return [
      if (settings.mapZonesCount && !settings.mapPerformanceMode)
        if (settings.mapZonesType) _listSeparateZones() else _buildZonesSum(),
      if (settings.mapZonesCount && !settings.mapPerformanceMode) const SizedBox(width: 10),
      WidgetText(
        _name,
        color: _color,
        style: Style.normal.s12.w300,
      ),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _listRow(context),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
