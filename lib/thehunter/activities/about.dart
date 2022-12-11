// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityAbout extends StatelessWidget {
  final String version;
  final String email = "toastovac@email.cz";
  final String discord = "Toastovac#0289";

  const ActivityAbout({Key? key, required this.version}) : super(key: key);

  void _redirectToPayPal() async {
    if (!await launchUrl(Uri(scheme: "https", host: "paypal.me", path: "/toastovac"))) {
      throw 'Unfortunately the link could not be launched. Please, go back or restart the application.';
    }
  }

  Widget _buildAbout() {
    return WidgetContainer(
        child: Column(children: [
      Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Text(tr("about_paragraph_1_1"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400))),
      Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Text(tr("about_paragraph_1_2"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400))),
      Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Text(tr("about_paragraph_1_3"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400))),
      Text(tr("about_paragraph_1_4"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)),
    ]));
  }

  Widget _buildLanguage() {
    return Column(children: [
      WidgetTitle.sub(text: tr('language')),
      WidgetContainer(child: Text(tr("about_paragraph_3"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))
    ]);
  }

  Widget _buildSupport() {
    return Column(children: [
      WidgetTitle.sub(text: tr('support')),
      WidgetContainer(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Column(children: [
                  Text(tr("translation_ru"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize22, fontWeight: FontWeight.w400)),
                  Text(tr("translation_ru_1"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w200))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_ja"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize22, fontWeight: FontWeight.w400)),
                  Text(tr("translation_ja_1"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w200))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_de"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize22, fontWeight: FontWeight.w400)),
                  Text(tr("translation_de_1"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w200))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_pl"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize22, fontWeight: FontWeight.w400)),
                  Text(tr("translation_pl_1"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w200))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_fr"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize22, fontWeight: FontWeight.w400)),
                  Text(tr("translation_fr_1"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w200))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_pt"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize22, fontWeight: FontWeight.w400)),
                  Text(tr("translation_pt_1"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w200)),
                  Text(tr("translation_pt_2"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w200))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5),
                child: Column(children: [
                  Text(tr("translation_tr"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize22, fontWeight: FontWeight.w400)),
                  Text(tr("translation_tr_1"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w200))
                ])),
          ],
        ),
      )
    ]);
  }

  Widget _buildDonate() {
    return Column(children: [
      WidgetTitle.sub(text: tr('support_me')),
      WidgetContainer(
          child: Column(children: [
        Text(tr("about_paragraph_2"), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)),
        Container(
            width: 200,
            margin: const EdgeInsets.only(top: 30),
            child: WidgetButton(
                background: Values.colorPrimary,
                color: Values.colorAccent,
                onTap: () {
                  _redirectToPayPal();
                },
                text: tr('support_me')))
      ]))
    ]);
  }

  Widget _buildFooter() {
    return Container(
        color: Color(Values.colorContentSubTitleBackground),
        child: WidgetContainer(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AutoSizeText("${tr('version')} $version",
              maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)),
          AutoSizeText("Email: $email",
              maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)),
          AutoSizeText("Discord: $discord",
              maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400))
        ])));
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('about'),
          height: 90,
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize30,
          fontWeight: FontWeight.w700,
          alignment: Alignment.centerRight,
          function: () {
            Navigator.pop(context);
          },
        ),
        children: [_buildAbout(), _buildLanguage(), _buildSupport(), _buildDonate(), _buildFooter()]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets(context);
  }
}
