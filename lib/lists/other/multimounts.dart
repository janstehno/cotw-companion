import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/multimounts.dart';
import 'package:cotwcompanion/lists/general/translatables.dart';
import 'package:cotwcompanion/model/translatable/multimount.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/parts/multimounts/multimount.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListMultimounts extends ListTranslatable {
  final HelperMultimounts _helperMultimounts;

  const ListMultimounts({
    super.key,
    required HelperMultimounts helperMultimounts,
  })  : _helperMultimounts = helperMultimounts,
        super("CONTENT_MATMATS_MULTIMOUNTS");

  HelperMultimounts get helperMultimounts => _helperMultimounts;

  @override
  ListMultimountsState createState() => ListMultimountsState();
}

class ListMultimountsState extends ListTranslatableState<Multimount> {
  @override
  void initState() {
    filter = HelperFilter.filterMultimounts;
    super.initState();
  }

  @override
  List<Multimount> initialItems() {
    return (widget as ListMultimounts).helperMultimounts.multimounts.sorted(Multimount.sortByName);
  }

  @override
  Widget buildEntry(index, item) {
    return WidgetMultimount(
      item,
      i: index,
    );
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr(widget.title),
        context: context,
        helpUrl: "https://github.com/janstehno/cotw-companion/wiki/Matmat's-multi-trophy-mounts",
      ),
      searchController: controller,
      filterChanged: filter.isActive(),
      children: listEntries(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
