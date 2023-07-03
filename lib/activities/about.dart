// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityAbout extends StatelessWidget {
  final EdgeInsets _padding = const EdgeInsets.all(30);
  final String _email = "toastovac@email.cz";

  const ActivityAbout({
    Key? key,
  }) : super(key: key);

  void _redirectTo(String host, String path) async {
    if (!await launchUrl(Uri(scheme: "https", host: host, path: path), mode: LaunchMode.externalApplication)) {
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
            Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Text(tr("about_paragraph_2"),
                    style: TextStyle(
                      color: Interface.dark,
                      fontSize: Interface.s20,
                      fontWeight: FontWeight.w400,
                    ))),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              WidgetButton(
                icon: "assets/graphics/icons/paypal.svg",
                color: Interface.alwaysLight,
                background: Interface.deepblue,
                onTap: () {
                  _redirectTo("paypal.me", "/toastovac");
                },
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: WidgetButton(
                    icon: "assets/graphics/icons/coffee.svg",
                    color: Interface.alwaysDark,
                    background: Interface.yellow,
                    onTap: () {
                      _redirectTo("buymeacoffee.com", "/toastovac");
                    },
                  )),
              WidgetButton(
                icon: "assets/graphics/icons/patreon.svg",
                color: Interface.alwaysDark,
                background: Interface.red,
                onTap: () {
                  _redirectTo("patreon.com", "/Toastovac");
                },
              )
            ])
          ]))
    ]);
  }

  Widget _buildFooter() {
    return Row(children: [
      Expanded(
          child: Container(
              padding: _padding,
              color: Interface.subTitleBackground,
              child: SelectableText(_email,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s20,
                    fontWeight: FontWeight.w400,
                  ))))
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
