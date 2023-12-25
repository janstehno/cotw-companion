// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityAbout extends StatelessWidget {
  final EdgeInsets _padding = const EdgeInsets.all(30);

  const ActivityAbout({
    Key? key,
  }) : super(key: key);

  Widget _buildAbout() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("not_official"),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  tr("about_first_things_first"),
                  style: Interface.s16w300n(Interface.dark),
                )),
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  tr("about_maps"),
                  style: Interface.s16w300n(Interface.dark),
                )),
            Text(
              tr("about_user_interface"),
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
            tr("about_language"),
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
                  tr("about_support"),
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

  Widget _buildFooterLine(String icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(right: 5),
            child: SvgPicture.asset(
              "assets/graphics/icons/$icon.svg",
              fit: BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(
                Interface.dark,
                BlendMode.srcIn,
              ),
            )),
        SelectableText(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: Interface.s16w300n(Interface.dark),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(children: [
      Expanded(
          child: Container(
              padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
              alignment: Alignment.center,
              color: Interface.title,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFooterLine("post", Values.email),
                  _buildFooterLine("discord", Values.discord),
                ],
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
