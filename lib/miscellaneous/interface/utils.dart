// Copyright (c) 2023 Jan Stehno

import 'dart:io';

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/dlc.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/model/multimount.dart';
import 'package:cotwcompanion/model/perk.dart';
import 'package:cotwcompanion/model/proficiency.dart';
import 'package:cotwcompanion/model/skill.dart';
import 'package:cotwcompanion/widgets/snackbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Color background(int index) => index % 2 == 0 ? Interface.odd : Interface.even;

  static void redirectTo(String host, String path) async {
    if (!await launchUrl(Uri(scheme: "https", host: host, path: path), mode: LaunchMode.externalApplication)) {
      throw 'Unfortunately the link could not be launched. Please, go back or restart the application.';
    }
  }

  static String removePointZero(double value) {
    String text = value.toString();
    List<String> split = text.split(".");
    text = (split.length == 2 && split[1] == "0") ? split[0] : text;
    return text;
  }

  static String dateToString(DateTime date) => "${date.year}-${date.month}-${date.day}-${date.hour}-${date.minute}";

  static void _hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void _buildSnackBar(WidgetSnackBar snackBar, BuildContext context) {
    _hideSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1000),
        padding: const EdgeInsets.all(0),
        backgroundColor: Interface.search,
        content: GestureDetector(
          onTap: () {
            _hideSnackBar(context);
          },
          child: snackBar,
        ),
      ),
    );
  }

  static void buildSnackBarMessage(String message, Process process, BuildContext context) {
    _buildSnackBar(
      WidgetSnackBar(
        text: message,
        process: process,
      ),
      context,
    );
  }

  static void buildSnackBarUndo(String message, Process process, Function undo, BuildContext context) {
    _buildSnackBar(
      WidgetSnackBar(
        text: message,
        process: process,
        icon: "assets/graphics/icons/reload.svg",
        onSnackBarTap: () {
          _hideSnackBar(context);
          undo();
        },
      ),
      context,
    );
  }

  static Future<bool> exportFile(String content, String name) async {
    PermissionStatus status = PermissionStatus.granted;
    if (Platform.isAndroid) {
      AndroidDeviceInfo device = await DeviceInfoPlugin().androidInfo;
      if (int.parse(device.version.release) < 13) {
        status = await Permission.storage.request();
      }
    }
    if (status.isGranted) {
      final String? path = await FilePicker.platform.getDirectoryPath();
      if (path == null) {
        return false;
      }
      if (content == "[]") {
        return false;
      }
      try {
        final File file = File("$path/$name");
        await file.writeAsString(content);
      } on Exception {
        return false;
      }
      return true;
    }
    return false;
  }

  static Future<bool> importFile(Function after) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["json"],
    );
    if (result == null) {
      return false;
    }
    final String? filePath = result.files.first.path;
    if (filePath == null) {
      return false;
    }
    final File file = File(filePath);
    final content = await HelperJSON.fileToJson(file);
    return after(content);
  }

  static Future<String> readFile(String name) async {
    try {
      final file = await _localFile(name);
      final String contents;
      await file.exists() ? contents = await file.readAsString() : contents = "[]";
      return contents;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<File> writeFile(String content, String name) async {
    final file = await _localFile(name);
    return file.writeAsString(content);
  }

  static Future<File> _localFile(String name) async {
    final path = await _localPath;
    return File("$path/$name.json");
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Map<int, List<Perk>> getPerksFor(ProficiencyType type) {
    Map<int, List<Perk>> perks = {0: [], 1: [], 2: [], 3: []};
    for (Perk perk in HelperJSON.perks) {
      if (perk.type == type.index) perks[perk.tier]!.add(perk);
    }
    return perks;
  }

  static Map<int, List<Skill>> getSkillsFor(ProficiencyType type) {
    Map<int, List<Skill>> perks = {0: [], 1: [], 2: [], 3: [], 4: []};
    for (Skill skill in HelperJSON.skills) {
      if (skill.type == type.index) perks[skill.tier]!.add(skill);
    }
    return perks;
  }

  static void resetSkillsFor(ProficiencyType type) {
    for (Skill skill in HelperJSON.skills) {
      if (skill.type == type.index) skill.resetLevel();
    }
  }

  static void resetPerksFor(ProficiencyType type) {
    for (Perk perk in HelperJSON.perks) {
      if (perk.type == type.index) perk.resetLevel();
    }
  }

  static int getSkillPointsFor(ProficiencyType type, bool actual) {
    int points = 0;
    for (Proficiency skill in HelperJSON.skills) {
      if (skill.type == type.index) points += actual ? skill.actualLevel : skill.level;
    }
    return points;
  }

  static int getPerkPointsFor(ProficiencyType type, bool actual) {
    int points = 0;
    for (Perk perk in HelperJSON.perks) {
      if (perk.type == type.index) points += actual ? perk.actualLevel : perk.level;
    }
    return points;
  }

  static int getActiveSkillPoints() {
    int points = 0;
    for (Proficiency skill in HelperJSON.skills) {
      points += skill.actualLevel;
    }
    return points;
  }

  static int getActivePerkPoints() {
    int points = 0;
    for (Perk perk in HelperJSON.perks) {
      points += perk.actualLevel;
    }
    return points;
  }

  static String getWeaponDLC(int id) {
    for (Dlc dlc in HelperJSON.dlcs) {
      if (dlc.weapons.contains(id)) return dlc.en;
    }
    return tr("none");
  }

  static int? isMultimountAnimalInTrophyLodge(MultimountAnimal multimountAnimal, List<int> usedLogs) {
    List<Log> logs = [];
    logs.addAll(HelperLog.logs);
    Log log;
    try {
      log = logs.firstWhere((log) => log.isInLodge && log.animalId == multimountAnimal.id && log.gender == multimountAnimal.gender && !usedLogs.contains(log.id));
    } catch (e) {
      return null;
    }
    return log.id;
  }
}
