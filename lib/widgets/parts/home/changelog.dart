import 'dart:convert';

import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/bar_scroll.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/button/switch_text.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetChangelog extends StatefulWidget {
  final int _currentBuildNumber;
  final Function _onDismiss;

  const WidgetChangelog({
    required int currentBuildNumber,
    required Function onDismiss,
    super.key,
  })  : _currentBuildNumber = currentBuildNumber,
        _onDismiss = onDismiss;

  int get currentBuildNumber => _currentBuildNumber;

  Function get onDismiss => _onDismiss;

  @override
  State<WidgetChangelog> createState() => _WidgetChangelogState();
}

class _WidgetChangelogState extends State<WidgetChangelog> {
  List<String> _changes = [];
  bool _doNotShowAgain = false;

  @override
  void initState() {
    _loadChangelog();
    super.initState();
  }

  Future<void> _loadChangelog() async {
    final settings = Provider.of<Settings>(context, listen: false);
    final languageCode = settings.getLocale(settings.language).languageCode;

    final String jsonString = await rootBundle.loadString('assets/raw/changelog.json');
    final Map<String, dynamic> changelog = json.decode(jsonString);

    final List<dynamic>? localized = changelog[languageCode] ?? changelog['en'];

    setState(() {
      _changes = List<String>.from(localized ?? []);
    });
  }

  Future<void> _dismiss() async {
    if (_doNotShowAgain) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('lastBuildNumber', widget.currentBuildNumber);
    }
    widget.onDismiss();
  }

  Widget _buildText() {
    return WidgetText(
      Values.version.toString(),
      color: Interface.dark,
      style: Style.condensed.s18.w600,
      maxLines: 1,
      textAlign: TextAlign.start,
    );
  }

  List<Widget> _listChanges() {
    return _changes
        .map((text) => WidgetText("• $text", color: Interface.dark, style: Style.normal.s14.w300, autoSize: false))
        .toList();
  }

  Widget _buildShow() {
    return WidgetSwitchText(
      tr("DO_NOT_SHOW"),
      color: Interface.light,
      background: Interface.dark,
      isActive: _doNotShowAgain,
      onTap: () {
        setState(() {
          _doNotShowAgain = !_doNotShowAgain;
        });
      },
    );
  }

  Widget _buildCancel() {
    return WidgetButtonIcon(
      Assets.graphics.icons.menuClose,
      color: Interface.alwaysDark,
      background: Interface.primary,
      onTap: () => _dismiss(),
    );
  }

  Widget _buildList() {
    return WidgetScrollBar(
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._listChanges(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 27, 30, 30),
        decoration: BoxDecoration(
          color: Interface.search.withAlpha(245),
          border: Border(
            top: BorderSide(
              color: Interface.primary,
              width: 5,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText(),
            SizedBox(height: 20),
            Expanded(child: _buildList()),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShow(),
                _buildCancel(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgets() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          _buildBody(),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
