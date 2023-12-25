import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/entries/parameter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntryParameterPrice extends EntryParameter {
  final int price;

  EntryParameterPrice({
    super.key,
    required this.price,
  }) : super(text: tr("price"), value: null);

  @override
  Widget buildValue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        price == 0 || price == -1
            ? const SizedBox.shrink()
            : Container(
                margin: const EdgeInsets.only(right: 4),
                child: SvgPicture.asset(
                  "assets/graphics/icons/money.svg",
                  width: 15,
                  height: 15,
                  colorFilter: ColorFilter.mode(
                    Interface.dark,
                    BlendMode.srcIn,
                  ),
                )),
        AutoSizeText(
          price == 0
              ? tr("free")
              : price == -1
                  ? tr("none")
                  : "$price",
          maxLines: 1,
          textAlign: TextAlign.start,
          style: Interface.s18w500n(Interface.dark),
        )
      ],
    );
  }
}
