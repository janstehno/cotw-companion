import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/lists/general/translatables.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/widgets/parts/caller/caller.dart';

class ListCallers extends ListTranslatable {
  const ListCallers({
    super.key,
  }) : super("CALLERS");

  @override
  ListCallersState createState() => ListCallersState();
}

class ListCallersState extends ListTranslatableState<Caller> {
  @override
  void initState() {
    filter = HelperFilter.filterCallers;
    super.initState();
  }

  @override
  List<Caller> initialItems() {
    return HelperJSON.callers;
  }

  @override
  WidgetCaller buildEntry(index, item) {
    return WidgetCaller(
      item,
      i: index,
      onTap: focus,
    );
  }
}
