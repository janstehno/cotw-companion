// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
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
      WidgetTitleBig(
        primaryText: tr("about_paragraph_1_4"),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  tr("about_paragraph_1_1"),
                  style: Interface.s16w300n(Interface.dark),
                )),
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  tr("about_paragraph_1_2"),
                  style: Interface.s16w300n(Interface.dark),
                )),
            Text(
              tr("about_paragraph_1_3"),
              style: Interface.s16w300n(Interface.dark),
            ),
          ]))
    ]);
  }

  Widget _buildLanguage() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('language'),
      ),
      Container(
          padding: _padding,
          child: Text(
            tr("about_paragraph_3"),
            style: Interface.s16w300n(Interface.dark),
          ))
    ]);
  }

  Widget _buildSupport() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('support'),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      tr("translation_ru"),
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      tr("translation_ru_1"),
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      tr("translation_ja"),
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      tr("translation_ja_1"),
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ]))
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      tr("translation_de"),
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      tr("translation_de_1"),
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      tr("translation_pl"),
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      tr("translation_pl_1"),
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      tr("translation_fr"),
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      tr("translation_fr_1"),
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      tr("translation_hu"),
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      tr("translation_hu_1"),
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      tr("translation_tr"),
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      tr("translation_tr_1"),
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      tr("translation_pt"),
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      tr("translation_pt_1"),
                      style: Interface.s16w300n(Interface.dark),
                    ),
                    Text(
                      tr("translation_pt_2"),
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
            ])
          ]))
    ]);
  }

  Widget _buildDonate() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('support_me'),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Text(
                  tr("about_paragraph_2"),
                  style: Interface.s16w300n(Interface.dark),
                )),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              WidgetButtonIcon(
                buttonSize: 40,
                icon: "assets/graphics/icons/paypal.svg",
                color: Interface.alwaysLight,
                background: Interface.deepblue,
                onTap: () {
                  _redirectTo("paypal.me", "/toastovac");
                },
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: WidgetButtonIcon(
                    buttonSize: 40,
                    icon: "assets/graphics/icons/coffee.svg",
                    color: Interface.alwaysDark,
                    background: Interface.yellow,
                    onTap: () {
                      _redirectTo("buymeacoffee.com", "/toastovac");
                    },
                  )),
              WidgetButtonIcon(
                buttonSize: 40,
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
              height: 70,
              alignment: Alignment.center,
              color: Interface.title,
              child: SelectableText(
                _email,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Interface.s16w300n(Interface.dark),
              )))
    ]);
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('about'),
          context: context,
        ),
        body: Column(children: [
          _buildAbout(),
          _buildLanguage(),
          _buildSupport(),
          _buildDonate(),
          _buildFooter(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
