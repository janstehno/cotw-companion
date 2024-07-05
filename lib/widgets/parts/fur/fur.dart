import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/connect/animal_fur.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/parts/animal/fur/fur_percent.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetFur extends StatelessWidget {
  final AnimalFur _animalFur;
  final bool _showPerCent;

  const WidgetFur(
    AnimalFur animalFur, {
    super.key,
    required showPerCent,
  })  : _animalFur = animalFur,
        _showPerCent = showPerCent;

  AnimalFur get animalFur => _animalFur;

  bool get showPerCent => _showPerCent;

  Animal? get _animal => HelperJSON.getAnimal(_animalFur.animalId);

  Widget _buildName(BuildContext context) {
    return WidgetMargin.right(
      10,
      child: WidgetText(
        _animal!.getNameByLocale(context.locale),
        color: Interface.dark,
        style: Style.normal.s16.w300,
      ),
    );
  }

  Widget _buildMaleIcon() {
    return WidgetIcon.withSize(
      Assets.graphics.icons.genderMale,
      color: Interface.genderMale,
      size: 15,
    );
  }

  Widget _buildFemaleIcon() {
    return WidgetIcon.withSize(
      Assets.graphics.icons.genderFemale,
      color: Interface.genderFemale,
      size: 15,
    );
  }

  Widget buildGender() {
    if (_animalFur.male) {
      return _buildMaleIcon();
    } else if (_animalFur.female) {
      return _buildFemaleIcon();
    }
    return const SizedBox(width: 15, height: 15);
  }

  Widget buildPercent() {
    return WidgetFurPercent(animalFur: _animalFur);
  }

  Widget _buildWidgets(BuildContext context) {
    return SizedBox(
      height: Values.entry,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_animal != null) Expanded(child: _buildName(context)),
          buildGender(),
          if (_showPerCent) buildPercent(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
