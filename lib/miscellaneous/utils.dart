import 'dart:io';

import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/widgets/app/bar_snack.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Color backgroundAt(int i) => i % 2 == 0 ? Interface.odd : Interface.even;

  static void _hideSnackBar(BuildContext context) => ScaffoldMessenger.of(context).hideCurrentSnackBar();

  static void _buildSnackBar(WidgetSnackBar snackBar, BuildContext context) {
    _hideSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1000),
        padding: const EdgeInsets.all(0),
        backgroundColor: Interface.search,
        content: GestureDetector(
          onTap: () => _hideSnackBar(context),
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
          buttonIcon: Assets.graphics.icons.reload,
          onButtonTap: () {
            _hideSnackBar(context);
            undo();
          }),
      context,
    );
  }

  static dynamic dateTimeAs(DateStructure type, DateTime dateTime) {
    switch (type) {
      case DateStructure.compare:
        return dateTime;
      case DateStructure.format:
        return "${dateTime.day}. ${dateTime.month}. ${dateTime.year}  ${dateTime.hour}:${dateTime.minute}";
      case DateStructure.json:
        return "${dateTime.year}-${dateTime.month}-${dateTime.day}-${dateTime.hour}-${dateTime.minute}";
    }
  }

  static String removePointZero(double value) {
    String text = value.toString();
    List<String> split = text.split(".");
    return (split.length == 2 && split[1] == "0") ? split[0] : text;
  }

  static void redirectTo(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Unfortunately the link could not be launched. Please, go back or restart the application.");
    }
  }

  static void mailTo() async {
    if (!await launchUrl(Uri(scheme: 'mailto', path: 'toastovac@email.cz'), mode: LaunchMode.externalApplication)) {
      throw Exception("Unfortunately the link could not be launched. Please, go back or restart the application.");
    }
  }

  static Future<bool> exportFile(String content, String name) async {
    HelperLogger logger = HelperLogger(identifier: "[UTILS] [EXPORT]");
    PermissionStatus status = PermissionStatus.granted;

    if (Platform.isAndroid) {
      AndroidDeviceInfo device = await DeviceInfoPlugin().androidInfo;
      if (int.parse(device.version.release) < 13) status = await Permission.storage.request();
    }

    logger.d("Permission granted: ${status.isGranted}");

    if (status.isGranted) {
      final String? path = await FilePicker.platform.getDirectoryPath();
      logger.d("Chosen folder: $path");
      if (path == null || content == "[]") return false;
      try {
        logger.d("Creating file $name");
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
