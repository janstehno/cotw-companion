import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/button/button_text_icon.dart';

class WidgetButtonLink extends WidgetButtonTextIcon {
  final bool _small;

  WidgetButtonLink(
    super.text, {
    super.key,
    super.color,
    super.background,
    required super.onTap,
    bool? small,
  })  : _small = small ?? true,
        super(
          icon: Assets.graphics.icons.link,
          textStyle: Style.normal.s10.w500,
          iconSize: 10,
        );

  @override
  double get buttonHeight => _small ? Values.smallTag : Values.tapSize;
}
