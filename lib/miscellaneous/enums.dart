import 'package:cotwcompanion/interface/interface.dart';
import 'package:flutter/material.dart';

enum Item {
  reserve,
  animal,
  caller,
  weapon,
  ammo,
}

enum ProficiencyType {
  rifle(0),
  shotgun(1),
  handgun(2),
  archery(3),
  stalker(4),
  ambusher(5);

  final int id;

  const ProficiencyType(this.id);
}

enum MapLocationType {
  outpost,
  lookout,
  hide,
  zone,
}

enum WeaponType {
  rifle(0, "RIFLE"),
  shotgun(1, "SHOTGUN"),
  handgun(2, "HANDGUN"),
  bow(3, "BOW_CROSSBOW");

  final int id;
  final String key;

  const WeaponType(this.id, this.key);
}

enum DlcType {
  reserve(0),
  weapon(1),
  equipment(2),
  species(3),
  general(4);

  final int id;

  const DlcType(this.id);
}

enum Sense {
  sight,
  hearing,
  smell,
}

enum MissionType {
  main(0, "MISSION_MAIN"),
  side(1, "MISSION_SIDE");

  final int id;
  final String key;

  const MissionType(this.id, this.key);
}

enum MissionDifficulty {
  easy(0, "DIFFICULTY_EASY", Interface.green),
  mediocre(1, "DIFFICULTY_MEDIOCRE", Interface.yellow),
  hard(2, "DIFFICULTY_HARD", Interface.orange),
  veryHard(3, "DIFFICULTY_VERY_HARD", Interface.red);

  final int id;
  final String key;
  final Color color;

  const MissionDifficulty(this.id, this.key, this.color);
}

enum Units {
  metric,
  imperial,
}

enum ThresholdLevel {
  min,
  max,
}

enum CategoryType {
  go,
  male,
  female,
}

enum ModifyType {
  add,
  edit,
}

enum DateStructure {
  json,
  format,
  compare,
}

enum Change {
  reserve,
  animal,
  gender,
  fur,
  other,
}

enum Process {
  success,
  error,
  info,
}

enum Supporter {
  translation,
  donation,
}

enum FilterKey {
  animalClass,
  animalDifficulty,
  animalTaxonomy,
  animalGreatOne,
  weaponType,
  weaponAnimalClass,
  weaponMagMin,
  weaponMagMax,
  missionType,
  missionDifficulty,
  logsGender,
  logsTrophyRating,
  logsFurRarity,
  logsTrophyScoreMin,
  logsTrophyScoreMax,
  huntingPassGeneral,
  huntingPassWeapons,
  huntingPassReserveDlcs,
  huntingPassWeaponDlcs,
  logsTrophyLodge,
  logsView,
  logsDate,
  logsInformation,
  logsViewEntry,
}

enum TrophyRating {
  none,
  bronze,
  silver,
  gold,
  diamond,
  greatOne,
}

enum FurRarity {
  common(0, "RARITY_COMMON", Interface.rarityCommon),
  uncommon(1, "RARITY_UNCOMMON", Interface.rarityUncommon),
  rare(2, "RARITY_RARE", Interface.rarityRare),
  mission(3, "RARITY_MISSION", Interface.rarityMission),
  greatOne(4, "FUR:GREAT_ONE", Interface.rarityGreatOne);

  final int id;
  final String key;
  final Color color;

  const FurRarity(this.id, this.key, this.color);
}

enum Gender {
  male,
  female,
}

enum AnimalTaxonomy {
  mammals(0, "TAXONOMY_MAMMALS"),
  reptiles(1, "TAXONOMY_REPTILES"),
  antlered(2, "TAXONOMY_ANTLERED"),
  deer(3, "TAXONOMY_DEER"),
  tusked(4, "TAXONOMY_TUSKED"),
  pigs(5, "TAXONOMY_PIGS"),
  antelopes(6, "TAXONOMY_ANTELOPES"),
  bovids(7, "TAXONOMY_BOVIDS"),
  bison(8, "TAXONOMY_BISON"),
  predators(9, "TAXONOMY_PREDATORS"),
  bears(10, "TAXONOMY_BEARS"),
  canines(11, "TAXONOMY_CANINES"),
  wolves(12, "TAXONOMY_WOLVES"),
  felids(13, "TAXONOMY_FELIDS"),
  foxes(14, "TAXONOMY_FOXES"),
  birds(15, "TAXONOMY_BIRDS"),
  waterfowl(16, "TAXONOMY_WATERFOWL"),
  ducks(17, "TAXONOMY_DUCKS"),
  geese(18, "TAXONOMY_GEESE"),
  grouse(19, "TAXONOMY_GROUSE"),
  upland(20, "TAXONOMY_UPLAND_GAME_BIRDS"),
  quails(21, "TAXONOMY_QUAILS"),
  turkeys(22, "TAXONOMY_TURKEYS"),
  hares(23, "TAXONOMY_HARES"),
  horned(24, "TAXONOMY_HORNED"),
  sheep(25, "TAXONOMY_SHEEP"),
  rabbits(26, "TAXONOMY_RABBITS");

  final int id;
  final String key;

  const AnimalTaxonomy(this.id, this.key);
}

enum AnimalOther {
  greatOne,
}

enum HuntingPassOption {
  randomReserve,
  randomAnimal,
  randomWeapon,
  randomAmmo,
  randomDistance,
  randomAllowedDog,
  randomAllowedCallers,
  randomAllowedScopes,
  randomAllowedStructures,
  randomAllowedAtv,
  randomAllowedFastTravel,
  randomAllowedDayTime,
}

enum FilterOperation {
  or,
  and,
  not,
}

enum FilterType {
  animals,
  weapons,
  huntingPass,
  logs,
  reserves,
  callers,
  enumerators,
  counters,
  multimounts,
}

enum LogsView {
  trophyLodge,
  date,
  notTrophyLodge,
}

enum SortKey {
  az,
  date,
  trophyScore,
  trophyRating,
  furRarity,
  gender,
}

enum RepositoryData {
  issues,
  discussions,
}
