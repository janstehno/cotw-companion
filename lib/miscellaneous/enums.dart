enum Item {
  reserve,
  animal,
  caller,
  weapon,
  ammo,
}

enum ProficiencyType {
  rifle,
  shotgun,
  handgun,
  archery,
  stalker,
  ambusher,
}

enum MapLocationType {
  outpost,
  lookout,
  hide,
  zone,
}

enum WeaponType {
  rifle,
  shotgun,
  handgun,
  bow,
}

enum DlcType {
  reserve,
  weapon,
  equipment,
  species,
  general,
}

enum Sense {
  sight,
  hearing,
  smell,
}

enum MissionType {
  main,
  side,
}

enum MissionDifficulty {
  easy,
  mediocre,
  hard,
  veryHard,
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
  common,
  uncommon,
  rare,
  mission,
  greatOne,
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
