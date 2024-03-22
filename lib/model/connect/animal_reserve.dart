class AnimalReserve {
  final int _animalId;
  final int _reserveId;

  AnimalReserve({
    required int animalId,
    required int reserveId,
  })  : _animalId = animalId,
        _reserveId = reserveId;

  int get animalId => _animalId;

  int get reserveId => _reserveId;

  factory AnimalReserve.fromJson(Map<String, dynamic> json) {
    return AnimalReserve(
      animalId: json['ANIMAL_ID'],
      reserveId: json['RESERVE_ID'],
    );
  }
}
