import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class EntryParameter extends StatelessWidget {
  final String text;
  final dynamic value;

  const EntryParameter({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  Widget buildValue() {
    return Text(
      value.toString(),
      style: Interface.s18w500n(Interface.dark),
    );
  }

  Widget _buildWidgets() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: AutoSizeText(
              text,
              style: Interface.s16w300n(Interface.dark),
            ),
          ),
        ),
        buildValue(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
