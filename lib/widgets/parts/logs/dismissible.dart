import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:cotwcompanion/widgets/parts/dismissible.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class WidgetLogsDismissible extends WidgetDismissible {
  final Log _log;

  const WidgetLogsDismissible(
    super.i, {
    super.key,
    required super.callback,
    required super.context,
    required Log log,
    super.disabled,
  })  : _log = log,
        super(height: 0);

  Log get log => _log;
}

abstract class WidgetLogsDismissibleState extends WidgetDismissibleState {
  final double dateHeight = 15;
  final double _nameHeight = 30;
  final double _furHeight = 15;
  final double _furDotSize = 9;
  final double _trophyWidth = 100;
  final double _trophyHeight = 30;
  final double _weightWidth = 65;
  final double _weightHeight = 15;

  Settings get settings => Provider.of<Settings>(context, listen: false);

  @override
  void onTap() {}

  @override
  void onDoubleTap() {}

  @override
  void undo() {}

  @override
  void startToEnd() {}

  @override
  void endToStart() {}

  @override
  Widget buildEntry();

  @override
  Widget buildDeleteBackground() {
    return WidgetPadding.h30(
      background: Interface.primary,
      alignment: Alignment.centerRight,
      child: WidgetIcon(
        Assets.graphics.icons.trophyLodge,
        color: Interface.alwaysDark,
      ),
    );
  }

  Widget buildName() {
    return SizedBox(
      height: _nameHeight,
      child: WidgetMargin.right(
        30,
        child: WidgetText(
          (widget as WidgetLogsDismissible)
              .log
              .animal!
              .getNameByReserve(context.locale, (widget as WidgetLogsDismissible).log.reserve),
          color: Interface.dark,
          style: Style.normal.s18.w300,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget buildGender() {
    return WidgetIcon(
      (widget as WidgetLogsDismissible).log.isMale
          ? Assets.graphics.icons.genderMale
          : Assets.graphics.icons.genderFemale,
      color: (widget as WidgetLogsDismissible).log.isMale ? Interface.genderMale : Interface.genderFemale,
    );
  }

  Widget _buildFurRarity() {
    return Container(
      width: _furHeight,
      alignment: Alignment.center,
      child: WidgetIndicator(
        (widget as WidgetLogsDismissible).log.animalFur!.rarity.color,
        size: _furDotSize,
      ),
    );
  }

  Widget _buildFurValue() {
    return SizedBox(
      height: _furHeight,
      child: WidgetMargin.right(
        30,
        child: WidgetText(
          (widget as WidgetLogsDismissible).log.animalFur!.furName,
          color: Interface.dark,
          style: Style.normal.s14.w300,
        ),
      ),
    );
  }

  Widget buildFur() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildFurRarity(),
        const SizedBox(width: 5),
        Expanded(child: _buildFurValue()),
      ],
    );
  }

  Widget _buildTrophyIcon() {
    return WidgetIcon(
      (widget as WidgetLogsDismissible).log.getTrophyRatingIcon(),
      color: (widget as WidgetLogsDismissible).log.getTrophyColor(),
    );
  }

  Widget _buildTrophyValue() {
    return Container(
      height: _trophyHeight,
      alignment: Alignment.centerRight,
      child: WidgetText(
        Utils.removePointZero((widget as WidgetLogsDismissible).log.trophy, 2),
        color: Interface.dark,
        style: Style.normal.s18.w500,
      ),
    );
  }

  Widget _buildRow() {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTrophyIcon(),
          Expanded(child: _buildTrophyValue()),
        ],
      ),
    );
  }

  Widget buildTrophy() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: _trophyWidth,
        maxWidth: _trophyWidth,
        minHeight: _trophyHeight,
        maxHeight: _trophyHeight,
      ),
      child: _buildRow(),
    );
  }

  Widget _buildWeightValue() {
    String number = Utils.removePointZero((widget as WidgetLogsDismissible).log.weight, 2);
    String units = (widget as WidgetLogsDismissible).log.usesImperials ? tr("POUNDS") : tr("KILOGRAMS");
    return WidgetMargin.left(
      10,
      alignment: Alignment.centerRight,
      child: WidgetText(
        "$number $units",
        color: Interface.dark,
        style: Style.normal.s14.w300,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget buildWeight() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: _weightWidth,
        maxWidth: _weightWidth,
        minHeight: _weightHeight,
        maxHeight: _weightHeight,
      ),
      child: _buildWeightValue(),
    );
  }
}
