// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

class EntryPartNameImage extends StatelessWidget {
  final String text;
  final String icon;

  const EntryPartNameImage({Key? key, required this.text, required this.icon}) : super(key: key);

  Widget _buildWidgets() {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Expanded(
          child: Container(
              padding: const EdgeInsets.only(right: 30),
              child: AutoSizeText(text,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600)))),
      Container(width: 100, height: 100, alignment: Alignment.center, child: SvgPicture.asset(icon, color: Color(Values.colorContentIconTintDark), width: 70, height: 70))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
