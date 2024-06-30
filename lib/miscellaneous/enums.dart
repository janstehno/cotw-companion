enum ItemType {
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

enum AnatomyPart {
  body,
  organs,
  bones,
}

enum SenseType {
  sight,
  hearing,
  smell,
}

enum MissionType {
  main,
  side,
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
  reservesCountMin,
  reservesCountMax,
  animalsClass,
  animalsDifficulty,
  weaponsAnimalClass,
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
  huntingPassRandomReserve,
  huntingPassRandomAnimal,
  huntingPassRandomWeapon,
  huntingPassRandomAmmo,
  huntingPassRandomDistance,
  huntingPassRandomAllowedDlc,
  huntingPassRandomAllowedDog,
  huntingPassRandomAllowedCallers,
  huntingPassRandomAllowedScopes,
  huntingPassRandomAllowedStructures,
  huntingPassRandomAllowedFastTravel,
  huntingPassRandomAllowedAtv,
  huntingPassRandomAllowedDayTime,
}
