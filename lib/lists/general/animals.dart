import 'package:cotwcompanion/activities/filter/animals.dart';
import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/filters/animals.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/lists/general/translatables.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal.dart';

class ListAnimals extends ListTranslatable {
  const ListAnimals({
    super.key,
  }) : super("WILDLIFE");

  @override
  ListAnimalsState createState() => ListAnimalsState();
}

class ListAnimalsState extends ListTranslatableState<Animal> {
  @override
  void initState() {
    filter = HelperFilter.filterAnimals;
    super.initState();
  }

  @override
  ActivityFilter<Animal> get activityFilter => ActivityFilterAnimals(
        filter: filter as FilterAnimals,
        onConfirm: filterItems,
      );

  @override
  List<Animal> initialItems() {
    return HelperJSON.animals;
  }

  @override
  WidgetAnimal buildEntry(index, item) {
    return WidgetAnimal(
      item,
      i: index,
      onTap: focus,
    );
  }
}
