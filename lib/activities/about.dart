// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityAbout extends StatelessWidget {
  final EdgeInsets _padding = const EdgeInsets.all(30);
  final String _email = "toastovac@email.cz";
  final String _discord = "Toastovac";

  const ActivityAbout({
    Key? key,
  }) : super(key: key);

  void _redirectToPayPal() async {
    if (!await launchUrl(Uri(scheme: "https", host: "paypal.me", path: "/toastovac"))) {
      throw 'Unfortunately the link could not be launched. Please, go back or restart the application.';
    }
  }

  Widget _buildAbout() {
    return Column(children: [
      WidgetTitle(
        text: tr("about_paragraph_1_4"),
        textColor: Interface.light,
        background: Interface.dark,
        alignment: Alignment.center,
        textAlignment: TextAlign.center,
        maxLines: 2,
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(tr("about_paragraph_1_1"),
                    style: TextStyle(
                      color: Interface.dark,
                      fontSize: Interface.s20,
                      fontWeight: FontWeight.w400,
                    ))),
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(tr("about_paragraph_1_2"),
                    style: TextStyle(
                      color: Interface.dark,
                      fontSize: Interface.s20,
                      fontWeight: FontWeight.w400,
                    ))),
            Text(tr("about_paragraph_1_3"),
                style: TextStyle(
                  color: Interface.dark,
                  fontSize: Interface.s20,
                  fontWeight: FontWeight.w400,
                )),
          ]))
    ]);
  }

  Widget _buildLanguage() {
    return Column(children: [
      WidgetTitle(
        text: tr('language'),
      ),
      Container(
          padding: _padding,
          child: Text(tr("about_paragraph_3"),
              style: TextStyle(
                color: Interface.dark,
                fontSize: Interface.s20,
                fontWeight: FontWeight.w400,
              )))
    ]);
  }

  Widget _buildSupport() {
    return Column(children: [
      WidgetTitle(
        text: tr('support'),
      ),
      Container(
        padding: _padding,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Column(children: [
                  Text(tr("translation_ru"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s22,
                        fontWeight: FontWeight.w400,
                      )),
                  Text(tr("translation_ru_1"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w200,
                      ))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_ja"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s22,
                        fontWeight: FontWeight.w400,
                      )),
                  Text(tr("translation_ja_1"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w200,
                      ))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_de"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s22,
                        fontWeight: FontWeight.w400,
                      )),
                  Text(tr("translation_de_1"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w200,
                      ))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_pl"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s22,
                        fontWeight: FontWeight.w400,
                      )),
                  Text(tr("translation_pl_1"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w200,
                      ))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_fr"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s22,
                        fontWeight: FontWeight.w400,
                      )),
                  Text(tr("translation_fr_1"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w200,
                      ))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_pt"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s22,
                        fontWeight: FontWeight.w400,
                      )),
                  Text(tr("translation_pt_1"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w200,
                      )),
                  Text(tr("translation_pt_2"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w200,
                      ))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  Text(tr("translation_hu"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s22,
                        fontWeight: FontWeight.w400,
                      )),
                  Text(tr("translation_hu_1"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w200,
                      ))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 5),
                child: Column(children: [
                  Text(tr("translation_tr"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s22,
                        fontWeight: FontWeight.w400,
                      )),
                  Text(tr("translation_tr_1"),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w200,
                      ))
                ])),
          ],
        ),
      )
    ]);
  }

  Widget _buildDonate() {
    return Column(children: [
      WidgetTitle(
        text: tr('support_me'),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            Text(tr("about_paragraph_2"),
                style: TextStyle(
                  color: Interface.dark,
                  fontSize: Interface.s20,
                  fontWeight: FontWeight.w400,
                )),
            Container(
                width: 200,
                margin: const EdgeInsets.only(top: 30),
                child: WidgetButton(
                  text: tr('support_me').toUpperCase(),
                  color: Interface.accent,
                  background: Interface.primary,
                  onTap: () {
                    _redirectToPayPal();
                  },
                ))
          ]))
    ]);
  }

  Widget _buildFooter() {
    return Row(children: [
      Expanded(
          child: Container(
              padding: _padding,
              color: Interface.subTitleBackground,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          margin: const EdgeInsets.only(right: 7),
                          child: SvgPicture.asset(
                            "assets/graphics/icons/discord.svg",
                            color: Interface.dark,
                            width: 17,
                          )),
                      AutoSizeText(_discord,
                          maxLines: 1,
                          style: TextStyle(
                            color: Interface.dark,
                            fontSize: Interface.s20,
                            fontWeight: FontWeight.w400,
                          ))
                    ])),
                Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                      margin: const EdgeInsets.only(right: 7),
                      child: SvgPicture.asset(
                        "assets/graphics/icons/post.svg",
                        color: Interface.dark,
                        width: 17,
                      )),
                  AutoSizeText(_email,
                      maxLines: 1,
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s20,
                        fontWeight: FontWeight.w400,
                      ))
                ])
              ])))
    ]);
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('about'),
          color: Interface.accent,
          background: Interface.primary,
          fontSize: Interface.s30,
          context: context,
        ),
        children: [
          _buildAbout(),
          _buildLanguage(),
          _buildSupport(),
          _buildDonate(),
          _buildFooter(),
        ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
