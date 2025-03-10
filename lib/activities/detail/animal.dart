import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/lists/animal_info/animal_callers.dart';
import 'package:cotwcompanion/lists/animal_info/animal_furs_go.dart';
import 'package:cotwcompanion/lists/animal_info/animal_reserves.dart';
import 'package:cotwcompanion/lists/animal_info/animal_senses.dart';
import 'package:cotwcompanion/lists/animal_info/animal_trophy_score_distribution.dart';
import 'package:cotwcompanion/lists/animal_info/animal_trophy_scores.dart';
import 'package:cotwcompanion/lists/animal_info/animal_weight_distribution.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_anatomy.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_fur_images.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_header.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_weapons.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_zones.dart';
import 'package:cotwcompanion/widgets/parts/animal/fur/animal_furs.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityDetailAnimal extends StatefulWidget {
  final Animal _animal;
  final Reserve? _reserve;

  const ActivityDetailAnimal(
    Animal animal, {
    super.key,
    Reserve? reserve,
  })  : _animal = animal,
        _reserve = reserve;

  Animal get animal => _animal;

  Reserve? get reserve => _reserve;

  @override
  ActivityDetailAnimalState createState() => ActivityDetailAnimalState();
}

class ActivityDetailAnimalState extends State<ActivityDetailAnimal> {
  Settings get _settings => Provider.of<Settings>(context, listen: false);

  int _toggledRarity = -1;

  void _toggleRarity(int rarity) {
    setState(() {
      if (_toggledRarity == rarity) {
        _toggledRarity = -1;
      } else {
        _toggledRarity = rarity;
      }
    });
  }

  List<Widget> _listReserves() {
    return [
      WidgetTitle(tr("RESERVES")),
      ListAnimalReserves(widget.animal),
    ];
  }

  Widget _buildTrophyScoresTitle() {
    if (widget.animal.grounded) {
      return WidgetTitleIcon(
        tr("ANIMAL_TROPHY"),
        icon: Assets.graphics.icons.grounded,
        alignRight: true,
      );
    }
    return WidgetTitle(tr("ANIMAL_TROPHY"));
  }

  List<Widget> _listTrophyScores() {
    return [
      _buildTrophyScoresTitle(),
      ListAnimalTrophyScores(widget.animal),
    ];
  }

  List<Widget> _listWeightDistribution() {
    return [
      WidgetTitle(
        _settings.trophyWeightDistribution ? tr("ANIMAL_WEIGHT_DISTRIBUTION") : tr("ANIMAL_WEIGHT"),
      ),
      ListAnimalWeightDistribution(
        widget.animal,
        showDistribution: _settings.trophyWeightDistribution,
      ),
    ];
  }

  List<Widget> _listTrophyScoreDistribution() {
    return [
      WidgetTitle(tr("ANIMAL_TROPHY_DISTRIBUTION")),
      ListAnimalTrophyScoreDistribution(widget.animal),
    ];
  }

  List<Widget> _listZones() {
    return [
      WidgetTitle(tr("ANIMAL_NEED_ZONES")),
      WidgetAnimalZones(
        widget.animal,
        reserve: widget.reserve,
      ),
    ];
  }

  List<Widget> _listFurs() {
    return [
      WidgetTitle(tr("ANIMAL_FURS")),
      WidgetAnimalFurs(
        widget.animal,
        toggledRarity: _toggledRarity,
        onToggled: _toggleRarity,
      ),
    ];
  }

  List<Widget> _listFursGO() {
    return [
      WidgetTitle(
        tr("ANIMAL_FURS"),
        subtext: tr("FUR:GREAT_ONE"),
      ),
      ListAnimalFursGO(widget.animal),
    ];
  }

  List<Widget> _listFursImages() {
    return [
      WidgetTitle(tr("ANIMAL_FURS_VISUALIZATION")),
      WidgetAnimalFurImages(widget.animal),
    ];
  }

  List<Widget> _listAnatomy() {
    return [
      WidgetTitle(tr("ANIMAL_ANATOMY")),
      WidgetAnimalAnatomy(widget.animal),
    ];
  }

  List<Widget> _listSenses() {
    return [
      WidgetTitle(tr("ANIMAL_SENSES")),
      ListAnimalSenses(widget.animal),
    ];
  }

  List<Widget> _listWeapons() {
    return [
      WidgetTitle(tr("RECOMMENDED_WEAPONS")),
      WidgetAnimalWeapons(widget.animal),
    ];
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        widget.animal.getNameByLocale(context.locale),
        context: context,
      ),
      children: [
        WidgetAnimalHeader(widget.animal),
        ..._listReserves(),
        ..._listTrophyScores(),
        if (!_settings.trophyWeightDistribution) ..._listWeightDistribution(),
        if (_settings.trophyWeightDistribution) ...[
          ..._listTrophyScoreDistribution(),
          ..._listWeightDistribution(),
        ],
        ..._listZones(),
        ..._listFurs(),
        if (widget.animal.hasGO) ..._listFursGO(),
        ..._listFursImages(),
        if (widget.animal.level > 1) ..._listAnatomy(),
        if (widget.animal.hasSenses) ..._listSenses(),
        ListAnimalCallers(widget.animal),
        ..._listWeapons(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
