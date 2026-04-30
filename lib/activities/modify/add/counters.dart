import 'package:cotwcompanion/activities/modify/modify.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/enumerator.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/text/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:cotwcompanion/widgets/title/title_button_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityAddCounters extends ActivityModify {
  final HelperEnumerator _helperEnumerator;
  final Enumerator _enumerator;

  const ActivityAddCounters({
    super.key,
    super.type = ModifyType.add,
    required HelperEnumerator helperEnumerator,
    required Enumerator enumerator,
    required super.onSuccess,
  })  : _helperEnumerator = helperEnumerator,
        _enumerator = enumerator;

  Enumerator get enumerator => _enumerator;

  HelperEnumerator get helperEnumerator => _helperEnumerator;

  @override
  State<StatefulWidget> createState() => ActivityAddCountersState();
}

class ActivityAddCountersState extends ActivityModifyState {
  final TextEditingController textController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  int color = 0;
  int icon = 0;

  @override
  void initState() {
    textController.addListener(() => updateIndicatorOf(textController));
    super.initState();
  }

  Widget buildValue() {
    return Column(
      children: [
        WidgetTitle(tr("COUNT")),
        WidgetTextFieldIndicator(
          icon: Assets.graphics.icons.number,
          numberOnly: true,
          decimal: false,
          noIndicator: true,
          textController: valueController,
        )
      ],
    );
  }

  Widget buildColor() {
    return Column(
      children: [
        WidgetTitleButtonIcon(
          tr("COLOR"),
          icon: Assets.graphics.icons.zoneNothing,
          alignRight: true,
          buttonColor: Interface.dark,
          buttonBackground: Interface.title,
          onTap: () {
            setState(() {
              color = 0;
            });
          },
        ),
        WidgetPadding.h30v20(
          alignment: Alignment.center,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: CounterColor.values
                .where((v) => v.id > 0)
                .map(
                  (cc) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: cc.id == 0 ? Interface.shadow : Interface.transparent),
                      borderRadius: BorderRadius.circular(Values.tapSize / 4),
                    ),
                    child: WidgetButtonIcon(
                      cc.id == color ? Assets.graphics.icons.accept : Assets.graphics.icons.placeholder,
                      color: cc.id == color ? cc.color : Interface.transparent,
                      background: cc.background,
                      onTap: () {
                        setState(() {
                          color = cc.id;
                        });
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildIcon() {
    return Column(
      children: [
        WidgetTitleButtonIcon(
          tr("ICON"),
          icon: Assets.graphics.icons.zoneNothing,
          alignRight: true,
          buttonColor: Interface.dark,
          buttonBackground: Interface.title,
          onTap: () {
            setState(() {
              icon = 0;
            });
          },
        ),
        WidgetPadding.h30v20(
          alignment: Alignment.center,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: CounterIcon.values
                .where((v) => v.id > 0)
                .map(
                  (ci) => WidgetButtonIcon(
                    ci.asset,
                    color: ci.id == icon ? Interface.alwaysDark : Interface.dark,
                    background: ci.id == icon ? Interface.primary : Interface.light,
                    onTap: () {
                      setState(() {
                        icon = ci.id;
                      });
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Counter get _newCounter {
    return Counter(
      order: (widget as ActivityAddCounters).enumerator.counters.length,
      name: textController.text,
      value: int.tryParse(valueController.text) ?? 0,
      color: color,
      icon: icon,
    );
  }

  void onSuccess() {
    (widget as ActivityAddCounters).enumerator.addCounter(_newCounter);
    (widget as ActivityAddCounters).helperEnumerator.save();
  }

  @override
  void onConfirm() {
    if (errorMessage.isEmpty) {
      onSuccess();
      widget.onSuccess();
      Navigator.pop(context);
    } else {
      Utils.buildSnackBarMessage(
        errorMessage,
        Process.error,
        context,
      );
    }
  }

  @override
  Widget buildBody() {
    return Column(
      children: [
        buildName(correctName, textController),
        buildValue(),
        buildColor(),
        buildIcon(),
      ],
    );
  }
}
