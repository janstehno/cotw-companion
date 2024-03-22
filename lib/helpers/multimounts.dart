import 'dart:convert';

import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/model/translatable/multimount.dart';

class HelperMultimounts {
  final HelperLogger _logger = HelperLogger.loadingMultimounts();

  final List<Multimount> _multimounts = [];

  List<Multimount> get multimounts => _multimounts;

  Multimount getMultimount(int id) => _multimounts.elementAt(id - 1);

  void setMultimounts(List<Multimount> multimounts) {
    _logger.i("Initializing multimounts in HelperPlanner...");
    _multimounts.clear();
    _multimounts.addAll(multimounts);
    _logger.t("Multimounts initialized");
  }

  Future<List<Multimount>> readMultimounts() async {
    try {
      final data = await HelperJSON.getData(Assets.raw.multimounts);
      final list = json.decode(data) as List<dynamic>;
      final List<Multimount> multimounts = list.map((e) => Multimount.fromJson(e)).toList();
      _logger.t("${multimounts.length} multimounts loaded");
      return multimounts;
    } catch (e) {
      _logger.w("Multimounts not loaded");
      rethrow;
    }
  }
}
