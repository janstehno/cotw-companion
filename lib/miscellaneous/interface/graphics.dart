// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/types.dart';

class Graphics {
  static const String _directory = "assets/graphics";
  static const List<String> _reserves = [
    "hirschfeldenhuntingreserve",
    "laytonlakedistrict",
    "medvedtaiganationalpark",
    "vurhongasavannareserve",
    "parquefernando",
    "yukonvalley",
    "cuatrocolinasgamereserve",
    "silverridgepeaks",
    "teawaroanationalpark",
    "ranchodelarroyo",
    "mississippiacrespreserve",
    "revontulicoast",
    "newenglandmountains",
    "emeraldcoastaustralia"
  ];

  static const List<String> _callers = [
    "antlerrattler",
    "axisdeerscreamercaller",
    "beacondeluxeduckcaller",
    "bucksnortwheezecaller",
    "deerbleatcaller",
    "deergruntcaller",
    "elkcaller",
    "moosecaller",
    "predatordistressedfawncaller",
    "predatorjackrabbitcaller",
    "reddeercaller",
    "roedeercaller",
    "shortreedcanadagoosecaller",
    "wildboarcaller",
    "wildturkeycrowcaller",
    "wildturkeymouthcaller",
    "raccoonsquallcaller",
    "beacondeluxeeurasiantealcaller",
    "beacondeluxeeurasianwigeoncaller",
    "beacondeluxebeangoosecaller",
    "beacondeluxegreylaggoosecaller",
    "hazelgrousecaller",
    "sambarmouthcaller",
    "magpiegoosecaller"
  ];

  static const List<String> _weapons = [
    "223docent",
    "243ranger",
    "270huntsman",
    "7mmregentmagnum",
    "rangemaster338",
    "whitlockmodel86",
    "coachmatelever4570",
    "virant22lr",
    "king470db",
    "solokhinmn1890",
    "300canningmagnum",
    "vasquezcyclone45",
    "eckers3006",
    "martensson65mm",
    "hudzik50caplock",
    "m1iwaniec",
    "cavershamsteward12g",
    "cacciatore12g",
    "streckersxs20g",
    "nordin20sa",
    "grelckdrillingrifle",
    "millermodel1891",
    "razorbacklitecb60",
    "bearclawlitecb60",
    "hawkedgecb70",
    "houyirecurvebow",
    "crosspointcb165",
    "focoso357",
    "44panthermagnum",
    "rhino454",
    "mangiafico41045colt",
    "andersson22lr",
    "alexanderlongbow",
    "kotercb65",
    "303flsporter",
    "cousomodel1897",
    "kullman22h",
    "zarza1522lr",
    "zarza15223",
    "zarza10308",
    "243rcuomo",
    "45rolleston",
    "10mmdavani",
    "curman50inline",
    "tsurugilrr338",
    "malmer7mmmagnum",
    "olssonmodel23308",
    "zaganvarminter22250"
  ];

  static const List<String> _animals = [
    "axisdeer",
    "beceiteibex",
    "bighornsheep",
    "blackbear",
    "blackbuck",
    "blacktaildeer",
    "bluewildebeest",
    "brownbear",
    "canadagoose",
    "capebuffalo",
    "caribou",
    "cinnamonteal",
    "coyote",
    "eurasianlynx",
    "europeanbison",
    "europeanhare",
    "europeanrabbit",
    "fallowdeer",
    "gemsbok",
    "graywolf",
    "gredosibex",
    "grizzlybear",
    "harlequinduck",
    "iberianmouflon",
    "iberianwolf",
    "lesserkudu",
    "lion",
    "mallard",
    "moose",
    "mountaingoat",
    "muledeer",
    "plainsbison",
    "pronghorn",
    "puma",
    "reddeer",
    "redfox",
    "reindeer",
    "rockymountainelk",
    "roedeer",
    "rondaibex",
    "rooseveltelk",
    "scrubhare",
    "siberianmuskdeer",
    "sidestripedjackal",
    "southeasternspanishibex",
    "springbok",
    "turkey",
    "warthog",
    "waterbuffalo",
    "whitetailedjackrabbit",
    "whitetaildeer",
    "wildboar",
    "chamois",
    "feralgoat",
    "feralpig",
    "sikadeer",
    "ringneckedpheasant",
    "turkey",
    "collaredpeccary",
    "mexicanbobcat",
    "antelopejackrabbit",
    "americanalligator",
    "grayfox",
    "commonraccoon",
    "easterncottontailrabbit",
    "turkey",
    "bobwhitequail",
    "goldeneye",
    "tuftedduck",
    "eurasianteal",
    "eurasianwigeon",
    "tundrabeangoose",
    "greylaggoose",
    "blackgrouse",
    "hazelgrouse",
    "westerncapercaillie",
    "rockptarmigan",
    "willowptarmigan",
    "mountainhare",
    "raccoondog",
    "greenwingedteal",
    "stubblequail",
    "magpiegoose",
    "hogdeer",
    "easterngraykangaroo",
    "javanrusa",
    "sambar",
    "saltwatercrocodile",
    "banteng"
  ];

  static String getReserveIcon(int id) {
    return "$_directory/reserves/${_reserves[id - 1]}.svg";
  }

  static String getCallerIcon(int id) {
    return "$_directory/callers/${_callers[id - 1]}.svg";
  }

  static String getWeaponIcon(int id) {
    return "$_directory/weapons/${_weapons[id - 1]}.svg";
  }

  static String getAnimalIcon(int id) {
    return "$_directory/animals/${_animals[id - 1]}.svg";
  }

  static String getAnimalHead(int id) {
    return "$_directory/heads/${_animals[id - 1]}.svg";
  }

  static String getAnimalBackground(int id) {
    return "$_directory/images/${_animals[id - 1]}.jpg";
  }

  static String getAnatomyAsset(int id, AnatomyType part) {
    return "assets/graphics/anatomy/${_animals[id - 1]}_${part.name}.svg";
  }

  static String getMapTile(int id, int x, int y, int z) {
    return "$_directory/maps/${_reserves[id - 1]}/$z/[$x][$y].png";
  }

  static String getMapObjectIcon(MapObjectType type, int z) {
    String asset = "$_directory/icons/pngs/$z";
    switch (type.index) {
      case 0:
        return "$asset/outpost.png";
      case 1:
        return "$asset/lookout.png";
      case 2:
        return "$asset/hide.png";
      default:
        return "";
    }
  }
}
