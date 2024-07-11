import 'package:cotwcompanion/activities/modify/add/logs_source.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/loadout.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/indicator/loadout_indicator.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetReserveAnimal extends WidgetSectionIndicatorTap {
  final Animal _animal;
  final Reserve _reserve;
  final BuildContext _context;

  WidgetReserveAnimal(
    Animal animal, {
    super.key,
    required BuildContext context,
    required Reserve reserve,
    required super.background,
    required super.indicatorColor,
    super.indicatorSize = Values.dotSize,
    required super.isShown,
    required super.onTap,
  })  : _animal = animal,
        _reserve = reserve,
        _context = context,
        super(animal.getNameByReserve(context.locale, reserve));

  Animal get animal => _animal;

  Reserve get reserve => _reserve;

  BuildContext get context => _context;

  bool onDismiss() {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (e) => ActivityAddLogsSource(animal: _animal, reserve: _reserve, onSuccess: () {}),
      ),
    );
    return false;
  }

  Widget _buildEditBackground() {
    return WidgetPadding.h30(
      background: Interface.green,
      child: WidgetIcon(
        Assets.graphics.icons.edit,
        color: Interface.alwaysDark,
      ),
    );
  }

  Widget _buildLevel() {
    return WidgetText(
      _animal.level.toString(),
      color: Interface.dark,
      style: Style.normal.s18.w500,
    );
  }

  Widget _buildLoadout() {
    if (HelperLoadout.isLoadoutActivated) return WidgetLoadoutIndicator(animal: _animal);
    return const SizedBox(width: Values.dotSize);
  }

  Widget _buildGreatOne() {
    if (_animal.hasGO) {
      return WidgetIcon.withSize(
        Assets.graphics.icons.trophyGreatOne,
        color: Interface.dark,
        size: Values.dotSize + 5,
      );
    }
    return const SizedBox(width: Values.dotSize + 5);
  }

  @override
  Widget buildRow() {
    return Row(
      children: [
        _buildLevel(),
        const SizedBox(width: 15),
        Expanded(child: super.buildTitle()),
        const SizedBox(width: 15),
        _buildGreatOne(),
        if (HelperLoadout.isLoadoutActivated) ...[
          const SizedBox(width: 15),
          _buildLoadout(),
        ],
        const SizedBox(width: 15),
        buildIndicator(),
      ],
    );
  }

  @override
  Widget buildContainer() {
    return Dismissible(
      key: Key(key.toString()),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        onDismiss();
        return false;
      },
      background: _buildEditBackground(),
      child: super.buildContainer(),
    );
  }
}
