import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';

class AnimalFurImage {
  final int _animalId;
  final int _furId;
  final bool _shared;
  final Map<String, dynamic> _images;

  AnimalFurImage({
    required int animalId,
    required int furId,
    required bool shared,
    required Map<String, dynamic> images,
  })  : _animalId = animalId,
        _furId = furId,
        _shared = shared,
        _images = images;

  int get animalId => _animalId;

  int get furId => _furId;

  bool get isGO {
    Animal? animal = HelperJSON.getAnimal(_animalId);
    if (animal == null || !animal.hasGO) return false;
    return animal.furGO.contains(_furId) && _furId >= 100;
  }

  bool get shared => _shared;

  Map<String, dynamic> get images => _images;

  bool get hasMale => _images.containsKey("MALE");

  bool get hasFemale => _images.containsKey("FEMALE");

  bool get hasBoth => hasMale && hasFemale;

  String get animalName {
    return HelperJSON.getAnimal(_animalId)!.name;
  }

  String get furName {
    return HelperJSON.getFur(_furId)!.name;
  }

  List<String> imagesFor(CategoryType category) {
    String key = category.name.toUpperCase();
    if (!_images.containsKey(key)) return [];
    return (_images[key]! as List).map((e) => "assets/graphics/furs/${e.toString()}.webp").toList();
  }

  factory AnimalFurImage.fromJson(Map<String, dynamic> json) {
    return AnimalFurImage(
      animalId: json['ANIMAL_ID'],
      furId: json['FUR_ID'],
      shared: json['SHARED'],
      images: json['IMAGES'],
    );
  }
}
