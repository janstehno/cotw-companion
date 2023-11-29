// Copyright (c) 2023 Jan Stehno

class IdtoId {
  final int _firstId, _secondId;

  IdtoId({
    required firstId,
    required secondId,
  })  : _firstId = firstId,
        _secondId = secondId;

  int get firstId => _firstId;

  int get secondId => _secondId;

  factory IdtoId.fromJson(Map<String, dynamic> json, String first, String second) {
    return IdtoId(
      firstId: json[first],
      secondId: json[second],
    );
  }
}
