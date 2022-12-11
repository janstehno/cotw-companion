// Copyright (c) 2022 Jan Stehno

class IDtoIDList {
  List<IDtoID> idToID;

  IDtoIDList.idToID({required this.idToID});

  factory IDtoIDList.fromJson(List<dynamic> json, String f, String s) {
    List<IDtoID> idToID = <IDtoID>[];
    idToID = json.map((i) => IDtoID.fromJson(i, f, s)).toList();
    return IDtoIDList.idToID(idToID: idToID);
  }
}

class IDtoID {
  int id;
  int firstID, secondID;

  IDtoID({required this.id, required this.firstID, required this.secondID});

  int get getID => id;

  int get getFirstID => firstID;

  int get getSecondID => secondID;

  factory IDtoID.fromJson(Map<String, dynamic> json, String f, String s) {
    return IDtoID(id: json['ID'], firstID: json[f], secondID: json[s]);
  }
}
