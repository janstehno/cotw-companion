// Copyright (c) 2023 Jan Stehno

import 'dart:io';

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/snackbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
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

  static String dateToString(DateTime date) {
    return "${date.year}-${date.month}-${date.day}-${date.hour}-${date.minute}";
  }

  static SnackBar snackBar(Function hide, String message, Process process) {
    return SnackBar(
        duration: const Duration(milliseconds: 1000),
        padding: const EdgeInsets.all(0),
        backgroundColor: Interface.search,
        content: GestureDetector(
            onTap: () {
              hide();
            },
            child: WidgetSnackBar(
              text: message,
              process: process,
            )));
  }

  static SnackBar snackBarUndo(Function hide, String message, Process process, Function undo) {
    return SnackBar(
        duration: const Duration(milliseconds: 5000),
        padding: const EdgeInsets.all(0),
        backgroundColor: Interface.search,
        content: GestureDetector(
            onTap: () {
              hide();
            },
            child: WidgetSnackBar(
              text: message,
              process: process,
              icon: "assets/graphics/icons/reload.svg",
              onSnackBarTap: () {
                undo();
              },
            )));
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
}
