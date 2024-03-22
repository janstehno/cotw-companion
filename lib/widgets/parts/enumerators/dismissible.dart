import 'package:cotwcompanion/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:cotwcompanion/widgets/parts/dismissible.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class WidgetEnumeratorDismissible extends WidgetDismissible {
  final Enumerator _enumerator;
  final HelperEnumerator _helperEnumerator;

  const WidgetEnumeratorDismissible(
    super.i, {
    super.key,
    required Enumerator enumerator,
    required HelperEnumerator helperEnumerator,
    required super.callback,
    required super.context,
  })  : _enumerator = enumerator,
        _helperEnumerator = helperEnumerator;

  Enumerator get enumerator => _enumerator;

  HelperEnumerator get helperEnumerator => _helperEnumerator;
}

abstract class WidgetEnumeratorEntryState extends WidgetDismissibleState {
  @override
  void endToStart() {
    Utils.buildSnackBarUndo(
      tr("ITEM_REMOVED"),
      Process.info,
      undo,
      widget.context,
    );
  }
}
