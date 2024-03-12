// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/edit/enumerators.dart';
import 'package:cotwcompanion/activities/entries/counters.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/entries/enumerators/entry.dart';
import 'package:flutter/material.dart';

class EntryEnumerator extends EntryEnumeratorEntry {
  final HelperEnumerator helperEnumerator;

  const EntryEnumerator({
    super.key,
    required super.index,
    required super.enumerator,
    required super.callback,
    required super.context,
    required this.helperEnumerator,
  });

  @override
  State<StatefulWidget> createState() => EntryEnumeratorState();
}

class EntryEnumeratorState extends EntryEnumeratorEntryState {
  late final HelperEnumerator _helperEnumerator;

  @override
  void initState() {
    _helperEnumerator = (widget as EntryEnumerator).helperEnumerator;
    super.initState();
  }

  @override
  void onTap() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityCounters(enumeratorId: widget.enumerator.id, helperEnumerator: _helperEnumerator)));
    widget.callback();
  }

  @override
  void startToEnd() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ActivityEditEnumerators(helperEnumerator: _helperEnumerator, enumerator: widget.enumerator, callback: widget.callback)));
  }

  @override
  void endToStart() {
    setState(() {
      _helperEnumerator.removeEnumeratorOnIndex(widget.index);
      widget.callback();
    });
    super.endToStart();
  }

  @override
  void undo() {
    _helperEnumerator.undoRemoveEnumerator();
    widget.callback();
  }

  @override
  Widget buildEntry() {
    return Row(
      children: [
        Expanded(
          child: AutoSizeText(
            widget.enumerator.name,
            maxLines: 1,
            style: Interface.s18w500n(Interface.dark),
          ),
        ),
      ],
    );
  }
}
