import 'package:cotwcompanion/model/translatable/translatable.dart';

class Fur extends Translatable {
  Fur({
    required super.id,
    required super.name,
  });

  factory Fur.fromJson(Map<String, dynamic> json) {
    return Fur(
      id: json['ID'],
      name: json['NAME'],
    );
  }

  static Comparator<Fur> sortByName = (a, b) => a.name.compareTo(b.name);
}
