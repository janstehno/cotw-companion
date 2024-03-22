import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityAbout extends StatelessWidget {
  const ActivityAbout({
    super.key,
  });

  Widget _buildAbout(BuildContext context) {
    return WidgetPadding.a30(
      child: WidgetText(
        tr("ABOUT_APP"),
        color: Interface.dark,
        style: Style.normal.s16.w300,
        autoSize: false,
      ),
    );
  }

  List<Widget> _listLanguage() {
    return [
      WidgetTitle(tr("LANGUAGE")),
      WidgetPadding.a30(
        child: WidgetText(
          tr("ABOUT_LANGUAGE"),
          color: Interface.dark,
          style: Style.normal.s16.w300,
          autoSize: false,
        ),
      )
    ];
  }

  Widget _buildSupporterText(String text, bool left) {
    if (left) {
      return WidgetText(
        text,
        color: Interface.disabled,
        style: Style.normal.s12.w300,
      );
    }
    return WidgetText(
      text,
      color: Interface.dark,
      style: Style.normal.s16.w300,
    );
  }

  Widget _buildSupporterColumn(MapEntry entry, Supporter supporter) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _listSupportersColumns(entry.value, supporter),
    );
  }

  Widget _buildSupporter(MapEntry entry, Supporter supporter) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildSupporterText(entry.key, supporter == Supporter.translation)),
        const SizedBox(width: 10),
        _buildSupporterColumn(entry, supporter),
      ],
    );
  }

  List<Widget> _listSupportersColumns(List<String> names, Supporter supporter) {
    return names.map((e) => _buildSupporterText(e, supporter == Supporter.donation)).toList();
  }

  List<Widget> _listSupportersRows(Map<String, List<String>> supporters, Supporter supporter) {
    return supporters.entries.map((e) => _buildSupporter(e, supporter)).toList();
  }

  List<Widget> _listTranslationSupporters() {
    return [
      WidgetTitle(tr("TRANSLATION_SUPPORTERS")),
      WidgetPadding.a30(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: _listSupportersRows(Values.translationSupporters, Supporter.translation),
        ),
      ),
    ];
  }

  List<Widget> _listDonationPlatforms() {
    return [
      WidgetButtonIcon(
        Assets.graphics.icons.paypal,
        color: Interface.alwaysDark,
        background: Interface.primary,
        onTap: () => Utils.redirectTo(Uri.parse("https://paypal.me/toastovac")),
      ),
      WidgetButtonIcon(
        Assets.graphics.icons.coffee,
        color: Interface.alwaysDark,
        background: Interface.primary,
        onTap: () => Utils.redirectTo(Uri.parse("https://buymeacoffee.com/toastovac")),
      ),
      WidgetButtonIcon(
        Assets.graphics.icons.patreon,
        color: Interface.alwaysDark,
        background: Interface.primary,
        onTap: () => Utils.redirectTo(Uri.parse("https://patreon.com/Toastovac")),
      ),
    ];
  }

  List<Widget> _listDonation() {
    return [
      WidgetTitle(tr("DONATION")),
      WidgetPadding.a30(
        child: Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            WidgetText(
              tr("ABOUT_DONATION"),
              color: Interface.dark,
              style: Style.normal.s16.w300,
              autoSize: false,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: _listDonationPlatforms(),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _listDonationSupporters() {
    return [
      WidgetTitle(tr("DONATION_SUPPORTERS")),
      WidgetPadding.a30(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: _listSupportersRows(Values.donationSupporters, Supporter.donation),
        ),
      ),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr("ABOUT"),
        context: context,
      ),
      children: [
        _buildAbout(context),
        ..._listLanguage(),
        ..._listDonation(),
        ..._listTranslationSupporters(),
        ..._listDonationSupporters(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
