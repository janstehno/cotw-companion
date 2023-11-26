// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityAbout extends StatelessWidget {
  final EdgeInsets _padding = const EdgeInsets.all(30);

  final double _footerHeight = 70;

  const ActivityAbout({
    Key? key,
  }) : super(key: key);

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
        primaryText: tr("language"),
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
        primaryText: tr("support"),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      "Русский",
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      "Vełeş",
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      "日本語",
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      "kuyokuyo",
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ]))
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      "Deutch",
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      "MorbusGon",
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      "Polski",
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      "KorneliooS",
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      "Français",
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      "BlocusEnergy",
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      "Magyar",
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      "Marcopolo",
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      "Türkçe",
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      "Ali Yahya Say",
                      style: Interface.s16w300n(Interface.dark),
                    )
                  ])),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      "Português (Brasil)",
                      style: Interface.s16w300n(Interface.disabled),
                    ),
                    Text(
                      "RECRUTA",
                      style: Interface.s16w300n(Interface.dark),
                    ),
                    Text(
                      "DI ÂNGELO",
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
        primaryText: tr("support_me"),
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
                background: Interface.darkBlue,
                onTap: () {
                  Utils.redirectTo("paypal.me", "/toastovac");
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
                      Utils.redirectTo("buymeacoffee.com", "/toastovac");
                    },
                  )),
              WidgetButtonIcon(
                buttonSize: 40,
                icon: "assets/graphics/icons/patreon.svg",
                color: Interface.alwaysDark,
                background: Interface.red,
                onTap: () {
                  Utils.redirectTo("patreon.com", "/Toastovac");
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
              height: _footerHeight,
              alignment: Alignment.center,
              color: Interface.title,
              child: SelectableText(
                Values.email,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Interface.s16w300n(Interface.dark),
              )))
    ]);
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr("about"),
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
