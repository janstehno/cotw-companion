import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/multimounts.dart';
import 'package:cotwcompanion/model/translatable/multimount.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/parts/multimounts/multimount.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListMultimounts extends StatelessWidget {
  final HelperMultimounts _helperMultimounts;

  const ListMultimounts({
    super.key,
    required HelperMultimounts helperMultimounts,
  }) : _helperMultimounts = helperMultimounts;

  List<Multimount> get _multimounts => _helperMultimounts.multimounts.sorted(Multimount.sortByName);

  Widget _buildMultimount(Multimount multimount) {
    return WidgetMultimount(
      multimount,
      i: _multimounts.indexOf(multimount),
    );
  }

  List<Widget> _listMultimounts() {
    return _multimounts.map((e) => _buildMultimount(e)).toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr("CONTENT_MATMATS_MULTIMOUNTS"),
        context: context,
        helpUrl: "https://github.com/janstehno/cotw-companion/wiki/Matmat's-multi-trophy-mounts",
      ),
      children: _listMultimounts(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
