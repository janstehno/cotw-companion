import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/model/translatable/multimount.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/parts/stats/parameter.dart';
import 'package:cotwcompanion/widgets/parts/stats/price.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetMultimount extends StatelessWidget {
  final int _index;
  final Multimount _multimount;

  const WidgetMultimount(
    Multimount multimount, {
    super.key,
    required int i,
  })  : _multimount = multimount,
        _index = i;

  Widget _buildOwned(bool owned) {
    return WidgetIcon.withSize(
      owned ? Assets.graphics.icons.todo : Assets.graphics.icons.optional,
      color: owned ? Interface.green : Interface.disabled,
      size: 15,
    );
  }

  Widget _buildGender(bool isMale) {
    return WidgetIcon.withSize(
      isMale ? Assets.graphics.icons.genderMale : Assets.graphics.icons.genderFemale,
      color: isMale ? Interface.genderMale : Interface.genderFemale,
      size: 14,
    );
  }

  Widget _buildRow(BuildContext context, MultimountAnimal multimountAnimal, Set<Log> usedLogs) {
    return WidgetMargin.bottom(
      7,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildOwned(multimountAnimal.isInTrophyLodge(usedLogs)),
          const SizedBox(width: 15),
          _buildGender(multimountAnimal.isMale),
          const SizedBox(width: 5),
          Expanded(
            child: WidgetText(
              HelperJSON.getAnimal(multimountAnimal.id)!.getNameByMultimount(context.locale, _multimount),
              color: Interface.dark,
              style: Style.normal.s16.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimals(BuildContext context, MultimountAnimal multimountAnimal, Set<Log> usedLogs) {
    return Column(children: [
      ...List.generate(multimountAnimal.count, (i) => i).map((e) => _buildRow(context, multimountAnimal, usedLogs)),
    ]);
  }

  List<Widget> _listMultimountAnimals(BuildContext context, Set<Log> usedLogs) {
    return _multimount.animals.map((e) => _buildAnimals(context, e, usedLogs)).toList();
  }

  Widget _buildName() {
    return WidgetText(
      _multimount.name,
      color: Interface.dark,
      style: Style.normal.s18.w500,
      maxLines: 2,
    );
  }

  Widget _buildSize() {
    return WidgetParameter(
      text: tr("SIZE"),
      value: _multimount.size.name,
    );
  }

  Widget _buildPrice() {
    return WidgetParameterPrice(price: _multimount.price);
  }

  Widget _buildWidgets(BuildContext context) {
    Set<Log> usedLogs = {};
    return WidgetPadding.a30(
      background: Utils.backgroundAt(_index),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildName(),
          const SizedBox(height: 7),
          _buildSize(),
          _buildPrice(),
          const SizedBox(height: 15),
          ..._listMultimountAnimals(context, usedLogs),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
