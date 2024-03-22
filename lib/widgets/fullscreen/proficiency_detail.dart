import 'package:collection/collection.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/model/describable/proficiency.dart';
import 'package:cotwcompanion/widgets/app/bar_scroll.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/title/title_button_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetProficiencyDetail extends StatelessWidget {
  final Proficiency _proficiency;
  final Function _onClose;

  const WidgetProficiencyDetail({
    super.key,
    required Proficiency proficiency,
    required BuildContext context,
    required Function onClose,
  })  : _proficiency = proficiency,
        _onClose = onClose;

  Widget _buildName() {
    return WidgetTitleButtonIcon(
      _proficiency.name,
      subtext: _proficiency.isAbility ? tr("PROFICIENCY_ACTIVE") : tr("PROFICIENCY_PASSIVE"),
      icon: Assets.graphics.icons.menuClose,
      alignRight: true,
      onTap: () => _onClose(),
    );
  }

  Widget _buildLevelDetail(String description, bool isLevelActive, int level) {
    return WidgetMargin.bottom(
      10,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLevel(isLevelActive, level),
          Expanded(child: _buildDescription(description)),
        ],
      ),
    );
  }

  List<Widget> _listDescription() {
    return _proficiency.description.mapIndexed((i, description) {
      bool isActive = _proficiency.isLevelActive(i + 1);
      return _buildLevelDetail(description, isActive, i + 1);
    }).toList();
  }

  Widget _buildLevels() {
    return WidgetPadding.a30(
      alignment: Alignment.topLeft,
      child: WidgetScrollBar(
        child: SingleChildScrollView(
          child: Column(
            children: _listDescription(),
          ),
        ),
      ),
    );
  }

  Widget _buildLevel(bool isLevelActive, int level) {
    return WidgetMargin.right(
      7,
      child: Stack(
        alignment: Alignment.center,
        children: [
          WidgetIndicator(isLevelActive ? Interface.primary : Interface.disabled),
          WidgetText(
            level.toString(),
            color: isLevelActive ? Interface.alwaysDark : Interface.disabledForeground,
            style: Style.normal.s12.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(String description) {
    return WidgetMargin.top(
      1,
      child: WidgetText(
        tr(description),
        color: Interface.dark,
        style: Style.normal.s14.w300,
        autoSize: false,
      ),
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Interface.body,
        child: Column(
          children: [
            _buildName(),
            Expanded(child: _buildLevels()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
