import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap.dart';

class WidgetReserveCaller extends WidgetSectionIndicatorTap {
  WidgetReserveCaller(
    Caller caller, {
    super.key,
    super.color,
    super.indicatorColor,
    super.background,
    required super.isShown,
    required super.onTap,
  }) : super(caller.name, indicatorSize: Values.dotSize);
}
