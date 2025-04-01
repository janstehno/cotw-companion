import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/activities/filter/missions.dart';
import 'package:cotwcompanion/filters/missions.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/lists/general/translatables.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/parts/mission/mission.dart';

class ListReserveMissions extends ListTranslatable {
  final Reserve _reserve;

  const ListReserveMissions(
    Reserve reserve, {
    super.key,
  })  : _reserve = reserve,
        super("MISSIONS");

  Reserve get reserve => _reserve;

  @override
  ListReserveMissionsState createState() => ListReserveMissionsState();
}

class ListReserveMissionsState extends ListTranslatableState<Mission> {
  @override
  void initState() {
    filter = FilterMissions();
    super.initState();
  }

  @override
  ActivityFilter<Mission> get activityFilter => ActivityFilterMissions(
        filter: filter as FilterMissions,
        onConfirm: filterItems,
      );

  @override
  List<Mission> initialItems() {
    return HelperJSON.getReserveMissions((widget as ListReserveMissions).reserve.id);
  }

  @override
  WidgetMission buildEntry(index, item) {
    return WidgetMission(
      item,
      i: index,
      onTap: focus,
    );
  }
}
