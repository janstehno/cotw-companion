// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class EntryStatistics extends StatelessWidget {
  final List<String> labels;
  final List<dynamic> values;

  final double height = 65;
  final double _iconSize = 15;

  const EntryStatistics({
    Key? key,
    required this.labels,
    required this.values,
  })  : assert(labels.length == values.length && values.length == 4),
        super(key: key);

  Widget _buildDetail(bool leftToRight, String icon, dynamic value) {
    return Container(
        alignment: Alignment.center,
        height: height / 2,
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          leftToRight
              ? const SizedBox.shrink()
              : Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    value.toString(),
                    style: Interface.s16w300n(Interface.dark),
                  )),
          SvgPicture.asset(
            "assets/graphics/icons/$icon.svg",
            width: _iconSize,
            height: _iconSize,
            colorFilter: ColorFilter.mode(
              Interface.dark,
              BlendMode.srcIn,
            ),
          ),
          leftToRight
              ? Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    value.toString(),
                    style: Interface.s16w300n(Interface.dark),
                  ))
              : const SizedBox.shrink()
        ]));
  }

  Widget _buildWidgets() {
    return Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetail(true, labels[0], values[0]),
                _buildDetail(false, labels[1], values[1]),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetail(true, labels[2], values[2]),
                _buildDetail(false, labels[3], values[3]),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
