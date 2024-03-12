// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/edit/counters.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:cotwcompanion/widgets/entries/enumerators/entry.dart';
import 'package:flutter/material.dart';

class EntryCounter extends EntryEnumeratorEntry {
  final HelperEnumerator helperEnumerator;
  final Counter counter;

  const EntryCounter({
    super.key,
    required super.index,
    required super.enumerator,
    required super.callback,
    required super.context,
    required this.helperEnumerator,
    required this.counter,
  });

  @override
  State<StatefulWidget> createState() => EntryCounterState();
}

class EntryCounterState extends EntryEnumeratorEntryState {
  late final HelperEnumerator _helperEnumerator;
  late final Counter _counter;

  @override
  void initState() {
    _helperEnumerator = (widget as EntryCounter).helperEnumerator;
    _counter = (widget as EntryCounter).counter;
    super.initState();
  }

  @override
  void startToEnd() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ActivityEditCounters(helperEnumerator: _helperEnumerator, enumeratorId: widget.enumerator.id, counter: _counter, callback: widget.callback)));
  }

  @override
  void onTap() {
    setState(() {
      _counter.add();
      _helperEnumerator.writeFile();
      widget.callback();
    });
  }

  @override
  void onDoubleTap() {
    setState(() {
      _counter.subtract();
      _helperEnumerator.writeFile();
      widget.callback();
    });
  }

  @override
  void endToStart() {
    setState(() {
      _helperEnumerator.removeCounterOnIndex(widget.enumerator.id, widget.index);
      widget.callback();
    });
    super.endToStart();
  }

  @override
  void undo() {
    _helperEnumerator.undoRemoveCounter(widget.enumerator.id);
    widget.callback();
  }

  @override
  Widget buildEntry() {
    return Row(
      children: [
        Expanded(
          child: AutoSizeText(
            _counter.name,
            maxLines: 2,
            style: Interface.s18w500n(Interface.dark),
          ),
        ),
        AutoSizeText(
          _counter.value.toString(),
          maxLines: 1,
          style: Interface.s22w400n(Interface.dark),
        )
      ],
    );
  }
}
