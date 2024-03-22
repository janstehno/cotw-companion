import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/parts/stats/parameter.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetParameterPrice extends WidgetParameter {
  final int _price;

  WidgetParameterPrice({
    super.key,
    required int price,
  })  : _price = price,
        super(text: tr("PRICE"), value: null);

  String get _value {
    if (_price == 0) return tr("FREE");
    if (_price == -1) return tr("NONE");
    return "$_price";
  }

  Widget _buildValue() {
    return WidgetText(
      _value,
      color: Interface.dark,
      style: Style.normal.s18.w500,
      textAlign: TextAlign.end,
      maxLines: 1,
    );
  }

  Widget _buildMoney() {
    return SvgPicture.asset(
      Assets.graphics.icons.money,
      width: 15,
      height: 15,
      colorFilter: ColorFilter.mode(
        Interface.dark,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget buildValue() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_price != 0 && _price != -1) WidgetMargin.right(4, child: _buildMoney()),
        _buildValue(),
      ],
    );
  }
}
