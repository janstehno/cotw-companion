import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/detail/dlc.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/describable/dlc.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/section/section_tap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListDlcs extends StatelessWidget {
  const ListDlcs({
    super.key,
  });

  List<Dlc> get _dlcs => HelperJSON.dlcs.sorted(Dlc.sortByDate);

  void onTap(BuildContext context, Dlc dlc) {
    if (dlc.type != -1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (e) => ActivityDetailDlc(dlc)),
      );
    }
  }

  Widget _buildDlc(int i, Dlc dlc, BuildContext context) {
    return WidgetSectionTap(
      dlc.name,
      color: dlc.type != -1 ? Interface.dark : Interface.disabled,
      background: Utils.backgroundAt(i),
      onTap: () => onTap(context, dlc),
    );
  }

  List<Widget> _listDlcs(BuildContext context) {
    return _dlcs.mapIndexed((i, dlc) => _buildDlc(i, dlc, context)).toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr("CONTENT_DOWNLOADABLE_CONTENT"),
        context: context,
      ),
      children: _listDlcs(context),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
