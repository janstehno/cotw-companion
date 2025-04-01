import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/lists/general/translatables.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/parts/reserve/reserve.dart';

class ListReserves extends ListTranslatable {
  const ListReserves({
    super.key,
  }) : super("RESERVES");

  @override
  ListReservesState createState() => ListReservesState();
}

class ListReservesState extends ListTranslatableState<Reserve> {
  @override
  void initState() {
    filter = HelperFilter.filterReserves;
    super.initState();
  }

  @override
  List<Reserve> initialItems() {
    return HelperJSON.reserves;
  }

  @override
  WidgetReserve buildEntry(index, item) {
    return WidgetReserve(
      item,
      i: index,
      onTap: focus,
    );
  }
}
