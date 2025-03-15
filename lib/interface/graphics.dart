import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/proficiency.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';

class Graphics {
  static final Map<String, String> _animals = {
    "ANIMAL:IBERIAN_WOLF": Assets.graphics.animals.iberianwolf,
    "ANIMAL:BLACK_GROUSE": Assets.graphics.animals.blackgrouse,
    "ANIMAL:MERRIAM_TURKEY": Assets.graphics.animals.turkey,
    "ANIMAL:BECEITE_IBEX": Assets.graphics.animals.beceiteibex,
    "ANIMAL:GREDOS_IBEX": Assets.graphics.animals.gredosibex,
    "ANIMAL:FERAL_GOAT": Assets.graphics.animals.feralgoat,
    "ANIMAL:EASTERN_WILD_TURKEY": Assets.graphics.animals.turkey,
    "ANIMAL:GRAY_WOLF": Assets.graphics.animals.graywolf,
    "ANIMAL:SPRINGBOK": Assets.graphics.animals.springbok,
    "ANIMAL:TUFTED_DUCK": Assets.graphics.animals.tuftedduck,
    "ANIMAL:MULE_DEER": Assets.graphics.animals.muledeer,
    "ANIMAL:MAGPIE_GOOSE": Assets.graphics.animals.magpiegoose,
    "ANIMAL:FALLOW_DEER": Assets.graphics.animals.fallowdeer,
    "ANIMAL:EUROPEAN_HARE": Assets.graphics.animals.europeanhare,
    "ANIMAL:WARTHOG": Assets.graphics.animals.warthog,
    "ANIMAL:EUROPEAN_RABBIT": Assets.graphics.animals.europeanrabbit,
    "ANIMAL:BLACKBUCK": Assets.graphics.animals.blackbuck,
    "ANIMAL:LESSER_KUDU": Assets.graphics.animals.lesserkudu,
    "ANIMAL:CARIBOU": Assets.graphics.animals.caribou,
    "ANIMAL:WILD_BOAR": Assets.graphics.animals.wildboar,
    "ANIMAL:GOLDENEYE": Assets.graphics.animals.goldeneye,
    "ANIMAL:GREENWINGED_TEAL": Assets.graphics.animals.eurasianteal,
    "ANIMAL:FERAL_PIG": Assets.graphics.animals.feralpig,
    "ANIMAL:SIDE_STRIPED_JACKAL": Assets.graphics.animals.sidestripedjackal,
    "ANIMAL:GREYLAG_GOOSE": Assets.graphics.animals.greylaggoose,
    "ANIMAL:HARLEQUIN_DUCK": Assets.graphics.animals.harlequinduck,
    "ANIMAL:LION": Assets.graphics.animals.lion,
    "ANIMAL:EASTERN_COTTONTAIL_RABBIT": Assets.graphics.animals.easterncottontailrabbit,
    "ANIMAL:MOOSE": Assets.graphics.animals.moose,
    "ANIMAL:BROWN_BEAR": Assets.graphics.animals.brownbear,
    "ANIMAL:BLACKTAIL_DEER": Assets.graphics.animals.blacktaildeer,
    "ANIMAL:RED_DEER": Assets.graphics.animals.reddeer,
    "ANIMAL:TUNDRA_BEAN_GOOSE": Assets.graphics.animals.tundrabeangoose,
    "ANIMAL:SIKA_DEER": Assets.graphics.animals.sikadeer,
    "ANIMAL:ANTELOPE_JACKRABBIT": Assets.graphics.animals.antelopejackrabbit,
    "ANIMAL:MOUNTAIN_HARE": Assets.graphics.animals.mountainhare,
    "ANIMAL:RACCOON_DOG": Assets.graphics.animals.raccoondog,
    "ANIMAL:AXIS_DEER": Assets.graphics.animals.axisdeer,
    "ANIMAL:MALLARD": Assets.graphics.animals.mallard,
    "ANIMAL:SCRUB_HARE": Assets.graphics.animals.scrubhare,
    "ANIMAL:EURASIAN_TEAL": Assets.graphics.animals.eurasianteal,
    "ANIMAL:MOUNTAIN_GOAT": Assets.graphics.animals.mountaingoat,
    "ANIMAL:PRONGHORN": Assets.graphics.animals.pronghorn,
    "ANIMAL:ROOSEVELT_ELK": Assets.graphics.animals.rooseveltelk,
    "ANIMAL:RIO_GRANDE_TURKEY": Assets.graphics.animals.turkey,
    "ANIMAL:RINGNECKED_PHEASANT": Assets.graphics.animals.ringneckedpheasant,
    "ANIMAL:BOBWHITE_QUAIL": Assets.graphics.animals.bobwhitequail,
    "ANIMAL:PUMA": Assets.graphics.animals.puma,
    "ANIMAL:WHITE_TAILED_JACKRABBIT": Assets.graphics.animals.whitetailedjackrabbit,
    "ANIMAL:PLAINS_BISON": Assets.graphics.animals.plainsbison,
    "ANIMAL:EURASIAN_LYNX": Assets.graphics.animals.eurasianlynx,
    "ANIMAL:IBERIAN_MOUFLON": Assets.graphics.animals.iberianmouflon,
    "ANIMAL:SAMBAR": Assets.graphics.animals.sambar,
    "ANIMAL:SALTWATER_CROCODILE": Assets.graphics.animals.saltwatercrocodile,
    "ANIMAL:GEMSBOK": Assets.graphics.animals.gemsbok,
    "ANIMAL:SIBERIAN_MUSK_DEER": Assets.graphics.animals.siberianmuskdeer,
    "ANIMAL:JAVAN_RUSA": Assets.graphics.animals.javanrusa,
    "ANIMAL:SOUTHEASTERN_SPANISH_IBEX": Assets.graphics.animals.southeasternspanishibex,
    "ANIMAL:RED_FOX": Assets.graphics.animals.redfox,
    "ANIMAL:EUROPEAN_BISON": Assets.graphics.animals.europeanbison,
    "ANIMAL:GRIZZLY_BEAR": Assets.graphics.animals.grizzlybear,
    "ANIMAL:GRAY_FOX": Assets.graphics.animals.grayfox,
    "ANIMAL:BLUE_WILDEBEEST": Assets.graphics.animals.bluewildebeest,
    "ANIMAL:COYOTE": Assets.graphics.animals.coyote,
    "ANIMAL:AMERICAN_ALLIGATOR": Assets.graphics.animals.americanalligator,
    "ANIMAL:CINNAMON_TEAL": Assets.graphics.animals.cinnamonteal,
    "ANIMAL:WHITETAIL_DEER": Assets.graphics.animals.whitetaildeer,
    "ANIMAL:EURASIAN_WIGEON": Assets.graphics.animals.eurasianwigeon,
    "ANIMAL:COMMON_RACCOON": Assets.graphics.animals.commonraccoon,
    "ANIMAL:ROCK_PTARMIGAN": Assets.graphics.animals.rockptarmigan,
    "ANIMAL:CANADA_GOOSE": Assets.graphics.animals.canadagoose,
    "ANIMAL:CHAMOIS": Assets.graphics.animals.chamois,
    "ANIMAL:CAPE_BUFFALO": Assets.graphics.animals.capebuffalo,
    "ANIMAL:RONDA_IBEX": Assets.graphics.animals.rondaibex,
    "ANIMAL:WILLOW_PTARMIGAN": Assets.graphics.animals.willowptarmigan,
    "ANIMAL:BLACK_BEAR": Assets.graphics.animals.blackbear,
    "ANIMAL:HAZEL_GROUSE": Assets.graphics.animals.hazelgrouse,
    "ANIMAL:EASTERN_GRAY_KANGAROO": Assets.graphics.animals.easterngraykangaroo,
    "ANIMAL:ROE_DEER": Assets.graphics.animals.roedeer,
    "ANIMAL:MEXICAN_BOBCAT": Assets.graphics.animals.mexicanbobcat,
    "ANIMAL:COLLARED_PECCARY": Assets.graphics.animals.collaredpeccary,
    "ANIMAL:STUBBLE_QUAIL": Assets.graphics.animals.stubblequail,
    "ANIMAL:BANTENG": Assets.graphics.animals.banteng,
    "ANIMAL:HOG_DEER": Assets.graphics.animals.hogdeer,
    "ANIMAL:REINDEER": Assets.graphics.animals.reindeer,
    "ANIMAL:WATER_BUFFALO": Assets.graphics.animals.waterbuffalo,
    "ANIMAL:WESTERN_CAPERCAILLIE": Assets.graphics.animals.westerncapercaillie,
    "ANIMAL:ROCKY_MOUNTAIN_ELK": Assets.graphics.animals.rockymountainelk,
    "ANIMAL:BIGHORN_SHEEP": Assets.graphics.animals.bighornsheep,
    "ANIMAL:WOOLLY_HARE": Assets.graphics.animals.woollyhare,
    "ANIMAL:TIBETAN_FOX": Assets.graphics.animals.tibetanfox,
    "ANIMAL:NORTHERN_RED_MUNTJAC": Assets.graphics.animals.northernredmuntjac,
    "ANIMAL:BLUE_SHEEP": Assets.graphics.animals.bluesheep,
    "ANIMAL:TAHR": Assets.graphics.animals.tahr,
    "ANIMAL:SNOW_LEOPARD": Assets.graphics.animals.snowleopard,
    "ANIMAL:BARASINGHA": Assets.graphics.animals.barasingha,
    "ANIMAL:NILGAI": Assets.graphics.animals.nilgai,
    "ANIMAL:WILD_YAK": Assets.graphics.animals.wildyak,
    "ANIMAL:BENGAL_TIGER": Assets.graphics.animals.bengaltiger,
    "ANIMAL:FERRUGINOUS_DUCK": Assets.graphics.animals.ferruginousduck,
    "ANIMAL:GADWALL": Assets.graphics.animals.gadwall,
  };

  static final Map<String, String> _heads = {
    "ANIMAL:IBERIAN_WOLF": Assets.graphics.heads.iberianwolf.path,
    "ANIMAL:BLACK_GROUSE": Assets.graphics.heads.blackgrouse.path,
    "ANIMAL:MERRIAM_TURKEY": Assets.graphics.heads.turkey.path,
    "ANIMAL:BECEITE_IBEX": Assets.graphics.heads.beceiteibex.path,
    "ANIMAL:GREDOS_IBEX": Assets.graphics.heads.gredosibex.path,
    "ANIMAL:FERAL_GOAT": Assets.graphics.heads.feralgoat.path,
    "ANIMAL:EASTERN_WILD_TURKEY": Assets.graphics.heads.turkey.path,
    "ANIMAL:GRAY_WOLF": Assets.graphics.heads.graywolf.path,
    "ANIMAL:SPRINGBOK": Assets.graphics.heads.springbok.path,
    "ANIMAL:TUFTED_DUCK": Assets.graphics.heads.tuftedduck.path,
    "ANIMAL:MULE_DEER": Assets.graphics.heads.muledeer.path,
    "ANIMAL:MAGPIE_GOOSE": Assets.graphics.heads.magpiegoose.path,
    "ANIMAL:FALLOW_DEER": Assets.graphics.heads.fallowdeer.path,
    "ANIMAL:EUROPEAN_HARE": Assets.graphics.heads.europeanhare.path,
    "ANIMAL:WARTHOG": Assets.graphics.heads.warthog.path,
    "ANIMAL:EUROPEAN_RABBIT": Assets.graphics.heads.europeanrabbit.path,
    "ANIMAL:BLACKBUCK": Assets.graphics.heads.blackbuck.path,
    "ANIMAL:LESSER_KUDU": Assets.graphics.heads.lesserkudu.path,
    "ANIMAL:CARIBOU": Assets.graphics.heads.caribou.path,
    "ANIMAL:WILD_BOAR": Assets.graphics.heads.wildboar.path,
    "ANIMAL:GOLDENEYE": Assets.graphics.heads.goldeneye.path,
    "ANIMAL:GREENWINGED_TEAL": Assets.graphics.heads.eurasianteal.path,
    "ANIMAL:FERAL_PIG": Assets.graphics.heads.feralpig.path,
    "ANIMAL:SIDE_STRIPED_JACKAL": Assets.graphics.heads.sidestripedjackal.path,
    "ANIMAL:GREYLAG_GOOSE": Assets.graphics.heads.greylaggoose.path,
    "ANIMAL:HARLEQUIN_DUCK": Assets.graphics.heads.harlequinduck.path,
    "ANIMAL:LION": Assets.graphics.heads.lion.path,
    "ANIMAL:EASTERN_COTTONTAIL_RABBIT": Assets.graphics.heads.easterncottontailrabbit.path,
    "ANIMAL:MOOSE": Assets.graphics.heads.moose.path,
    "ANIMAL:BROWN_BEAR": Assets.graphics.heads.brownbear.path,
    "ANIMAL:BLACKTAIL_DEER": Assets.graphics.heads.blacktaildeer.path,
    "ANIMAL:RED_DEER": Assets.graphics.heads.reddeer.path,
    "ANIMAL:TUNDRA_BEAN_GOOSE": Assets.graphics.heads.tundrabeangoose.path,
    "ANIMAL:SIKA_DEER": Assets.graphics.heads.sikadeer.path,
    "ANIMAL:ANTELOPE_JACKRABBIT": Assets.graphics.heads.antelopejackrabbit.path,
    "ANIMAL:MOUNTAIN_HARE": Assets.graphics.heads.mountainhare.path,
    "ANIMAL:RACCOON_DOG": Assets.graphics.heads.raccoondog.path,
    "ANIMAL:AXIS_DEER": Assets.graphics.heads.axisdeer.path,
    "ANIMAL:MALLARD": Assets.graphics.heads.mallard.path,
    "ANIMAL:SCRUB_HARE": Assets.graphics.heads.scrubhare.path,
    "ANIMAL:EURASIAN_TEAL": Assets.graphics.heads.eurasianteal.path,
    "ANIMAL:MOUNTAIN_GOAT": Assets.graphics.heads.mountaingoat.path,
    "ANIMAL:PRONGHORN": Assets.graphics.heads.pronghorn.path,
    "ANIMAL:ROOSEVELT_ELK": Assets.graphics.heads.rooseveltelk.path,
    "ANIMAL:RIO_GRANDE_TURKEY": Assets.graphics.heads.turkey.path,
    "ANIMAL:RINGNECKED_PHEASANT": Assets.graphics.heads.ringneckedpheasant.path,
    "ANIMAL:BOBWHITE_QUAIL": Assets.graphics.heads.bobwhitequail.path,
    "ANIMAL:PUMA": Assets.graphics.heads.puma.path,
    "ANIMAL:WHITE_TAILED_JACKRABBIT": Assets.graphics.heads.whitetailedjackrabbit.path,
    "ANIMAL:PLAINS_BISON": Assets.graphics.heads.plainsbison.path,
    "ANIMAL:EURASIAN_LYNX": Assets.graphics.heads.eurasianlynx.path,
    "ANIMAL:IBERIAN_MOUFLON": Assets.graphics.heads.iberianmouflon.path,
    "ANIMAL:SAMBAR": Assets.graphics.heads.sambar.path,
    "ANIMAL:SALTWATER_CROCODILE": Assets.graphics.heads.saltwatercrocodile.path,
    "ANIMAL:GEMSBOK": Assets.graphics.heads.gemsbok.path,
    "ANIMAL:SIBERIAN_MUSK_DEER": Assets.graphics.heads.siberianmuskdeer.path,
    "ANIMAL:JAVAN_RUSA": Assets.graphics.heads.javanrusa.path,
    "ANIMAL:SOUTHEASTERN_SPANISH_IBEX": Assets.graphics.heads.southeasternspanishibex.path,
    "ANIMAL:RED_FOX": Assets.graphics.heads.redfox.path,
    "ANIMAL:EUROPEAN_BISON": Assets.graphics.heads.europeanbison.path,
    "ANIMAL:GRIZZLY_BEAR": Assets.graphics.heads.grizzlybear.path,
    "ANIMAL:GRAY_FOX": Assets.graphics.heads.grayfox.path,
    "ANIMAL:BLUE_WILDEBEEST": Assets.graphics.heads.bluewildebeest.path,
    "ANIMAL:COYOTE": Assets.graphics.heads.coyote.path,
    "ANIMAL:AMERICAN_ALLIGATOR": Assets.graphics.heads.americanalligator.path,
    "ANIMAL:CINNAMON_TEAL": Assets.graphics.heads.cinnamonteal.path,
    "ANIMAL:WHITETAIL_DEER": Assets.graphics.heads.whitetaildeer.path,
    "ANIMAL:EURASIAN_WIGEON": Assets.graphics.heads.eurasianwigeon.path,
    "ANIMAL:COMMON_RACCOON": Assets.graphics.heads.commonraccoon.path,
    "ANIMAL:ROCK_PTARMIGAN": Assets.graphics.heads.rockptarmigan.path,
    "ANIMAL:CANADA_GOOSE": Assets.graphics.heads.canadagoose.path,
    "ANIMAL:CHAMOIS": Assets.graphics.heads.chamois.path,
    "ANIMAL:CAPE_BUFFALO": Assets.graphics.heads.capebuffalo.path,
    "ANIMAL:RONDA_IBEX": Assets.graphics.heads.rondaibex.path,
    "ANIMAL:WILLOW_PTARMIGAN": Assets.graphics.heads.willowptarmigan.path,
    "ANIMAL:BLACK_BEAR": Assets.graphics.heads.blackbear.path,
    "ANIMAL:HAZEL_GROUSE": Assets.graphics.heads.hazelgrouse.path,
    "ANIMAL:EASTERN_GRAY_KANGAROO": Assets.graphics.heads.easterngraykangaroo.path,
    "ANIMAL:ROE_DEER": Assets.graphics.heads.roedeer.path,
    "ANIMAL:MEXICAN_BOBCAT": Assets.graphics.heads.mexicanbobcat.path,
    "ANIMAL:COLLARED_PECCARY": Assets.graphics.heads.collaredpeccary.path,
    "ANIMAL:STUBBLE_QUAIL": Assets.graphics.heads.stubblequail.path,
    "ANIMAL:BANTENG": Assets.graphics.heads.banteng.path,
    "ANIMAL:HOG_DEER": Assets.graphics.heads.hogdeer.path,
    "ANIMAL:REINDEER": Assets.graphics.heads.reindeer.path,
    "ANIMAL:WATER_BUFFALO": Assets.graphics.heads.waterbuffalo.path,
    "ANIMAL:WESTERN_CAPERCAILLIE": Assets.graphics.heads.westerncapercaillie.path,
    "ANIMAL:ROCKY_MOUNTAIN_ELK": Assets.graphics.heads.rockymountainelk.path,
    "ANIMAL:BIGHORN_SHEEP": Assets.graphics.heads.bighornsheep.path,
    "ANIMAL:WOOLLY_HARE": Assets.graphics.heads.woollyhare.path,
    "ANIMAL:TIBETAN_FOX": Assets.graphics.heads.tibetanfox.path,
    "ANIMAL:NORTHERN_RED_MUNTJAC": Assets.graphics.heads.northernredmuntjac.path,
    "ANIMAL:BLUE_SHEEP": Assets.graphics.heads.bluesheep.path,
    "ANIMAL:TAHR": Assets.graphics.heads.tahr.path,
    "ANIMAL:SNOW_LEOPARD": Assets.graphics.heads.snowleopard.path,
    "ANIMAL:BARASINGHA": Assets.graphics.heads.barasingha.path,
    "ANIMAL:NILGAI": Assets.graphics.heads.nilgai.path,
    "ANIMAL:WILD_YAK": Assets.graphics.heads.wildyak.path,
    "ANIMAL:BENGAL_TIGER": Assets.graphics.heads.bengaltiger.path,
    "ANIMAL:FERRUGINOUS_DUCK": Assets.graphics.heads.ferruginousduck.path,
    "ANIMAL:GADWALL": Assets.graphics.heads.gadwall.path,
  };

  static final Map<String, String> _anatomy = {
    "ANIMAL:IBERIAN_WOLF": Assets.graphics.anatomy.iberianWolf.path,
    "ANIMAL:BECEITE_IBEX": Assets.graphics.anatomy.beceiteIbex.path,
    "ANIMAL:GREDOS_IBEX": Assets.graphics.anatomy.gredosIbex.path,
    "ANIMAL:FERAL_GOAT": Assets.graphics.anatomy.feralGoat.path,
    "ANIMAL:GRAY_WOLF": Assets.graphics.anatomy.grayWolf.path,
    "ANIMAL:SPRINGBOK": Assets.graphics.anatomy.springbok.path,
    "ANIMAL:MULE_DEER": Assets.graphics.anatomy.muleDeer.path,
    "ANIMAL:FALLOW_DEER": Assets.graphics.anatomy.fallowDeer.path,
    "ANIMAL:WARTHOG": Assets.graphics.anatomy.warthog.path,
    "ANIMAL:BLACKBUCK": Assets.graphics.anatomy.blackbuck.path,
    "ANIMAL:LESSER_KUDU": Assets.graphics.anatomy.lesserKudu.path,
    "ANIMAL:CARIBOU": Assets.graphics.anatomy.caribou.path,
    "ANIMAL:WILD_BOAR": Assets.graphics.anatomy.wildBoar.path,
    "ANIMAL:FERAL_PIG": Assets.graphics.anatomy.feralPig.path,
    "ANIMAL:SIDE_STRIPED_JACKAL": Assets.graphics.anatomy.sideStripedJackal.path,
    "ANIMAL:LION": Assets.graphics.anatomy.lion.path,
    "ANIMAL:MOOSE": Assets.graphics.anatomy.moose.path,
    "ANIMAL:BROWN_BEAR": Assets.graphics.anatomy.brownBear.path,
    "ANIMAL:BLACKTAIL_DEER": Assets.graphics.anatomy.blacktailDeer.path,
    "ANIMAL:RED_DEER": Assets.graphics.anatomy.redDeer.path,
    "ANIMAL:SIKA_DEER": Assets.graphics.anatomy.sikaDeer.path,
    "ANIMAL:RACCOON_DOG": Assets.graphics.anatomy.raccoonDog.path,
    "ANIMAL:AXIS_DEER": Assets.graphics.anatomy.axisDeer.path,
    "ANIMAL:MOUNTAIN_GOAT": Assets.graphics.anatomy.mountainGoat.path,
    "ANIMAL:PRONGHORN": Assets.graphics.anatomy.pronghorn.path,
    "ANIMAL:ROOSEVELT_ELK": Assets.graphics.anatomy.rooseveltElk.path,
    "ANIMAL:PUMA": Assets.graphics.anatomy.puma.path,
    "ANIMAL:PLAINS_BISON": Assets.graphics.anatomy.plainsBison.path,
    "ANIMAL:EURASIAN_LYNX": Assets.graphics.anatomy.eurasianLynx.path,
    "ANIMAL:IBERIAN_MOUFLON": Assets.graphics.anatomy.iberianMouflon.path,
    "ANIMAL:SAMBAR": Assets.graphics.anatomy.sambar.path,
    "ANIMAL:SALTWATER_CROCODILE": Assets.graphics.anatomy.saltwaterCrocodile.path,
    "ANIMAL:GEMSBOK": Assets.graphics.anatomy.gemsbok.path,
    "ANIMAL:SIBERIAN_MUSK_DEER": Assets.graphics.anatomy.siberianMuskDeer.path,
    "ANIMAL:JAVAN_RUSA": Assets.graphics.anatomy.javanRusa.path,
    "ANIMAL:SOUTHEASTERN_SPANISH_IBEX": Assets.graphics.anatomy.southeasternSpanishIbex.path,
    "ANIMAL:RED_FOX": Assets.graphics.anatomy.redFox.path,
    "ANIMAL:EUROPEAN_BISON": Assets.graphics.anatomy.europeanBison.path,
    "ANIMAL:GRIZZLY_BEAR": Assets.graphics.anatomy.grizzlyBear.path,
    "ANIMAL:GRAY_FOX": Assets.graphics.anatomy.grayFox.path,
    "ANIMAL:BLUE_WILDEBEEST": Assets.graphics.anatomy.blueWildebeest.path,
    "ANIMAL:COYOTE": Assets.graphics.anatomy.coyote.path,
    "ANIMAL:AMERICAN_ALLIGATOR": Assets.graphics.anatomy.americanAlligator.path,
    "ANIMAL:WHITETAIL_DEER": Assets.graphics.anatomy.whitetailDeer.path,
    "ANIMAL:COMMON_RACCOON": Assets.graphics.anatomy.commonRaccoon.path,
    "ANIMAL:CHAMOIS": Assets.graphics.anatomy.chamois.path,
    "ANIMAL:CAPE_BUFFALO": Assets.graphics.anatomy.capeBuffalo.path,
    "ANIMAL:RONDA_IBEX": Assets.graphics.anatomy.rondaIbex.path,
    "ANIMAL:BLACK_BEAR": Assets.graphics.anatomy.blackBear.path,
    "ANIMAL:EASTERN_GRAY_KANGAROO": Assets.graphics.anatomy.easternGrayKangaroo.path,
    "ANIMAL:ROE_DEER": Assets.graphics.anatomy.roeDeer.path,
    "ANIMAL:MEXICAN_BOBCAT": Assets.graphics.anatomy.mexicanBobcat.path,
    "ANIMAL:COLLARED_PECCARY": Assets.graphics.anatomy.collaredPeccary.path,
    "ANIMAL:BANTENG": Assets.graphics.anatomy.banteng.path,
    "ANIMAL:HOG_DEER": Assets.graphics.anatomy.hogDeer.path,
    "ANIMAL:REINDEER": Assets.graphics.anatomy.reindeer.path,
    "ANIMAL:WATER_BUFFALO": Assets.graphics.anatomy.waterBuffalo.path,
    "ANIMAL:ROCKY_MOUNTAIN_ELK": Assets.graphics.anatomy.rockyMountainElk.path,
    "ANIMAL:BIGHORN_SHEEP": Assets.graphics.anatomy.bighornSheep.path,
    "ANIMAL:TIBETAN_FOX": Assets.graphics.anatomy.tibetanFox.path,
    "ANIMAL:NORTHERN_RED_MUNTJAC": Assets.graphics.anatomy.northernRedMuntjac.path,
    "ANIMAL:BLUE_SHEEP": Assets.graphics.anatomy.blueSheep.path,
    "ANIMAL:TAHR": Assets.graphics.anatomy.tahr.path,
    "ANIMAL:SNOW_LEOPARD": Assets.graphics.anatomy.snowLeopard.path,
    "ANIMAL:BARASINGHA": Assets.graphics.anatomy.barasingha.path,
    "ANIMAL:NILGAI": Assets.graphics.anatomy.nilgai.path,
    "ANIMAL:WILD_YAK": Assets.graphics.anatomy.wildYak.path,
    "ANIMAL:BENGAL_TIGER": Assets.graphics.anatomy.bengalTiger.path,
  };

  static final Map<String, String> _reserves = {
    "RESERVE:SILVER_RIDGE_PEAKS": Assets.graphics.reserves.silverridgepeaks,
    "RESERVE:NEW_ENGLAND_MOUNTAINS": Assets.graphics.reserves.newenglandmountains,
    "RESERVE:LAYTON_LAKE_DISTRICT": Assets.graphics.reserves.laytonlakedistrict,
    "RESERVE:TE_AWAROA_NATIONAL_PARK": Assets.graphics.reserves.teawaroanationalpark,
    "RESERVE:CUATRO_COLINAS_GAME_RESERVE": Assets.graphics.reserves.cuatrocolinasgamereserve,
    "RESERVE:PARQUE_FERNANDO": Assets.graphics.reserves.parquefernando,
    "RESERVE:RANCHO_DEL_ARROYO": Assets.graphics.reserves.ranchodelarroyo,
    "RESERVE:REVONTULI_COAST": Assets.graphics.reserves.revontulicoast,
    "RESERVE:EMERALD_COAST_AUSTRALIA": Assets.graphics.reserves.emeraldcoastaustralia,
    "RESERVE:VURHONGA_SAVANNA_RESERVE": Assets.graphics.reserves.vurhongasavannareserve,
    "RESERVE:HIRSCHFELDEN_HUNTING_RESERVE": Assets.graphics.reserves.hirschfeldenhuntingreserve,
    "RESERVE:MEDVED_TAIGA_NATIONAL_PARK": Assets.graphics.reserves.medvedtaiganationalpark,
    "RESERVE:YUKON_VALLEY": Assets.graphics.reserves.yukonvalley,
    "RESERVE:MISSISSIPPI_ACRES_PRESERVE": Assets.graphics.reserves.mississippiacrespreserve,
    "RESERVE:SUNDARPATAN_HUNTING_RESERVE": Assets.graphics.reserves.sundarpatanhuntingreserve,
    "RESERVE:SALZWIESEN_PARK": Assets.graphics.reserves.salzwiesenpark,
  };

  static final Map<String, String> _weapons = {
    "WEAPON:HUDZIK_50_CAPLOCK": Assets.graphics.weapons.hudzik50caplock,
    "WEAPON:ZAGAN_VARMINTER_22250": Assets.graphics.weapons.zaganvarminter22250,
    "WEAPON:MORADI_MODEL_1894": Assets.graphics.weapons.moradimodel1894,
    "WEAPON:KOTER_CB65": Assets.graphics.weapons.kotercb65,
    "WEAPON:OLSSON_MODEL_23_308": Assets.graphics.weapons.olssonmodel23308,
    "WEAPON:VIRANT_22LR": Assets.graphics.weapons.virant22lr,
    "WEAPON:4570_JERNBERG_SUPERIOR": Assets.graphics.weapons.a4570jernbergsuperior,
    "WEAPON:COACHMATE_LEVER_4570": Assets.graphics.weapons.coachmatelever4570,
    "WEAPON:RANGEMASTER_338": Assets.graphics.weapons.rangemaster338,
    "WEAPON:HAWK_EDGE_CB70": Assets.graphics.weapons.hawkedgecb70,
    "WEAPON:VASQUEZ_CYCLONE_45": Assets.graphics.weapons.vasquezcyclone45,
    "WEAPON:STENBERG_TAKEDOWN_RECURVE_BOW": Assets.graphics.weapons.stenbergtakedownrecurvebow,
    "WEAPON:STRECKER_SXS_20G": Assets.graphics.weapons.streckersxs20g,
    "WEAPON:RAZORBACK_LITE_CB60": Assets.graphics.weapons.razorbacklitecb60,
    "WEAPON:KING_470DB": Assets.graphics.weapons.king470db,
    "WEAPON:ARZYNA_300_MAG_TACTICAL": Assets.graphics.weapons.arzyna300magtactical,
    "WEAPON:ALEXANDER_LONGBOW": Assets.graphics.weapons.alexanderlongbow,
    "WEAPON:MANGIAFICO_41045_COLT": Assets.graphics.weapons.mangiafico41045colt,
    "WEAPON:MILLER_MODEL_1891": Assets.graphics.weapons.millermodel1891,
    "WEAPON:ZARZA15_22LR": Assets.graphics.weapons.zarza1522lr,
    "WEAPON:BEARCLAW_LITE_CB60": Assets.graphics.weapons.bearclawlitecb60,
    "WEAPON:10MM_DAVANI": Assets.graphics.weapons.a10mmdavani,
    "WEAPON:SOLOKHIN_MN1890": Assets.graphics.weapons.solokhinmn1890,
    "WEAPON:CAVERSHAM_STEWARD_12G": Assets.graphics.weapons.cavershamsteward12g,
    "WEAPON:GRELCK_DRILLING_RIFLE": Assets.graphics.weapons.grelckdrillingrifle,
    "WEAPON:243_RANGER": Assets.graphics.weapons.a243ranger,
    "WEAPON:300_CANNING_MAGNUM": Assets.graphics.weapons.a300canningmagnum,
    "WEAPON:COUSO_MODEL_1897": Assets.graphics.weapons.cousomodel1897,
    "WEAPON:STRANDBERG_10SA_EXECUTIVE": Assets.graphics.weapons.strandberg10saexecutive,
    "WEAPON:ANDERSSON_22LR": Assets.graphics.weapons.andersson22lr,
    "WEAPON:KULLMAN_22H": Assets.graphics.weapons.kullman22h,
    "WEAPON:TSURUGI_LRR_338": Assets.graphics.weapons.tsurugilrr338,
    "WEAPON:MALMER_7MM_MAGNUM": Assets.graphics.weapons.malmer7mmmagnum,
    "WEAPON:CURMAN_50_INLINE": Assets.graphics.weapons.curman50inline,
    "WEAPON:MÅRTENSSON_65MM": Assets.graphics.weapons.mRtensson65mm,
    "WEAPON:FOCOSO_357": Assets.graphics.weapons.focoso357,
    "WEAPON:ZARZA10_308": Assets.graphics.weapons.zarza10308,
    "WEAPON:270_HUNTSMAN": Assets.graphics.weapons.a270huntsman,
    "WEAPON:44_PANTHER_MAGNUM": Assets.graphics.weapons.a44panthermagnum,
    "WEAPON:ZARZA15_223": Assets.graphics.weapons.zarza15223,
    "WEAPON:243_R_CUOMO": Assets.graphics.weapons.a243rcuomo,
    "WEAPON:7MM_REGENT_MAGNUM": Assets.graphics.weapons.a7mmregentmagnum,
    "WEAPON:RHINO_454": Assets.graphics.weapons.rhino454,
    "WEAPON:CROSSPOINT_CB165": Assets.graphics.weapons.crosspointcb165,
    "WEAPON:M1_IWANIEC": Assets.graphics.weapons.m1iwaniec,
    "WEAPON:WHITLOCK_MODEL_86": Assets.graphics.weapons.whitlockmodel86,
    "WEAPON:303_FL_SPORTER": Assets.graphics.weapons.a303flsporter,
    "WEAPON:ECKERS_3006": Assets.graphics.weapons.eckers3006,
    "WEAPON:CACCIATORE_12G": Assets.graphics.weapons.cacciatore12g,
    "WEAPON:NORDIN_20SA": Assets.graphics.weapons.nordin20sa,
    "WEAPON:223_DOCENT": Assets.graphics.weapons.a223docent,
    "WEAPON:45_ROLLESTON": Assets.graphics.weapons.a45rolleston,
    "WEAPON:HOUYI_RECURVE_BOW": Assets.graphics.weapons.houyirecurvebow,
    "WEAPON:GANDHARE_RIFLE": Assets.graphics.weapons.gandharerifle,
    "WEAPON:GOPI_10G_GRAND": Assets.graphics.weapons.gopi10ggrand,
    "WEAPON:FORS_ELITE_300": Assets.graphics.weapons.forselite300,
    "WEAPON:JOHANSSON_450": Assets.graphics.weapons.johansson450,
    "WEAPON:VALLGARDA_375": Assets.graphics.weapons.vallgarda375
  };

  static final Map<String, String> _callers = {
    "CALLER:ANTLER_RATTLER": Assets.graphics.callers.antlerrattler,
    "CALLER:ROE_DEER_CALLER": Assets.graphics.callers.roedeercaller,
    "CALLER:ELK_CALLER": Assets.graphics.callers.elkcaller,
    "CALLER:BUCK_SNORT_WHEEZE_CALLER": Assets.graphics.callers.bucksnortwheezecaller,
    "CALLER:BEACON_DELUXE_BEAN_GOOSE_CALLER": Assets.graphics.callers.beacondeluxebeangoosecaller,
    "CALLER:BEACON_DELUXE_EURASIAN_WIGEON_CALLER": Assets.graphics.callers.beacondeluxeeurasianwigeoncaller,
    "CALLER:WILD_TURKEY_CROW_CALLER": Assets.graphics.callers.wildturkeycrowcaller,
    "CALLER:MOOSE_CALLER": Assets.graphics.callers.moosecaller,
    "CALLER:SAMBAR_MOUTH_CALLER": Assets.graphics.callers.sambarmouthcaller,
    "CALLER:RACCOON_SQUALL_CALLER": Assets.graphics.callers.raccoonsquallcaller,
    "CALLER:HAZEL_GROUSE_CALLER": Assets.graphics.callers.hazelgrousecaller,
    "CALLER:AXIS_DEER_SCREAMER_CALLER": Assets.graphics.callers.axisdeerscreamercaller,
    "CALLER:BEACON_DELUXE_DUCK_CALLER": Assets.graphics.callers.beacondeluxeduckcaller,
    "CALLER:BEACON_DELUXE_EURASIAN_TEAL_CALLER": Assets.graphics.callers.beacondeluxeeurasiantealcaller,
    "CALLER:DEER_GRUNT_CALLER": Assets.graphics.callers.deergruntcaller,
    "CALLER:RED_DEER_CALLER": Assets.graphics.callers.reddeercaller,
    "CALLER:MAGPIE_GOOSE_CALLER": Assets.graphics.callers.magpiegoosecaller,
    "CALLER:WILD_BOAR_CALLER": Assets.graphics.callers.wildboarcaller,
    "CALLER:DEER_BLEAT_CALLER": Assets.graphics.callers.deerbleatcaller,
    "CALLER:BEACON_DELUXE_GREYLAG_GOOSE_CALLER": Assets.graphics.callers.beacondeluxegreylaggoosecaller,
    "CALLER:PREDATOR_JACKRABBIT_CALLER": Assets.graphics.callers.predatorjackrabbitcaller,
    "CALLER:SHORT_REED_CANADA_GOOSE_CALLER": Assets.graphics.callers.shortreedcanadagoosecaller,
    "CALLER:PREDATOR_DISTRESSED_FAWN_CALLER": Assets.graphics.callers.predatordistressedfawncaller,
    "CALLER:WILD_TURKEY_MOUTH_CALLER": Assets.graphics.callers.wildturkeymouthcaller,
    "CALLER:GADWALL_CALLER": Assets.graphics.callers.gadwallcaller,
  };

  static final Map<String, String> _proficiency = {
    "PERK:SURVIVAL_INSTINCT": Assets.graphics.proficiency.survivalinstinct,
    "PERK:PUMPING_IRON": Assets.graphics.proficiency.pumpingiron,
    "PERK:WINDAGE": Assets.graphics.proficiency.windage,
    "PERK:SPRINT_AND_LOAD": Assets.graphics.proficiency.sprintandload,
    "PERK:RECOIL_MANAGEMENT": Assets.graphics.proficiency.recoilmanagement,
    "PERK:QUICK_FEET": Assets.graphics.proficiency.quickfeet,
    "PERK:FOCUSED_SHOT": Assets.graphics.proficiency.focusedshot,
    "PERK:STEADY_HANDS": Assets.graphics.proficiency.steadyhands,
    "PERK:LIGHTNING_HANDS": Assets.graphics.proficiency.lightninghands,
    "PERK:RECYCLE": Assets.graphics.proficiency.recycle,
    "PERK:BREATH_CONTROL": Assets.graphics.proficiency.breathcontrol,
    "PERK:MOVE_N_SHOOT": Assets.graphics.proficiency.movenshoot,
    "PERK:TRACERSHOT": Assets.graphics.proficiency.tracershot,
    "PERK:FULL_DRAW": Assets.graphics.proficiency.fulldraw,
    "PERK:LIKE_A_PRO": Assets.graphics.proficiency.likeapro,
    "PERK:BOTH_EYES_OPEN": Assets.graphics.proficiency.botheyesopen,
    "PERK:FAST_SHOULDERING": Assets.graphics.proficiency.fastshouldering,
    "PERK:QUICK_DRAW": Assets.graphics.proficiency.quickdraw,
    "PERK:BODY_CONTROL": Assets.graphics.proficiency.bodycontrol,
    "PERK:ZEROING": Assets.graphics.proficiency.zeroing,
    "PERK:BOOMSTICK": Assets.graphics.proficiency.boomstick,
    "PERK:MUSCLE_MEMORY": Assets.graphics.proficiency.musclememory,
    "PERK:INCREASED_CONFIDENCE": Assets.graphics.proficiency.increasedconfidence,
    "PERK:RANGER": Assets.graphics.proficiency.ranger,
    "PERK:FATAL_ATTRACTION": Assets.graphics.proficiency.fatalattraction,
    "PERK:DISTURBED_VEGETATION": Assets.graphics.proficiency.disturbedvegetation,
    "PERK:CONNECT_THE_DOTS": Assets.graphics.proficiency.connectthedots,
    "PERK:KEEN_EYE": Assets.graphics.proficiency.keeneye,
    "PERK:IM_ONLY_HAPPY_WHEN_IT_RAINS": Assets.graphics.proficiency.imonlyhappywhenitrains,
    "PERK:WIND_PREDICTION": Assets.graphics.proficiency.windprediction,
    "PERK:SIGHT_SPOTTING": Assets.graphics.proficiency.sightspotting,
    "PERK:LOCATE_TRACKS": Assets.graphics.proficiency.locatetracks,
    "SKILL:WHOS_DEER": Assets.graphics.proficiency.whosdeer,
    "PERK:HARDENED": Assets.graphics.proficiency.hardened,
    "PERK:TRACK_KNOWLEDGE": Assets.graphics.proficiency.trackknowledge,
    "PERK:IMPACT_RESISTANT": Assets.graphics.proficiency.impactresistant,
    "PERK:ENDURANCE": Assets.graphics.proficiency.endurance,
    "PERK:INNATE_TRIANGULATION": Assets.graphics.proficiency.innatetriangulation,
    "PERK:SOFT_FEET": Assets.graphics.proficiency.softfeet,
    "PERK:PACK_MULE": Assets.graphics.proficiency.packmule,
    "PERK:SCENT_TINKERER": Assets.graphics.proficiency.scenttinkerer,
    "PERK:HILL_CALLER": Assets.graphics.proficiency.hillcaller,
    "PERK:WEATHER_PREDICTION": Assets.graphics.proficiency.weatherprediction,
    "PERK:STARTLE_CALL": Assets.graphics.proficiency.startlecall,
    "PERK:DAZED_AND_CONFUSED": Assets.graphics.proficiency.dazedandconfused,
    "PERK:TAG": Assets.graphics.proficiency.tag,
    "PERK:IMPROVISED_BLIND": Assets.graphics.proficiency.improvisedblind,
    "PERK:THE_MORE_THE_MERRIER": Assets.graphics.proficiency.themorethemerrier,
    "PERK:SPOTTING_KNOWLEDGE": Assets.graphics.proficiency.spottingknowledge,
    "PERK:HAGGLE": Assets.graphics.proficiency.haggle,
  };

  static final _svgPlaceholder = Assets.graphics.icons.placeholder;
  static final _pngPlaceholder = Assets.graphics.images.placeholder.path;

  static String getAnimalIcon(Animal animal) => _animals[animal.asset] ?? _svgPlaceholder;

  static String getAnimalHead(Animal animal) => _heads[animal.asset] ?? _pngPlaceholder;

  static String getAnimalAnatomy(Animal animal) => _anatomy[animal.asset] ?? _svgPlaceholder;

  static String getSenseIcon(SenseType sense) {
    switch (sense) {
      case SenseType.sight:
        return Assets.graphics.icons.senseSight;
      case SenseType.smell:
        return Assets.graphics.icons.senseSmell;
      case SenseType.hearing:
        return Assets.graphics.icons.senseHearing;
    }
  }

  static String getReserveIcon(Reserve reserve) => _reserves[reserve.asset] ?? _svgPlaceholder;

  static String getWeaponIcon(Weapon weapon) => _weapons[weapon.asset] ?? _svgPlaceholder;

  static String getCallerIcon(Caller caller) => _callers[caller.asset] ?? _svgPlaceholder;

  static String getProficiencyIcon(Proficiency proficiency) => _proficiency[proficiency.asset] ?? _svgPlaceholder;

  static String getTile(Reserve reserve, int x, int y, int z) {
    int gridSize, correction;

    switch (z) {
      case 1:
        gridSize = 4;
        correction = 1;
        break;
      case 2:
        gridSize = 8;
        correction = 2;
        break;
      case 3:
        gridSize = 16;
        correction = 4;
        break;
      default:
        throw Exception("Zoom level: $z is not supported");
    }

    int i = (y + correction) * gridSize + (x + correction);
    return "assets/graphics/maps/${reserve.asset.replaceAll(RegExp(r'\S+:'), "").replaceAll("_", "").toLowerCase()}/$z/$i.png";
  }

  static String getMapObjectIcon(MapLocationType type) {
    switch (type) {
      case MapLocationType.outpost:
        return Assets.graphics.icons.outpost;
      case MapLocationType.lookout:
        return Assets.graphics.icons.lookout;
      case MapLocationType.hide:
        return Assets.graphics.icons.hide;
      case MapLocationType.zone:
        return _svgPlaceholder;
    }
  }

  static String getObjectiveIcon(String objective) {
    if (objective.startsWith("[I]")) return Assets.graphics.icons.info;
    if (objective.startsWith("[O]")) return Assets.graphics.icons.optional;
    return Assets.graphics.icons.todo;
  }

  static String getLogViewIcon(int compactLogbook) {
    switch (compactLogbook) {
      case (3):
        return Assets.graphics.icons.viewSemiCompact;
      case (2):
        return Assets.graphics.icons.viewCompact;
      case (1):
        return Assets.graphics.icons.viewExpanded;
      default:
        return _svgPlaceholder;
    }
  }

  static String getProcessIcon(Process process) {
    switch (process) {
      case Process.success:
        return Assets.graphics.icons.todo;
      case Process.error:
        return Assets.graphics.icons.error;
      case Process.info:
        return Assets.graphics.icons.info;
    }
  }
}
