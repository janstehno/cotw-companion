// Copyright (c) 2022 Jan Stehno

class Graphics {
  static const String _directory = "assets/graphics/";
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
    "revontulicoast"
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
    "hazelgrousecaller"
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
    "10mmdavani"
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
    "raccoondog"
  ];

  static String getReserveIcon(int i) {
    return "${_directory}reserves/${_reserves[i - 1]}.svg";
  }

  static String getCallerIcon(int i) {
    return "${_directory}callers/${_callers[i - 1]}.svg";
  }

  static String getWeaponIcon(int i) {
    return "${_directory}weapons/${_weapons[i - 1]}.svg";
  }

  static String getAnimalIcon(int i) {
    return "${_directory}animals/${_animals[i - 1]}.svg";
  }

  static String getAnimalHead(int i) {
    return "${_directory}heads/${_animals[i - 1]}.svg";
  }

  static String getAnimalBackground(int i) {
    return "${_directory}backgrounds/${_animals[i - 1]}.jpg";
  }
}
