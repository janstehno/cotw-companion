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
