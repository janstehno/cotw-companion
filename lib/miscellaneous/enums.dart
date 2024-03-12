// Copyright (c) 2023 Jan Stehno

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

enum MapItem {
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

enum AnatomyPart {
  body,
  organs,
  bones,
}

enum MultimountSize {
  xs,
  s,
  m,
  l,
  xl,
  xxl,
}

enum DateStructure {
  json,
  format,
  compare,
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
  reservesCountMin,
  reservesCountMax,
  animalsClass,
  animalsDifficulty,
  weaponsAnimalClass,
  weaponsClassMin,
  weaponsClassMax,
  weaponsMagMin,
  weaponsMagMax,
  weaponsRifles,
  weaponsShotguns,
  weaponsHandguns,
  weaponsBows,
  callersEffectiveRange,
  logsGender,
  logsTrophyRating,
  logsFurRarity,
  logsTrophyScoreMin,
  logsTrophyScoreMax,
  logsSort,
  loadoutsAmmoMin,
  loadoutsAmmoMax,
  loadoutsCallersMin,
  loadoutsCallersMax,
  missionType,
  missionDifficulty,
}
