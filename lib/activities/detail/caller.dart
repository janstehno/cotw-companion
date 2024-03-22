import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/lists/caller_info/caller_animals.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/parts/stats/parameter.dart';
import 'package:cotwcompanion/widgets/parts/stats/price.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityDetailCaller extends StatelessWidget {
  final Caller _caller;

  const ActivityDetailCaller(
    Caller caller, {
    super.key,
  }) : _caller = caller;

  Widget _buildRange(BuildContext context) {
    bool imperialUnits = Provider.of<Settings>(context, listen: false).imperialUnits;
    return WidgetParameter(
      text: tr("CALLER_RANGE"),
      value: _caller.getRange(imperialUnits),
    );
  }

  Widget _buildDuration() {
    return WidgetParameter(
      text: tr("CALLER_DURATION"),
      value: "${_caller.duration} ${tr("SECONDS")}",
    );
  }

  Widget _buildStrength() {
    return WidgetParameter(
      text: tr("CALLER_STRENGTH"),
      value: _caller.strength,
    );
  }

  Widget _buildRequirements() {
    return WidgetParameter(
      text: tr("REQUIREMENT_LEVEL"),
      value: _caller.level,
    );
  }

  Widget _buildStatistics(BuildContext context) {
    return WidgetPadding.a30(
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          _buildRange(context),
          _buildDuration(),
          _buildStrength(),
          WidgetParameterPrice(price: _caller.price),
          if (_caller.hasRequirements) _buildRequirements(),
        ],
      ),
    );
  }

  List<Widget> _listAnimals() {
    return [
      WidgetTitle(tr("RECOMMENDED_ANIMALS")),
      ListCallerAnimals(_caller),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        _caller.name,
        context: context,
      ),
      children: [
        _buildStatistics(context),
        ..._listAnimals(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
