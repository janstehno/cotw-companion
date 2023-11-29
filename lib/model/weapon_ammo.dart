// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/model/idtoid.dart';

class WeaponAmmo extends IdtoId {
  final int _id;

  WeaponAmmo({
    required id,
    required super.firstId,
    required super.secondId,
  }) : _id = id;

  int get id => _id;

  factory WeaponAmmo.fromJson(Map<String, dynamic> json, String first, String second) {
    return WeaponAmmo(
      id: json['ID'],
      firstId: json[first],
      secondId: json[second],
    );
  }
}
