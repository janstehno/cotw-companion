import 'package:cotwcompanion/activities/entries/counters.dart';
import 'package:cotwcompanion/activities/modify/edit/enumerators.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/parts/enumerators/dismissible.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetEnumerator extends WidgetEnumeratorDismissible {
  const WidgetEnumerator(
    super.i, {
    super.key,
    required super.enumerator,
    required super.callback,
    required super.context,
    required super.helperEnumerator,
  });

  @override
  State<StatefulWidget> createState() => EntryEnumeratorState();
}

class EntryEnumeratorState extends WidgetEnumeratorEntryState {
  @override
  void onDoubleTap() => onTap();

  @override
  void onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => ActivityCounters(
            enumerator: (widget as WidgetEnumeratorDismissible).enumerator,
            helperEnumerator: (widget as WidgetEnumeratorDismissible).helperEnumerator),
      ),
    );
    if (widget.callback != null) widget.callback!();
  }

  @override
  void startToEnd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => ActivityEditEnumerators(
          (widget as WidgetEnumeratorDismissible).enumerator,
          helperEnumerator: (widget as WidgetEnumeratorDismissible).helperEnumerator,
          onSuccess: widget.callback ?? () {},
        ),
      ),
    );
  }

  @override
  void endToStart() {
    setState(() {
      (widget as WidgetEnumeratorDismissible)
          .helperEnumerator
          .removeEnumerator((widget as WidgetEnumeratorDismissible).enumerator);
      if (widget.callback != null) widget.callback!();
    });
    super.endToStart();
  }

  @override
  void undo() {
    (widget as WidgetEnumeratorDismissible).helperEnumerator.undoRemoveEnumerator();
    if (widget.callback != null) widget.callback!();
  }

  Widget _buildName() {
    return WidgetText(
      (widget as WidgetEnumeratorDismissible).enumerator.name,
      color: Interface.dark,
      style: Style.normal.s16.w300,
    );
  }

  @override
  Widget buildEntry() {
    return WidgetPadding.h30(child: Row(children: [Expanded(child: _buildName())]));
  }
}
