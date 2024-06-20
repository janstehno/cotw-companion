import 'package:cotwcompanion/activities/map.dart';
import 'package:cotwcompanion/builders/builder.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/map.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:flutter/material.dart';

class BuilderMap extends BuilderBuilder {
  final Reserve _reserve;

  const BuilderMap({
    super.key,
    required Reserve reserve,
  })  : _reserve = reserve,
        super("M");

  Reserve get reserve => _reserve;

  @override
  State<StatefulWidget> createState() => BuilderMapState();
}

class BuilderMapState extends BuilderBuilderState {
  late final HelperMap _helperMap;

  final Map<String, String> _reserves = {
    "RESERVE:SILVER_RIDGE_PEAKS": Assets.raw.maps.silverridgepeaks,
    "RESERVE:NEW_ENGLAND_MOUNTAINS": Assets.raw.maps.newenglandmountains,
    "RESERVE:LAYTON_LAKE_DISTRICT": Assets.raw.maps.laytonlakedistrict,
    "RESERVE:TE_AWAROA_NATIONAL_PARK": Assets.raw.maps.teawaroanationalpark,
    "RESERVE:CUATRO_COLINAS_GAME_RESERVE": Assets.raw.maps.cuatrocolinasgamereserve,
    "RESERVE:PARQUE_FERNANDO": Assets.raw.maps.parquefernando,
    "RESERVE:RANCHO_DEL_ARROYO": Assets.raw.maps.ranchodelarroyo,
    "RESERVE:REVONTULI_COAST": Assets.raw.maps.revontulicoast,
    "RESERVE:EMERALD_COAST_AUSTRALIA": Assets.raw.maps.emeraldcoastaustralia,
    "RESERVE:VURHONGA_SAVANNA_RESERVE": Assets.raw.maps.vurhongasavannareserve,
    "RESERVE:HIRSCHFELDEN_HUNTING_RESERVE": Assets.raw.maps.hirschfeldenhuntingreserve,
    "RESERVE:MEDVED_TAIGA_NATIONAL_PARK": Assets.raw.maps.medvedtaiganationalpark,
    "RESERVE:YUKON_VALLEY": Assets.raw.maps.yukonvalley,
    "RESERVE:MISSISSIPPI_ACRES_PRESERVE": Assets.raw.maps.mississippiacrespreserve,
  };

  @override
  void initState() {
    _helperMap = HelperMap(reserve: (widget as BuilderMap).reserve);
    super.initState();
  }

  @override
  void initializeData(AsyncSnapshot<Map<String, dynamic>> snapshot, BuildContext context) {
    Map<String, dynamic> mapObjects = snapshot.data!["mapObjects"] ?? {};
    _helperMap.addObjects(mapObjects);
  }

  @override
  Future<Map<String, dynamic>> loadData() async {
    Map<String, dynamic> mapObjects = await _helperMap.readMapObjects(_reserves[_helperMap.reserve.asset]);
    updateProgress("mapObjects", mapObjects);
    await Future.delayed(const Duration(seconds: 1), () {});
    return loadedData;
  }

  @override
  Widget buildFutureWidget(BuildContext context) => ActivityMap(helperMap: _helperMap);
}
