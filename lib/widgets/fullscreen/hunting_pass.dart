import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/exportable/hunting_pass.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetHuntingPass extends StatelessWidget {
  final HuntingPass _huntingPass;

  const WidgetHuntingPass({
    super.key,
    required HuntingPass huntingPass,
  }) : _huntingPass = huntingPass;

  Widget _buildItem(String icon, Translatable? item, bool? dlc) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WidgetIcon.withSize(
              icon,
              size: Values.indicatorSize,
              color: item == null ? Interface.disabled : Interface.dark,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: WidgetText(
                item != null ? item.name : tr("ANY"),
                color: item == null ? Interface.disabled : Interface.dark,
                style: Style.normal.s16.w300,
              ),
            ),
            if (dlc ?? false) ...[
              const SizedBox(width: 15),
              Container(
                width: Values.indicatorSize * 1.7,
                height: Values.indicatorSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Interface.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: WidgetIcon(
                  Assets.graphics.icons.dlc,
                  color: Interface.alwaysDark,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDistance(BuildContext context) {
    bool imperials = Provider.of<Settings>(context, listen: false).imperialUnits;
    String finalText =
        _huntingPass.distance != null ? "${_huntingPass.distance}${imperials ? tr("YARDS") : tr("METERS")}" : tr("ANY");
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WidgetIcon.withSize(
              Assets.graphics.icons.range,
              size: Values.indicatorSize,
              color: _huntingPass.distance == null ? Interface.disabled : Interface.dark,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: WidgetText(
                finalText,
                color: _huntingPass.distance == null ? Interface.disabled : Interface.dark,
                style: Style.normal.s16.w300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildAllowed(String icon, String text, bool? allowed) {
    return Container(
      height: Values.indicatorSize + 15,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          WidgetIcon(
            icon,
            color: allowed == null ? Interface.disabled : Interface.dark,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: WidgetText(
              tr(text),
              color: allowed == null ? Interface.disabled : Interface.dark,
              style: Style.normal.s16.w300,
            ),
          ),
          const SizedBox(width: 15),
          if (allowed != null)
            WidgetIcon.withSize(
              allowed ? Assets.graphics.icons.todo : Assets.graphics.icons.optional,
              size: Values.indicatorSize - 3,
              color: allowed ? Interface.green : Interface.red,
            ),
        ],
      ),
    );
  }

  List<Widget> _listAllowed() {
    return [
      _buildAllowed(Assets.graphics.icons.dog, "PASS_DOG", _huntingPass.allowedDog),
      _buildAllowed(Assets.graphics.icons.caller, "CALLERS", _huntingPass.allowedCallers),
      _buildAllowed(Assets.graphics.icons.scope, "PASS_SCOPES", _huntingPass.allowedScopes),
      _buildAllowed(Assets.graphics.icons.atv, "PASS_ATV", _huntingPass.allowedAtv),
      _buildAllowed(Assets.graphics.icons.hide, "PASS_STRUCTURES", _huntingPass.allowedStructures),
      _buildAllowed(Assets.graphics.icons.export, "PASS_FAST_TRAVEL", _huntingPass.allowedFastTravel),
      _buildAllowed(Assets.graphics.icons.environmentSummer, "PASS_DAY_TIME", _huntingPass.allowedDayTime),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    double huntingPassHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - Values.appBar - Values.menuBar;

    return SizedBox(
      height: huntingPassHeight,
      child: WidgetPadding.a30(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildItem(Assets.graphics.icons.reserve, _huntingPass.reserve, _huntingPass.reserve?.isFromDlc),
            _buildItem(Assets.graphics.icons.wildlife, _huntingPass.animal, _huntingPass.animal?.isFromDlc),
            _buildItem(Assets.graphics.icons.weapon, _huntingPass.weapon, _huntingPass.weapon?.isFromDlc),
            _buildItem(Assets.graphics.icons.loadout, _huntingPass.ammo, false),
            _buildDistance(context),
            const SizedBox(height: 15),
            ..._listAllowed(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
