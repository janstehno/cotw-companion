// Copyright (c) 2022 - 2023 Jan Stehno

class IdtoId {
  final int _id;
  final int _firstId, _secondId;

  IdtoId({
    required id,
    required firstId,
    required secondId,
  })  : _id = id,
        _firstId = firstId,
        _secondId = secondId;

  int get id => _id;

  int get firstId => _firstId;

  int get secondId => _secondId;

  factory IdtoId.fromJson(Map<String, dynamic> json, String first, String second) {
    return IdtoId(
      id: json['ID'],
      firstId: json[first],
      secondId: json[second],
    );
  }
}
