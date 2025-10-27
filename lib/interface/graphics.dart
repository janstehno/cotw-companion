import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/proficiency.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';

class Graphics {
  static final Map<String, String> _animals = {
    "ANIMAL:AMERICAN_ALLIGATOR": Assets.graphics.animals.americanalligator,
    "ANIMAL:ANTELOPE_JACKRABBIT": Assets.graphics.animals.antelopejackrabbit,
    "ANIMAL:AXIS_DEER": Assets.graphics.animals.axisdeer,
    "ANIMAL:BANTENG": Assets.graphics.animals.banteng,
    "ANIMAL:BARASINGHA": Assets.graphics.animals.barasingha,
    "ANIMAL:BECEITE_IBEX": Assets.graphics.animals.beceiteibex,
    "ANIMAL:BENGAL_TIGER": Assets.graphics.animals.bengaltiger,
    "ANIMAL:BIGHORN_SHEEP": Assets.graphics.animals.bighornsheep,
    "ANIMAL:BLACKBUCK": Assets.graphics.animals.blackbuck,
    "ANIMAL:BLACKTAIL_DEER": Assets.graphics.animals.blacktaildeer,
    "ANIMAL:BLACK_BEAR": Assets.graphics.animals.blackbear,
    "ANIMAL:BLACK_GROUSE": Assets.graphics.animals.blackgrouse,
    "ANIMAL:BLUE_SHEEP": Assets.graphics.animals.bluesheep,
    "ANIMAL:BLUE_WILDEBEEST": Assets.graphics.animals.bluewildebeest,
    "ANIMAL:BOBWHITE_QUAIL": Assets.graphics.animals.bobwhitequail,
    "ANIMAL:BROWN_BEAR": Assets.graphics.animals.brownbear,
    "ANIMAL:CANADA_GOOSE": Assets.graphics.animals.canadagoose,
    "ANIMAL:CAPE_BUFFALO": Assets.graphics.animals.capebuffalo,
    "ANIMAL:CARIBOU": Assets.graphics.animals.caribou,
    "ANIMAL:CHAMOIS": Assets.graphics.animals.chamois,
    "ANIMAL:CINNAMON_TEAL": Assets.graphics.animals.cinnamonteal,
    "ANIMAL:COLLARED_PECCARY": Assets.graphics.animals.collaredpeccary,
    "ANIMAL:COMMON_RACCOON": Assets.graphics.animals.commonraccoon,
    "ANIMAL:COYOTE": Assets.graphics.animals.coyote,
    "ANIMAL:DESERT_BIGHORN_SHEEP": Assets.graphics.animals.bighornsheep,
    "ANIMAL:DUSKY_GROUSE": Assets.graphics.animals.duskygrouse,
    "ANIMAL:EASTERN_COTTONTAIL_RABBIT": Assets.graphics.animals.easterncottontailrabbit,
    "ANIMAL:EASTERN_GRAY_KANGAROO": Assets.graphics.animals.easterngraykangaroo,
    "ANIMAL:EASTERN_WILD_TURKEY": Assets.graphics.animals.turkey,
    "ANIMAL:EURASIAN_LYNX": Assets.graphics.animals.eurasianlynx,
    "ANIMAL:EURASIAN_TEAL": Assets.graphics.animals.eurasianteal,
    "ANIMAL:EURASIAN_WIGEON": Assets.graphics.animals.eurasianwigeon,
    "ANIMAL:EUROPEAN_BISON": Assets.graphics.animals.europeanbison,
    "ANIMAL:EUROPEAN_HARE": Assets.graphics.animals.europeanhare,
    "ANIMAL:EUROPEAN_RABBIT": Assets.graphics.animals.europeanrabbit,
    "ANIMAL:FALLOW_DEER": Assets.graphics.animals.fallowdeer,
    "ANIMAL:FERAL_GOAT": Assets.graphics.animals.feralgoat,
    "ANIMAL:FERAL_PIG": Assets.graphics.animals.feralpig,
    "ANIMAL:FERRUGINOUS_DUCK": Assets.graphics.animals.ferruginousduck,
    "ANIMAL:GADWALL": Assets.graphics.animals.gadwall,
    "ANIMAL:GEMSBOK": Assets.graphics.animals.gemsbok,
    "ANIMAL:GOLDENEYE": Assets.graphics.animals.goldeneye,
    "ANIMAL:GRAY_FOX": Assets.graphics.animals.grayfox,
    "ANIMAL:GRAY_WOLF": Assets.graphics.animals.graywolf,
    "ANIMAL:GREDOS_IBEX": Assets.graphics.animals.gredosibex,
    "ANIMAL:GREENWINGED_TEAL": Assets.graphics.animals.eurasianteal,
    "ANIMAL:GREYLAG_GOOSE": Assets.graphics.animals.greylaggoose,
    "ANIMAL:GRIZZLY_BEAR": Assets.graphics.animals.grizzlybear,
    "ANIMAL:HARLEQUIN_DUCK": Assets.graphics.animals.harlequinduck,
    "ANIMAL:HAZEL_GROUSE": Assets.graphics.animals.hazelgrouse,
    "ANIMAL:HOG_DEER": Assets.graphics.animals.hogdeer,
    "ANIMAL:IBERIAN_MOUFLON": Assets.graphics.animals.iberianmouflon,
    "ANIMAL:IBERIAN_WOLF": Assets.graphics.animals.iberianwolf,
    "ANIMAL:JAVAN_RUSA": Assets.graphics.animals.javanrusa,
    "ANIMAL:LESSER_KUDU": Assets.graphics.animals.lesserkudu,
    "ANIMAL:LION": Assets.graphics.animals.lion,
    "ANIMAL:MAGPIE_GOOSE": Assets.graphics.animals.magpiegoose,
    "ANIMAL:MALLARD": Assets.graphics.animals.mallard,
    "ANIMAL:MANITOBAN_ELK": Assets.graphics.animals.elk,
    "ANIMAL:MERRIAM_TURKEY": Assets.graphics.animals.turkey,
    "ANIMAL:MEXICAN_BOBCAT": Assets.graphics.animals.mexicanbobcat,
    "ANIMAL:MOOSE": Assets.graphics.animals.moose,
    "ANIMAL:MOUNTAIN_GOAT": Assets.graphics.animals.mountaingoat,
    "ANIMAL:MOUNTAIN_HARE": Assets.graphics.animals.mountainhare,
    "ANIMAL:MULE_DEER": Assets.graphics.animals.muledeer,
    "ANIMAL:NILGAI": Assets.graphics.animals.nilgai,
    "ANIMAL:NORTHERN_PINTAIL": Assets.graphics.animals.northernpintail,
    "ANIMAL:NORTHERN_RED_MUNTJAC": Assets.graphics.animals.northernredmuntjac,
    "ANIMAL:NORTH_AMERICAN_BEAVER": Assets.graphics.animals.northamericanbeaver,
    "ANIMAL:PLAINS_BISON": Assets.graphics.animals.plainsbison,
    "ANIMAL:PRONGHORN": Assets.graphics.animals.pronghorn,
    "ANIMAL:PUMA": Assets.graphics.animals.puma,
    "ANIMAL:RACCOON_DOG": Assets.graphics.animals.raccoondog,
    "ANIMAL:RED_DEER": Assets.graphics.animals.reddeer,
    "ANIMAL:RED_FOX": Assets.graphics.animals.redfox,
    "ANIMAL:REINDEER": Assets.graphics.animals.reindeer,
    "ANIMAL:RINGNECKED_PHEASANT": Assets.graphics.animals.ringneckedpheasant,
    "ANIMAL:RIO_GRANDE_TURKEY": Assets.graphics.animals.turkey,
    "ANIMAL:ROCKY_MOUNTAIN_ELK": Assets.graphics.animals.elk,
    "ANIMAL:ROCK_PTARMIGAN": Assets.graphics.animals.rockptarmigan,
    "ANIMAL:ROE_DEER": Assets.graphics.animals.roedeer,
    "ANIMAL:RONDA_IBEX": Assets.graphics.animals.rondaibex,
    "ANIMAL:ROOSEVELT_ELK": Assets.graphics.animals.elk,
    "ANIMAL:SALTWATER_CROCODILE": Assets.graphics.animals.saltwatercrocodile,
    "ANIMAL:SAMBAR": Assets.graphics.animals.sambar,
    "ANIMAL:SCRUB_HARE": Assets.graphics.animals.scrubhare,
    "ANIMAL:SIBERIAN_MUSK_DEER": Assets.graphics.animals.siberianmuskdeer,
    "ANIMAL:SIDE_STRIPED_JACKAL": Assets.graphics.animals.sidestripedjackal,
    "ANIMAL:SIKA_DEER": Assets.graphics.animals.sikadeer,
    "ANIMAL:SNOW_GOOSE": Assets.graphics.animals.snowgoose,
    "ANIMAL:SNOW_LEOPARD": Assets.graphics.animals.snowleopard,
    "ANIMAL:SOUTHEASTERN_SPANISH_IBEX": Assets.graphics.animals.southeasternspanishibex,
    "ANIMAL:SPRINGBOK": Assets.graphics.animals.springbok,
    "ANIMAL:STUBBLE_QUAIL": Assets.graphics.animals.stubblequail,
    "ANIMAL:TAHR": Assets.graphics.animals.tahr,
    "ANIMAL:TIBETAN_FOX": Assets.graphics.animals.tibetanfox,
    "ANIMAL:TUFTED_DUCK": Assets.graphics.animals.tuftedduck,
    "ANIMAL:TUNDRA_BEAN_GOOSE": Assets.graphics.animals.tundrabeangoose,
    "ANIMAL:WARTHOG": Assets.graphics.animals.warthog,
    "ANIMAL:WATER_BUFFALO": Assets.graphics.animals.waterbuffalo,
    "ANIMAL:WESTERN_CAPERCAILLIE": Assets.graphics.animals.westerncapercaillie,
    "ANIMAL:WHITETAIL_DEER": Assets.graphics.animals.whitetaildeer,
    "ANIMAL:WHITE_TAILED_JACKRABBIT": Assets.graphics.animals.whitetailedjackrabbit,
    "ANIMAL:WILD_BOAR": Assets.graphics.animals.wildboar,
    "ANIMAL:WILD_YAK": Assets.graphics.animals.wildyak,
    "ANIMAL:WILLOW_PTARMIGAN": Assets.graphics.animals.willowptarmigan,
    "ANIMAL:WOODLAND_CARIBOU": Assets.graphics.animals.caribou,
    "ANIMAL:WOOD_BISON": Assets.graphics.animals.woodbison,
    "ANIMAL:WOOD_DUCK": Assets.graphics.animals.woodduck,
    "ANIMAL:WOOLLY_HARE": Assets.graphics.animals.woollyhare,
  };

  static final Map<String, String> _heads = {
    "ANIMAL:AMERICAN_ALLIGATOR": Assets.graphics.heads.americanalligator.path,
    "ANIMAL:ANTELOPE_JACKRABBIT": Assets.graphics.heads.antelopejackrabbit.path,
    "ANIMAL:AXIS_DEER": Assets.graphics.heads.axisdeer.path,
    "ANIMAL:BANTENG": Assets.graphics.heads.banteng.path,
    "ANIMAL:BARASINGHA": Assets.graphics.heads.barasingha.path,
    "ANIMAL:BECEITE_IBEX": Assets.graphics.heads.beceiteibex.path,
    "ANIMAL:BENGAL_TIGER": Assets.graphics.heads.bengaltiger.path,
    "ANIMAL:BIGHORN_SHEEP": Assets.graphics.heads.bighornsheep.path,
    "ANIMAL:BLACKBUCK": Assets.graphics.heads.blackbuck.path,
    "ANIMAL:BLACKTAIL_DEER": Assets.graphics.heads.blacktaildeer.path,
    "ANIMAL:BLACK_BEAR": Assets.graphics.heads.blackbear.path,
    "ANIMAL:BLACK_GROUSE": Assets.graphics.heads.blackgrouse.path,
    "ANIMAL:BLUE_SHEEP": Assets.graphics.heads.bluesheep.path,
    "ANIMAL:BLUE_WILDEBEEST": Assets.graphics.heads.bluewildebeest.path,
    "ANIMAL:BOBWHITE_QUAIL": Assets.graphics.heads.bobwhitequail.path,
    "ANIMAL:BROWN_BEAR": Assets.graphics.heads.brownbear.path,
    "ANIMAL:CANADA_GOOSE": Assets.graphics.heads.canadagoose.path,
    "ANIMAL:CAPE_BUFFALO": Assets.graphics.heads.capebuffalo.path,
    "ANIMAL:CARIBOU": Assets.graphics.heads.caribou.path,
    "ANIMAL:CHAMOIS": Assets.graphics.heads.chamois.path,
    "ANIMAL:CINNAMON_TEAL": Assets.graphics.heads.cinnamonteal.path,
    "ANIMAL:COLLARED_PECCARY": Assets.graphics.heads.collaredpeccary.path,
    "ANIMAL:COMMON_RACCOON": Assets.graphics.heads.commonraccoon.path,
    "ANIMAL:COYOTE": Assets.graphics.heads.coyote.path,
    "ANIMAL:DESERT_BIGHORN_SHEEP": Assets.graphics.heads.desertbighornsheep.path,
    "ANIMAL:DUSKY_GROUSE": Assets.graphics.heads.duskygrouse.path,
    "ANIMAL:EASTERN_COTTONTAIL_RABBIT": Assets.graphics.heads.easterncottontailrabbit.path,
    "ANIMAL:EASTERN_GRAY_KANGAROO": Assets.graphics.heads.easterngraykangaroo.path,
    "ANIMAL:EASTERN_WILD_TURKEY": Assets.graphics.heads.turkey.path,
    "ANIMAL:EURASIAN_LYNX": Assets.graphics.heads.eurasianlynx.path,
    "ANIMAL:EURASIAN_TEAL": Assets.graphics.heads.eurasianteal.path,
    "ANIMAL:EURASIAN_WIGEON": Assets.graphics.heads.eurasianwigeon.path,
    "ANIMAL:EUROPEAN_BISON": Assets.graphics.heads.europeanbison.path,
    "ANIMAL:EUROPEAN_HARE": Assets.graphics.heads.europeanhare.path,
    "ANIMAL:EUROPEAN_RABBIT": Assets.graphics.heads.europeanrabbit.path,
    "ANIMAL:FALLOW_DEER": Assets.graphics.heads.fallowdeer.path,
    "ANIMAL:FERAL_GOAT": Assets.graphics.heads.feralgoat.path,
    "ANIMAL:FERAL_PIG": Assets.graphics.heads.feralpig.path,
    "ANIMAL:FERRUGINOUS_DUCK": Assets.graphics.heads.ferruginousduck.path,
    "ANIMAL:GADWALL": Assets.graphics.heads.gadwall.path,
    "ANIMAL:GEMSBOK": Assets.graphics.heads.gemsbok.path,
    "ANIMAL:GOLDENEYE": Assets.graphics.heads.goldeneye.path,
    "ANIMAL:GRAY_FOX": Assets.graphics.heads.grayfox.path,
    "ANIMAL:GRAY_WOLF": Assets.graphics.heads.graywolf.path,
    "ANIMAL:GREDOS_IBEX": Assets.graphics.heads.gredosibex.path,
    "ANIMAL:GREENWINGED_TEAL": Assets.graphics.heads.eurasianteal.path,
    "ANIMAL:GREYLAG_GOOSE": Assets.graphics.heads.greylaggoose.path,
    "ANIMAL:GRIZZLY_BEAR": Assets.graphics.heads.grizzlybear.path,
    "ANIMAL:HARLEQUIN_DUCK": Assets.graphics.heads.harlequinduck.path,
    "ANIMAL:HAZEL_GROUSE": Assets.graphics.heads.hazelgrouse.path,
    "ANIMAL:HOG_DEER": Assets.graphics.heads.hogdeer.path,
    "ANIMAL:IBERIAN_MOUFLON": Assets.graphics.heads.iberianmouflon.path,
    "ANIMAL:IBERIAN_WOLF": Assets.graphics.heads.iberianwolf.path,
    "ANIMAL:JAVAN_RUSA": Assets.graphics.heads.javanrusa.path,
    "ANIMAL:LESSER_KUDU": Assets.graphics.heads.lesserkudu.path,
    "ANIMAL:LION": Assets.graphics.heads.lion.path,
    "ANIMAL:MAGPIE_GOOSE": Assets.graphics.heads.magpiegoose.path,
    "ANIMAL:MALLARD": Assets.graphics.heads.mallard.path,
    "ANIMAL:MANITOBAN_ELK": Assets.graphics.heads.manitobanelk.path,
    "ANIMAL:MERRIAM_TURKEY": Assets.graphics.heads.turkey.path,
    "ANIMAL:MEXICAN_BOBCAT": Assets.graphics.heads.mexicanbobcat.path,
    "ANIMAL:MOOSE": Assets.graphics.heads.moose.path,
    "ANIMAL:MOUNTAIN_GOAT": Assets.graphics.heads.mountaingoat.path,
    "ANIMAL:MOUNTAIN_HARE": Assets.graphics.heads.mountainhare.path,
    "ANIMAL:MULE_DEER": Assets.graphics.heads.muledeer.path,
    "ANIMAL:NILGAI": Assets.graphics.heads.nilgai.path,
    "ANIMAL:NORTHERN_PINTAIL": Assets.graphics.heads.northernpintail.path,
    "ANIMAL:NORTHERN_RED_MUNTJAC": Assets.graphics.heads.northernredmuntjac.path,
    "ANIMAL:NORTH_AMERICAN_BEAVER": Assets.graphics.heads.northamericanbeaver.path,
    "ANIMAL:PLAINS_BISON": Assets.graphics.heads.plainsbison.path,
    "ANIMAL:PRONGHORN": Assets.graphics.heads.pronghorn.path,
    "ANIMAL:PUMA": Assets.graphics.heads.puma.path,
    "ANIMAL:RACCOON_DOG": Assets.graphics.heads.raccoondog.path,
    "ANIMAL:RED_DEER": Assets.graphics.heads.reddeer.path,
    "ANIMAL:RED_FOX": Assets.graphics.heads.redfox.path,
    "ANIMAL:REINDEER": Assets.graphics.heads.reindeer.path,
    "ANIMAL:RINGNECKED_PHEASANT": Assets.graphics.heads.ringneckedpheasant.path,
    "ANIMAL:RIO_GRANDE_TURKEY": Assets.graphics.heads.turkey.path,
    "ANIMAL:ROCKY_MOUNTAIN_ELK": Assets.graphics.heads.rockymountainelk.path,
    "ANIMAL:ROCK_PTARMIGAN": Assets.graphics.heads.rockptarmigan.path,
    "ANIMAL:ROE_DEER": Assets.graphics.heads.roedeer.path,
    "ANIMAL:RONDA_IBEX": Assets.graphics.heads.rondaibex.path,
    "ANIMAL:ROOSEVELT_ELK": Assets.graphics.heads.rooseveltelk.path,
    "ANIMAL:SALTWATER_CROCODILE": Assets.graphics.heads.saltwatercrocodile.path,
    "ANIMAL:SAMBAR": Assets.graphics.heads.sambar.path,
    "ANIMAL:SCRUB_HARE": Assets.graphics.heads.scrubhare.path,
    "ANIMAL:SIBERIAN_MUSK_DEER": Assets.graphics.heads.siberianmuskdeer.path,
    "ANIMAL:SIDE_STRIPED_JACKAL": Assets.graphics.heads.sidestripedjackal.path,
    "ANIMAL:SIKA_DEER": Assets.graphics.heads.sikadeer.path,
    "ANIMAL:SNOW_GOOSE": Assets.graphics.heads.snowgoose.path,
    "ANIMAL:SNOW_LEOPARD": Assets.graphics.heads.snowleopard.path,
    "ANIMAL:SOUTHEASTERN_SPANISH_IBEX": Assets.graphics.heads.southeasternspanishibex.path,
    "ANIMAL:SPRINGBOK": Assets.graphics.heads.springbok.path,
    "ANIMAL:STUBBLE_QUAIL": Assets.graphics.heads.stubblequail.path,
    "ANIMAL:TAHR": Assets.graphics.heads.tahr.path,
    "ANIMAL:TIBETAN_FOX": Assets.graphics.heads.tibetanfox.path,
    "ANIMAL:TUFTED_DUCK": Assets.graphics.heads.tuftedduck.path,
    "ANIMAL:TUNDRA_BEAN_GOOSE": Assets.graphics.heads.tundrabeangoose.path,
    "ANIMAL:WARTHOG": Assets.graphics.heads.warthog.path,
    "ANIMAL:WATER_BUFFALO": Assets.graphics.heads.waterbuffalo.path,
    "ANIMAL:WESTERN_CAPERCAILLIE": Assets.graphics.heads.westerncapercaillie.path,
    "ANIMAL:WHITETAIL_DEER": Assets.graphics.heads.whitetaildeer.path,
    "ANIMAL:WHITE_TAILED_JACKRABBIT": Assets.graphics.heads.whitetailedjackrabbit.path,
    "ANIMAL:WILD_BOAR": Assets.graphics.heads.wildboar.path,
    "ANIMAL:WILD_YAK": Assets.graphics.heads.wildyak.path,
    "ANIMAL:WILLOW_PTARMIGAN": Assets.graphics.heads.willowptarmigan.path,
    "ANIMAL:WOODLAND_CARIBOU": Assets.graphics.heads.caribou.path,
    "ANIMAL:WOOD_BISON": Assets.graphics.heads.woodbison.path,
    "ANIMAL:WOOD_DUCK": Assets.graphics.heads.woodduck.path,
    "ANIMAL:WOOLLY_HARE": Assets.graphics.heads.woollyhare.path,
  };

  static final Map<String, String> _anatomy = {
    "ANIMAL:AMERICAN_ALLIGATOR": Assets.graphics.anatomy.americanAlligator.path,
    "ANIMAL:AXIS_DEER": Assets.graphics.anatomy.axisDeer.path,
    "ANIMAL:BANTENG": Assets.graphics.anatomy.banteng.path,
    "ANIMAL:BARASINGHA": Assets.graphics.anatomy.barasingha.path,
    "ANIMAL:BECEITE_IBEX": Assets.graphics.anatomy.beceiteIbex.path,
    "ANIMAL:BENGAL_TIGER": Assets.graphics.anatomy.bengalTiger.path,
    "ANIMAL:BIGHORN_SHEEP": Assets.graphics.anatomy.bighornSheep.path,
    "ANIMAL:BLACKBUCK": Assets.graphics.anatomy.blackbuck.path,
    "ANIMAL:BLACKTAIL_DEER": Assets.graphics.anatomy.blacktailDeer.path,
    "ANIMAL:BLACK_BEAR": Assets.graphics.anatomy.blackBear.path,
    "ANIMAL:BLUE_SHEEP": Assets.graphics.anatomy.blueSheep.path,
    "ANIMAL:BLUE_WILDEBEEST": Assets.graphics.anatomy.blueWildebeest.path,
    "ANIMAL:BROWN_BEAR": Assets.graphics.anatomy.brownBear.path,
    "ANIMAL:CAPE_BUFFALO": Assets.graphics.anatomy.capeBuffalo.path,
    "ANIMAL:CARIBOU": Assets.graphics.anatomy.caribou.path,
    "ANIMAL:CHAMOIS": Assets.graphics.anatomy.chamois.path,
    "ANIMAL:COLLARED_PECCARY": Assets.graphics.anatomy.collaredPeccary.path,
    "ANIMAL:COMMON_RACCOON": Assets.graphics.anatomy.commonRaccoon.path,
    "ANIMAL:COYOTE": Assets.graphics.anatomy.coyote.path,
    "ANIMAL:DESERT_BIGHORN_SHEEP": Assets.graphics.anatomy.desertBighornSheep.path,
    "ANIMAL:EASTERN_GRAY_KANGAROO": Assets.graphics.anatomy.easternGrayKangaroo.path,
    "ANIMAL:EURASIAN_LYNX": Assets.graphics.anatomy.eurasianLynx.path,
    "ANIMAL:EUROPEAN_BISON": Assets.graphics.anatomy.europeanBison.path,
    "ANIMAL:FALLOW_DEER": Assets.graphics.anatomy.fallowDeer.path,
    "ANIMAL:FERAL_GOAT": Assets.graphics.anatomy.feralGoat.path,
    "ANIMAL:FERAL_PIG": Assets.graphics.anatomy.feralPig.path,
    "ANIMAL:GEMSBOK": Assets.graphics.anatomy.gemsbok.path,
    "ANIMAL:GRAY_FOX": Assets.graphics.anatomy.grayFox.path,
    "ANIMAL:GRAY_WOLF": Assets.graphics.anatomy.grayWolf.path,
    "ANIMAL:GREDOS_IBEX": Assets.graphics.anatomy.gredosIbex.path,
    "ANIMAL:GRIZZLY_BEAR": Assets.graphics.anatomy.grizzlyBear.path,
    "ANIMAL:HOG_DEER": Assets.graphics.anatomy.hogDeer.path,
    "ANIMAL:IBERIAN_MOUFLON": Assets.graphics.anatomy.iberianMouflon.path,
    "ANIMAL:IBERIAN_WOLF": Assets.graphics.anatomy.iberianWolf.path,
    "ANIMAL:JAVAN_RUSA": Assets.graphics.anatomy.javanRusa.path,
    "ANIMAL:LESSER_KUDU": Assets.graphics.anatomy.lesserKudu.path,
    "ANIMAL:LION": Assets.graphics.anatomy.lion.path,
    "ANIMAL:MANITOBAN_ELK": Assets.graphics.anatomy.manitobanElk.path,
    "ANIMAL:MEXICAN_BOBCAT": Assets.graphics.anatomy.mexicanBobcat.path,
    "ANIMAL:MOOSE": Assets.graphics.anatomy.moose.path,
    "ANIMAL:MOUNTAIN_GOAT": Assets.graphics.anatomy.mountainGoat.path,
    "ANIMAL:MULE_DEER": Assets.graphics.anatomy.muleDeer.path,
    "ANIMAL:NILGAI": Assets.graphics.anatomy.nilgai.path,
    "ANIMAL:NORTHERN_RED_MUNTJAC": Assets.graphics.anatomy.northernRedMuntjac.path,
    "ANIMAL:NORTH_AMERICAN_BEAVER": Assets.graphics.anatomy.northAmericanBeaver.path,
    "ANIMAL:PLAINS_BISON": Assets.graphics.anatomy.plainsBison.path,
    "ANIMAL:PRONGHORN": Assets.graphics.anatomy.pronghorn.path,
    "ANIMAL:PUMA": Assets.graphics.anatomy.puma.path,
    "ANIMAL:RACCOON_DOG": Assets.graphics.anatomy.raccoonDog.path,
    "ANIMAL:RED_DEER": Assets.graphics.anatomy.redDeer.path,
    "ANIMAL:RED_FOX": Assets.graphics.anatomy.redFox.path,
    "ANIMAL:REINDEER": Assets.graphics.anatomy.reindeer.path,
    "ANIMAL:ROCKY_MOUNTAIN_ELK": Assets.graphics.anatomy.rockyMountainElk.path,
    "ANIMAL:ROE_DEER": Assets.graphics.anatomy.roeDeer.path,
    "ANIMAL:RONDA_IBEX": Assets.graphics.anatomy.rondaIbex.path,
    "ANIMAL:ROOSEVELT_ELK": Assets.graphics.anatomy.rooseveltElk.path,
    "ANIMAL:SALTWATER_CROCODILE": Assets.graphics.anatomy.saltwaterCrocodile.path,
    "ANIMAL:SAMBAR": Assets.graphics.anatomy.sambar.path,
    "ANIMAL:SIBERIAN_MUSK_DEER": Assets.graphics.anatomy.siberianMuskDeer.path,
    "ANIMAL:SIDE_STRIPED_JACKAL": Assets.graphics.anatomy.sideStripedJackal.path,
    "ANIMAL:SIKA_DEER": Assets.graphics.anatomy.sikaDeer.path,
    "ANIMAL:SNOW_LEOPARD": Assets.graphics.anatomy.snowLeopard.path,
    "ANIMAL:SOUTHEASTERN_SPANISH_IBEX": Assets.graphics.anatomy.southeasternSpanishIbex.path,
    "ANIMAL:SPRINGBOK": Assets.graphics.anatomy.springbok.path,
    "ANIMAL:TAHR": Assets.graphics.anatomy.tahr.path,
    "ANIMAL:TIBETAN_FOX": Assets.graphics.anatomy.tibetanFox.path,
    "ANIMAL:WARTHOG": Assets.graphics.anatomy.warthog.path,
    "ANIMAL:WATER_BUFFALO": Assets.graphics.anatomy.waterBuffalo.path,
    "ANIMAL:WHITETAIL_DEER": Assets.graphics.anatomy.whitetailDeer.path,
    "ANIMAL:WILD_BOAR": Assets.graphics.anatomy.wildBoar.path,
    "ANIMAL:WILD_YAK": Assets.graphics.anatomy.wildYak.path,
    "ANIMAL:WOODLAND_CARIBOU": Assets.graphics.anatomy.caribou.path,
    "ANIMAL:WOOD_BISON": Assets.graphics.anatomy.woodBison.path,
  };

  static final Map<String, String> _reserves = {
    "RESERVE:ASKIY_RIDGE_HUNTING_PRESERVE": Assets.graphics.reserves.askiyridgehuntingpreserve,
    "RESERVE:CUATRO_COLINAS_GAME_RESERVE": Assets.graphics.reserves.cuatrocolinasgamereserve,
    "RESERVE:EMERALD_COAST_AUSTRALIA": Assets.graphics.reserves.emeraldcoastaustralia,
    "RESERVE:HIRSCHFELDEN_HUNTING_RESERVE": Assets.graphics.reserves.hirschfeldenhuntingreserve,
    "RESERVE:LAYTON_LAKE_DISTRICT": Assets.graphics.reserves.laytonlakedistrict,
    "RESERVE:MEDVED_TAIGA_NATIONAL_PARK": Assets.graphics.reserves.medvedtaiganationalpark,
    "RESERVE:MISSISSIPPI_ACRES_PRESERVE": Assets.graphics.reserves.mississippiacrespreserve,
    "RESERVE:NEW_ENGLAND_MOUNTAINS": Assets.graphics.reserves.newenglandmountains,
    "RESERVE:PARQUE_FERNANDO": Assets.graphics.reserves.parquefernando,
    "RESERVE:RANCHO_DEL_ARROYO": Assets.graphics.reserves.ranchodelarroyo,
    "RESERVE:REVONTULI_COAST": Assets.graphics.reserves.revontulicoast,
    "RESERVE:SALZWIESEN_PARK": Assets.graphics.reserves.salzwiesenpark,
    "RESERVE:SILVER_RIDGE_PEAKS": Assets.graphics.reserves.silverridgepeaks,
    "RESERVE:SUNDARPATAN_HUNTING_RESERVE": Assets.graphics.reserves.sundarpatanhuntingreserve,
    "RESERVE:TE_AWAROA_NATIONAL_PARK": Assets.graphics.reserves.teawaroanationalpark,
    "RESERVE:VURHONGA_SAVANNA_RESERVE": Assets.graphics.reserves.vurhongasavannareserve,
    "RESERVE:YUKON_VALLEY": Assets.graphics.reserves.yukonvalley,
  };

  static final Map<String, String> _weapons = {
    "WEAPON:7MM_REGENT_MAGNUM": Assets.graphics.weapons.a7mmregentmagnum,
    "WEAPON:10MM_DAVANI": Assets.graphics.weapons.a10mmdavani,
    "WEAPON:44_PANTHER_MAGNUM": Assets.graphics.weapons.a44panthermagnum,
    "WEAPON:45_ROLLESTON": Assets.graphics.weapons.a45rolleston,
    "WEAPON:223_DOCENT": Assets.graphics.weapons.a223docent,
    "WEAPON:243_RANGER": Assets.graphics.weapons.a243ranger,
    "WEAPON:243_R_CUOMO": Assets.graphics.weapons.a243rcuomo,
    "WEAPON:270_HUNTSMAN": Assets.graphics.weapons.a270huntsman,
    "WEAPON:300_CANNING_MAGNUM": Assets.graphics.weapons.a300canningmagnum,
    "WEAPON:303_FL_SPORTER": Assets.graphics.weapons.a303flsporter,
    "WEAPON:4570_JERNBERG_SUPERIOR": Assets.graphics.weapons.a4570jernbergsuperior,
    "WEAPON:ALEXANDER_LONGBOW": Assets.graphics.weapons.alexanderlongbow,
    "WEAPON:ANANTHA_ACTION_22MAG": Assets.graphics.weapons.ananthaaction22mag,
    "WEAPON:ANDERSSON_22LR": Assets.graphics.weapons.andersson22lr,
    "WEAPON:ARZYNA_300_MAG_TACTICAL": Assets.graphics.weapons.arzyna300magtactical,
    "WEAPON:BEARCLAW_LITE_CB60": Assets.graphics.weapons.bearclawlitecb60,
    "WEAPON:CACCIATORE_12G": Assets.graphics.weapons.cacciatore12g,
    "WEAPON:CAVERSHAM_STEWARD_12G": Assets.graphics.weapons.cavershamsteward12g,
    "WEAPON:COACHMATE_LEVER_4570": Assets.graphics.weapons.coachmatelever4570,
    "WEAPON:COUSO_MODEL_1897": Assets.graphics.weapons.cousomodel1897,
    "WEAPON:CROSSPOINT_CB165": Assets.graphics.weapons.crosspointcb165,
    "WEAPON:CURMAN_50_INLINE": Assets.graphics.weapons.curman50inline,
    "WEAPON:ECKERS_3006": Assets.graphics.weapons.eckers3006,
    "WEAPON:FOCOSO_357": Assets.graphics.weapons.focoso357,
    "WEAPON:FORS_ELITE_300": Assets.graphics.weapons.forselite300,
    "WEAPON:FROST_257": Assets.graphics.weapons.frost257,
    "WEAPON:GANDHARE_RIFLE": Assets.graphics.weapons.gandharerifle,
    "WEAPON:GIDDINGS_SSC_410_COYOTE": Assets.graphics.weapons.giddingsssc410coyote,
    "WEAPON:GOPI_10G_GRAND": Assets.graphics.weapons.gopi10ggrand,
    "WEAPON:GRELCK_DRILLING_RIFLE": Assets.graphics.weapons.grelckdrillingrifle,
    "WEAPON:HANSSON_3006": Assets.graphics.weapons.hansson3006,
    "WEAPON:HAWK_EDGE_CB70": Assets.graphics.weapons.hawkedgecb70,
    "WEAPON:HOUYI_RECURVE_BOW": Assets.graphics.weapons.houyirecurvebow,
    "WEAPON:HUDZIK_50_CAPLOCK": Assets.graphics.weapons.hudzik50caplock,
    "WEAPON:JOHANSSON_450": Assets.graphics.weapons.johansson450,
    "WEAPON:KING_470DB": Assets.graphics.weapons.king470db,
    "WEAPON:KOTER_CB65": Assets.graphics.weapons.kotercb65,
    "WEAPON:KULLMAN_22H": Assets.graphics.weapons.kullman22h,
    "WEAPON:LAPERRIERE_OUTRIDER_3030": Assets.graphics.weapons.laperriereoutrider3030,
    "WEAPON:M1_IWANIEC": Assets.graphics.weapons.m1iwaniec,
    "WEAPON:MALMER_7MM_MAGNUM": Assets.graphics.weapons.malmer7mmmagnum,
    "WEAPON:MANGIAFICO_41045_COLT": Assets.graphics.weapons.mangiafico41045colt,
    "WEAPON:MILLER_MODEL_1891": Assets.graphics.weapons.millermodel1891,
    "WEAPON:MORADI_MODEL_1894": Assets.graphics.weapons.moradimodel1894,
    "WEAPON:MÅRTENSSON_65MM": Assets.graphics.weapons.mRtensson65mm,
    "WEAPON:NORDIN_20SA": Assets.graphics.weapons.nordin20sa,
    "WEAPON:OLSSON_MODEL_23_308": Assets.graphics.weapons.olssonmodel23308,
    "WEAPON:PERRY_308": Assets.graphics.weapons.perry308,
    "WEAPON:QUIST_REAPER_762X39": Assets.graphics.weapons.quistreaper762x39,
    "WEAPON:RANGEMASTER_338": Assets.graphics.weapons.rangemaster338,
    "WEAPON:RAZORBACK_LITE_CB60": Assets.graphics.weapons.razorbacklitecb60,
    "WEAPON:RHINO_454": Assets.graphics.weapons.rhino454,
    "WEAPON:SOLOKHIN_MN1890": Assets.graphics.weapons.solokhinmn1890,
    "WEAPON:STENBERG_TAKEDOWN_RECURVE_BOW": Assets.graphics.weapons.stenbergtakedownrecurvebow,
    "WEAPON:STRANDBERG_10SA_EXECUTIVE": Assets.graphics.weapons.strandberg10saexecutive,
    "WEAPON:STRECKER_SXS_20G": Assets.graphics.weapons.streckersxs20g,
    "WEAPON:TSURUGI_LRR_338": Assets.graphics.weapons.tsurugilrr338,
    "WEAPON:VALLGARDA_375": Assets.graphics.weapons.vallgarda375,
    "WEAPON:VASQUEZ_CYCLONE_45": Assets.graphics.weapons.vasquezcyclone45,
    "WEAPON:VIRANT_22LR": Assets.graphics.weapons.virant22lr,
    "WEAPON:WHITLOCK_MODEL_86": Assets.graphics.weapons.whitlockmodel86,
    "WEAPON:ZAGAN_VARMINTER_22250": Assets.graphics.weapons.zaganvarminter22250,
    "WEAPON:ZARZA10_308": Assets.graphics.weapons.zarza10308,
    "WEAPON:ZARZA15_22LR": Assets.graphics.weapons.zarza1522lr,
    "WEAPON:ZARZA15_223": Assets.graphics.weapons.zarza15223,
  };

  static final Map<String, String> _callers = {
    "CALLER:ANTLER_RATTLER": Assets.graphics.callers.antlerrattler,
    "CALLER:AXIS_DEER_SCREAMER_CALLER": Assets.graphics.callers.axisdeerscreamercaller,
    "CALLER:BEACON_DELUXE_BEAN_GOOSE_CALLER": Assets.graphics.callers.beacondeluxebeangoosecaller,
    "CALLER:BEACON_DELUXE_DUCK_CALLER": Assets.graphics.callers.beacondeluxeduckcaller,
    "CALLER:BEACON_DELUXE_EURASIAN_TEAL_CALLER": Assets.graphics.callers.beacondeluxeeurasiantealcaller,
    "CALLER:BEACON_DELUXE_EURASIAN_WIGEON_CALLER": Assets.graphics.callers.beacondeluxeeurasianwigeoncaller,
    "CALLER:BEACON_DELUXE_GREYLAG_GOOSE_CALLER": Assets.graphics.callers.beacondeluxegreylaggoosecaller,
    "CALLER:BUCK_SNORT_WHEEZE_CALLER": Assets.graphics.callers.bucksnortwheezecaller,
    "CALLER:DEER_BLEAT_CALLER": Assets.graphics.callers.deerbleatcaller,
    "CALLER:DEER_GRUNT_CALLER": Assets.graphics.callers.deergruntcaller,
    "CALLER:ELK_CALLER": Assets.graphics.callers.elkcaller,
    "CALLER:GADWALL_CALLER": Assets.graphics.callers.gadwallcaller,
    "CALLER:HAZEL_GROUSE_CALLER": Assets.graphics.callers.hazelgrousecaller,
    "CALLER:MAGPIE_GOOSE_CALLER": Assets.graphics.callers.magpiegoosecaller,
    "CALLER:MOOSE_CALLER": Assets.graphics.callers.moosecaller,
    "CALLER:NORTHERN_PINTAIL_CALLER": Assets.graphics.callers.northenpintailcaller,
    "CALLER:PREDATOR_DISTRESSED_FAWN_CALLER": Assets.graphics.callers.predatordistressedfawncaller,
    "CALLER:PREDATOR_JACKRABBIT_CALLER": Assets.graphics.callers.predatorjackrabbitcaller,
    "CALLER:RACCOON_SQUALL_CALLER": Assets.graphics.callers.raccoonsquallcaller,
    "CALLER:RED_DEER_CALLER": Assets.graphics.callers.reddeercaller,
    "CALLER:ROE_DEER_CALLER": Assets.graphics.callers.roedeercaller,
    "CALLER:SAMBAR_MOUTH_CALLER": Assets.graphics.callers.sambarmouthcaller,
    "CALLER:SHORT_REED_CANADA_GOOSE_CALLER": Assets.graphics.callers.shortreedcanadagoosecaller,
    "CALLER:SNOW_GOOSE_CALLER": Assets.graphics.callers.snowgoosecaller,
    "CALLER:WILD_BOAR_CALLER": Assets.graphics.callers.wildboarcaller,
    "CALLER:WILD_TURKEY_CROW_CALLER": Assets.graphics.callers.wildturkeycrowcaller,
    "CALLER:WILD_TURKEY_MOUTH_CALLER": Assets.graphics.callers.wildturkeymouthcaller,
    "CALLER:WOOD_DUCK_CALLER": Assets.graphics.callers.woodduckcaller,
  };

  static final Map<String, String> _proficiency = {
    "PERK:BODY_CONTROL": Assets.graphics.proficiency.bodycontrol,
    "PERK:BOOMSTICK": Assets.graphics.proficiency.boomstick,
    "PERK:BOTH_EYES_OPEN": Assets.graphics.proficiency.botheyesopen,
    "PERK:BREATH_CONTROL": Assets.graphics.proficiency.breathcontrol,
    "PERK:CONNECT_THE_DOTS": Assets.graphics.proficiency.connectthedots,
    "PERK:DAZED_AND_CONFUSED": Assets.graphics.proficiency.dazedandconfused,
    "PERK:DISTURBED_VEGETATION": Assets.graphics.proficiency.disturbedvegetation,
    "PERK:ENDURANCE": Assets.graphics.proficiency.endurance,
    "PERK:FAST_SHOULDERING": Assets.graphics.proficiency.fastshouldering,
    "PERK:FATAL_ATTRACTION": Assets.graphics.proficiency.fatalattraction,
    "PERK:FOCUSED_SHOT": Assets.graphics.proficiency.focusedshot,
    "PERK:FULL_DRAW": Assets.graphics.proficiency.fulldraw,
    "PERK:HAGGLE": Assets.graphics.proficiency.haggle,
    "PERK:HARDENED": Assets.graphics.proficiency.hardened,
    "PERK:HILL_CALLER": Assets.graphics.proficiency.hillcaller,
    "PERK:IMPACT_RESISTANT": Assets.graphics.proficiency.impactresistant,
    "PERK:IMPROVISED_BLIND": Assets.graphics.proficiency.improvisedblind,
    "PERK:IM_ONLY_HAPPY_WHEN_IT_RAINS": Assets.graphics.proficiency.imonlyhappywhenitrains,
    "PERK:INCREASED_CONFIDENCE": Assets.graphics.proficiency.increasedconfidence,
    "PERK:INNATE_TRIANGULATION": Assets.graphics.proficiency.innatetriangulation,
    "PERK:KEEN_EYE": Assets.graphics.proficiency.keeneye,
    "PERK:LIGHTNING_HANDS": Assets.graphics.proficiency.lightninghands,
    "PERK:LIKE_A_PRO": Assets.graphics.proficiency.likeapro,
    "PERK:LOCATE_TRACKS": Assets.graphics.proficiency.locatetracks,
    "PERK:MOVE_N_SHOOT": Assets.graphics.proficiency.movenshoot,
    "PERK:MUSCLE_MEMORY": Assets.graphics.proficiency.musclememory,
    "PERK:PACK_MULE": Assets.graphics.proficiency.packmule,
    "PERK:PUMPING_IRON": Assets.graphics.proficiency.pumpingiron,
    "PERK:QUICK_DRAW": Assets.graphics.proficiency.quickdraw,
    "PERK:QUICK_FEET": Assets.graphics.proficiency.quickfeet,
    "PERK:RANGER": Assets.graphics.proficiency.ranger,
    "PERK:RECOIL_MANAGEMENT": Assets.graphics.proficiency.recoilmanagement,
    "PERK:RECYCLE": Assets.graphics.proficiency.recycle,
    "PERK:SCENT_TINKERER": Assets.graphics.proficiency.scenttinkerer,
    "PERK:SIGHT_SPOTTING": Assets.graphics.proficiency.sightspotting,
    "PERK:SOFT_FEET": Assets.graphics.proficiency.softfeet,
    "PERK:SPOTTING_KNOWLEDGE": Assets.graphics.proficiency.spottingknowledge,
    "PERK:SPRINT_AND_LOAD": Assets.graphics.proficiency.sprintandload,
    "PERK:STARTLE_CALL": Assets.graphics.proficiency.startlecall,
    "PERK:STEADY_HANDS": Assets.graphics.proficiency.steadyhands,
    "PERK:SURVIVAL_INSTINCT": Assets.graphics.proficiency.survivalinstinct,
    "PERK:TAG": Assets.graphics.proficiency.tag,
    "PERK:THE_MORE_THE_MERRIER": Assets.graphics.proficiency.themorethemerrier,
    "PERK:TRACERSHOT": Assets.graphics.proficiency.tracershot,
    "PERK:TRACK_KNOWLEDGE": Assets.graphics.proficiency.trackknowledge,
    "PERK:WEATHER_PREDICTION": Assets.graphics.proficiency.weatherprediction,
    "PERK:WINDAGE": Assets.graphics.proficiency.windage,
    "PERK:WIND_PREDICTION": Assets.graphics.proficiency.windprediction,
    "PERK:ZEROING": Assets.graphics.proficiency.zeroing,
    "SKILL:WHOS_DEER": Assets.graphics.proficiency.whosdeer,
  };

  static final _svgPlaceholder = Assets.graphics.icons.placeholder;
  static final _pngPlaceholder = Assets.graphics.images.placeholder.path;

  static String getAnimalIcon(Animal animal) => _animals[animal.asset] ?? _svgPlaceholder;

  static String getAnimalHead(Animal animal) => _heads[animal.asset] ?? _pngPlaceholder;

  static String getAnimalAnatomy(Animal animal) => _anatomy[animal.asset] ?? _svgPlaceholder;

  static String getSenseIcon(Sense sense) {
    switch (sense) {
      case Sense.sight:
        return Assets.graphics.icons.senseSight;
      case Sense.smell:
        return Assets.graphics.icons.senseSmell;
      case Sense.hearing:
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
    return "assets/graphics/maps/${reserve.asset.replaceAll(RegExp(r'\S+:'), "").replaceAll("_", "").toLowerCase()}/$z/$i.webp";
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
