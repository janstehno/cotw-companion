class AnimalCaller {
  final int _animalId;
  final int _callerId;

  AnimalCaller({
    required int animalId,
    required int callerId,
  })  : _animalId = animalId,
        _callerId = callerId;

  int get animalId => _animalId;

  int get callerId => _callerId;

  factory AnimalCaller.fromJson(Map<String, dynamic> json) {
    return AnimalCaller(
      animalId: json['ANIMAL_ID'],
      callerId: json['CALLER_ID'],
    );
  }
}
