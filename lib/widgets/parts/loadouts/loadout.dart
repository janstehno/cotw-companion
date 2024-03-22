import 'package:cotwcompanion/activities/modify/edit/loadouts.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/helpers/loadout.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/exportable/loadout.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/parts/dismissible.dart';
import 'package:cotwcompanion/widgets/section/section_indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryLoadout extends WidgetDismissible {
  final Loadout _loadout;

  const EntryLoadout(
    super.i, {
    super.key,
    required Loadout loadout,
    required super.callback,
    required super.context,
  }) : _loadout = loadout;

  Loadout get loadout => _loadout;

  @override
  EntryLoadoutState createState() => EntryLoadoutState();
}

class EntryLoadoutState extends WidgetDismissibleState {
  bool _detail = false;
  bool _detailDelay = false;
  bool _showDetail = false;

  Duration get _duration => const Duration(milliseconds: 200);

  double get _ammoHeight => 20;

  double get _callerHeight => 20;

  double get _actualHeight {
    if (_showDetail) {
      return ((20 * (widget as EntryLoadout).loadout.ammo.length) +
          (20 * (widget as EntryLoadout).loadout.callers.length) +
          ((widget as EntryLoadout).loadout.ammo.isNotEmpty ? 40 : 0) +
          ((widget as EntryLoadout).loadout.callers.isNotEmpty ? 40 : 0));
    }
    return 0;
  }

  @override
  void undo() {
    HelperLoadout.undoRemove();
    if (widget.callback != null) widget.callback!();
  }

  @override
  void onTap() {
    setState(() {
      if (HelperLoadout.activeLoadout == (widget as EntryLoadout).loadout) {
        HelperLoadout.useLoadout(null);
      } else {
        HelperLoadout.useLoadout((widget as EntryLoadout).loadout);
      }
      if (widget.callback != null) widget.callback!();
    });
  }

  @override
  void onDoubleTap() {
    setState(() {
      if (_detail) {
        _detailDelay = false;
        Future.delayed(_duration, () => setState(() => _showDetail = false));
      } else {
        _showDetail = true;
        Future.delayed(_duration, () => setState(() => _detailDelay = true));
      }
      _detail = !_detail;
      if (widget.callback != null) widget.callback!();
    });
  }

  @override
  void startToEnd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => ActivityEditLoadouts((widget as EntryLoadout).loadout, onSuccess: widget.callback ?? () {}),
      ),
    );
  }

  @override
  void endToStart() {
    setState(() {
      HelperLoadout.removeLoadout((widget as EntryLoadout).loadout);
      if (widget.callback != null) widget.callback!();
    });
    Utils.buildSnackBarUndo(
      tr("ITEM_REMOVED"),
      Process.info,
      undo,
      widget.context,
    );
  }

  Widget _buildRow() {
    return WidgetSectionIndicator(
      (widget as EntryLoadout).loadout.name,
      background: Utils.backgroundAt(widget.i),
      indicatorColor: HelperLoadout.isActive((widget as EntryLoadout).loadout) ? Interface.primary : Interface.disabled,
    );
  }

  Widget _buildAmmoName() {
    return Container(
      height: _ammoHeight,
      alignment: Alignment.centerLeft,
      child: WidgetText(
        tr("WEAPON_AMMO"),
        color: Interface.dark,
        style: Style.normal.s16.w300,
      ),
    );
  }

  List<Widget> _listAmmo() {
    return (widget as EntryLoadout).loadout.ammo.map((e) {
      return SizedBox(
        height: _ammoHeight,
        child: WidgetMargin.left(
          10,
          child: WidgetText(
            HelperJSON.getAmmo(e.ammoId)!.name,
            color: Interface.dark,
            style: Style.normal.s12.w300,
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _listLoadoutAmmo() {
    return [
      _buildAmmoName(),
      ..._listAmmo(),
      if ((widget as EntryLoadout).loadout.callers.isNotEmpty) const SizedBox(height: 10),
    ];
  }

  Widget _buildCallerName() {
    return Container(
      height: _callerHeight,
      alignment: Alignment.centerLeft,
      child: WidgetText(
        tr("CALLERS"),
        color: Interface.dark,
        style: Style.normal.s16.w300,
      ),
    );
  }

  List<Widget> _listCallers() {
    return (widget as EntryLoadout).loadout.callers.map((e) {
      return SizedBox(
        height: _callerHeight,
        child: WidgetMargin.left(
          10,
          child: WidgetText(
            e.name,
            color: Interface.dark,
            style: Style.normal.s12.w300,
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _listLoadoutCallers() {
    return [
      _buildCallerName(),
      ..._listCallers(),
    ];
  }

  Widget _buildDetail() {
    return AnimatedContainer(
      color: Utils.backgroundAt(widget.i),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: _actualHeight,
      duration: _duration,
      child: AnimatedOpacity(
        opacity: _detailDelay ? 1 : 0,
        duration: _duration,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if ((widget as EntryLoadout).loadout.ammo.isNotEmpty) ..._listLoadoutAmmo(),
            if ((widget as EntryLoadout).loadout.callers.isNotEmpty) ..._listLoadoutCallers(),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildEntry() {
    return Container(
      color: Utils.backgroundAt(widget.i),
      child: Column(
        children: [
          _buildRow(),
          _buildDetail(),
        ],
      ),
    );
  }
}
