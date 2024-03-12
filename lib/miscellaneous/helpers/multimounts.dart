// Copyright (c) 2023 Jan Stehno

import 'dart:convert';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/logger.dart';
import 'package:cotwcompanion/model/multimount.dart';

class HelperMultimounts {
  final HelperLogger _logger = HelperLogger.loadingMultimounts();

  final List<Multimount> _multimounts = [];

  List<Multimount> get multimounts => _multimounts;

  Multimount getMultimount(int id) => _multimounts.elementAt(id - 1);

  void setMultimounts(List<Multimount> multimounts) {
    _logger.i("Initializing perks in HelperPlanner...");
    _multimounts.clear();
    _multimounts.addAll(multimounts);
    _logger.t("Perks initialized");
  }

  Future<List<Multimount>> readMultimounts() async {
    try {
      final data = await HelperJSON.getData("multimounts");
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
