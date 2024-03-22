import 'package:cotwcompanion/builders/multimounts.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/lists/home/items.dart';
import 'package:cotwcompanion/lists/other/dlcs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListOther extends ListItems {
  const ListOther({
    super.key,
  }) : super("OTHER");

  @override
  State<StatefulWidget> createState() => ListOtherState();
}

class ListOtherState extends ListItemsState {
  @override
  List<List<dynamic>> get items => [
        [tr("CONTENT_MATMATS_MULTIMOUNTS"), Assets.graphics.icons.hammer, const BuilderMultimounts()],
        [tr("CONTENT_DOWNLOADABLE_CONTENT"), Assets.graphics.icons.dlc, const ListDlcs()],
      ];
}
