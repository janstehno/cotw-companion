import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/planner.dart';
import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/describable/proficiency.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class WidgetProficiency<I extends Proficiency> extends StatefulWidget {
  final HelperPlanner _helperPlanner;
  final double _size;
  final int _availablePoints;
  final I _proficiency;
  final Function _rebuild, _showDetail;

  const WidgetProficiency({
    super.key,
    required HelperPlanner helperPlanner,
    required double size,
    required int availablePoints,
    required I proficiency,
    required Function rebuild,
    required Function showDetail,
  })  : _helperPlanner = helperPlanner,
        _size = size,
        _availablePoints = availablePoints,
        _proficiency = proficiency,
        _rebuild = rebuild,
        _showDetail = showDetail;

  HelperPlanner get helperPlanner => _helperPlanner;

  double get size => _size;

  int get availablePoints => _availablePoints;

  I get proficiency => _proficiency;

  Function get rebuild => _rebuild;

  get showDetail => _showDetail;

  @override
  State<StatefulWidget> createState() => WidgetProficiencyState<I>();
}

class WidgetProficiencyState<I extends Proficiency> extends State<WidgetProficiency> {
  final double _levelSize = 5;
  final double _levelsHeight = 10;

  bool get _isUnlocked => widget.proficiency.isUnlocked(widget.helperPlanner);

  bool get _isUsable => widget.proficiency.isUsable(widget.helperPlanner, widget.availablePoints);

  String get _getIcon => Graphics.getProficiencyIcon(widget.proficiency);

  void _onTap() {
    setState(() {
      if (_isUnlocked && _isUsable) {
        widget.proficiency.addLevel();
        widget.rebuild();
      }
    });
  }

  Widget _buildLock() {
    return Positioned(
      bottom: 0,
      child: SimpleShadow(
        sigma: 5,
        color: Interface.shadow,
        offset: const Offset(0, 0),
        child: WidgetIcon.withSize(
          Assets.graphics.icons.lock,
          color: Interface.red,
          size: widget.size / 5,
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return WidgetIcon.withSize(
      _getIcon,
      color: _isUnlocked ? Interface.dark : Interface.disabled,
      size: widget.size,
    );
  }

  Widget _buildProficiency() {
    return Expanded(
      child: Container(
        width: widget.size - _levelsHeight,
        height: widget.size - _levelsHeight,
        alignment: Alignment.center,
        padding: EdgeInsets.all(widget.size / 10),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            _buildIcon(),
            if (!_isUnlocked) _buildLock(),
          ],
        ),
      ),
    );
  }

  Widget _buildLevel(int i) {
    return WidgetIndicator(
      widget.proficiency.isLevelActive(i + 1) ? Interface.primary : Interface.disabled,
      size: _levelSize,
    );
  }

  List<Widget> _listLevels() {
    return List.generate(widget.proficiency.level, (i) => i).map((e) => _buildLevel(e)).toList();
  }

  Widget _buildLevels() {
    return Container(
      width: widget.size,
      height: _levelsHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: _levelSize),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 3,
        children: _listLevels(),
      ),
    );
  }

  Widget _buildWidgets() {
    return GestureDetector(
      onTap: () => _onTap(),
      onLongPress: () => widget.showDetail(widget.proficiency),
      child: Container(
        margin: const EdgeInsets.all(5),
        width: widget.size,
        height: widget.size,
        alignment: Alignment.center,
        child: Column(
          children: [
            _buildProficiency(),
            if (widget.proficiency.isUnlocked(widget.helperPlanner)) _buildLevels(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
