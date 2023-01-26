// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_patch_note.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityPatchNotes extends StatelessWidget {
  const ActivityPatchNotes({Key? key}) : super(key: key);

  void _redirectToTrello() async {
    if (!await launchUrl(Uri(scheme: "https", host: "github.com", path: "/janstehno/cotwcompanion/issues"))) {
      throw 'Unfortunately the link could not be launched. Please, go back or restart the application.';
    }
  }

  Widget _buildLink() {
    return GestureDetector(
        onTap: () {
          _redirectToTrello();
        },
        child: Container(
            padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
            color: Color(Values.colorSearchBackground),
            alignment: Alignment.centerRight,
            child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: AutoSizeText(tr('issues_and_plans'),
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Color(Values.colorSearch), fontSize: Values.fontSize20, fontWeight: FontWeight.w800)))),
              SvgPicture.asset("assets/graphics/icons/external_link.svg", width: 15, height: 15, color: Color(Values.colorSearch))
            ])));
  }

  Widget _buildList() {
    return Column(children: [
      EntryPatchNote(color: Values.colorOdd, version: "1.5.5", changes: const [
        "- Improvement of the Loadouts. Loadouts can be edited now."
      ]),
      EntryPatchNote(color: Values.colorEven, version: "1.5.2 - 1.5.4"),
      EntryPatchNote(
        color: Values.colorOdd,
        version: "1.5.1",
        changes: const ["- New England Mountains update."],
      ),
      EntryPatchNote(color: Values.colorEven, version: "1.5.0", changes: const [
        "- Improvement of the Catch book and Trophy lodge. Fixed few problems when creating a record.",
        "- Changed word values (mostly from rare to uncommon) of furs for almost every animal. Per cent values remained the same."
      ]),
      EntryPatchNote(
        color: Values.colorOdd,
        version: "1.4.9",
        changes: const ["- Turkish language."],
      ),
      EntryPatchNote(color: Values.colorEven, version: "1.4.8"),
      EntryPatchNote(color: Values.colorOdd, version: "1.4.7", changes: const ["- Improvement of the UI. Added back button for each page."]),
      EntryPatchNote(
        color: Values.colorPrimary,
        version: "1.4.6",
        changes: const ["- App released for iOS, available in the App Store."],
      ),
      EntryPatchNote(color: Values.colorOdd, version: "1.4.5", changes: const [
        "- Assorted Sidearms Pack update.",
        "- Improvement of the UI. You can now switch between dots and circles in the maps.",
        "- Catch book and Trophy lodge now shows corrupted logs. Corrupted log is a log that has incorrect value/s. For now they will be invisible but saved. I am working on a feature which will help you fix them and therefore show them in the list."
      ]),
      EntryPatchNote(color: Values.colorEven, version: "1.4.4"),
      EntryPatchNote(color: Values.colorOdd, version: "1.4.3", changes: const [
        "- Improvement of the UI. You can now show the details of the loadout by single tapping it. Select loadout by tapping the button beside its name."
      ]),
      EntryPatchNote(color: Values.colorEven, version: "1.4.2"),
      EntryPatchNote(color: Values.colorOdd, version: "1.4.1", changes: const [
        "- Loadouts feature. Uneditable for now, you will have to create a new loadout. You will have to select a loadout every time you start up the application. Use double tap for the deletion.",
        "- Improvement of the UI. Compact view for Need zones feature. Maximum items per screen is 10, works only in portrait mode."
      ]),
      EntryPatchNote(color: Values.colorEven, version: "1.4.0", changes: const [
        "- Revontuli Coast update.",
        "- Improvement of the UI. As there is very low variety in ammo for shotguns, bows, and crossbows, animal's recommended weapons of these types now show as an ammo instead of a weapon."
      ]),
      EntryPatchNote(
          color: Values.colorOdd,
          version: "1.3.9",
          changes: const ["- Improvement of the Catch book and Trophy lodge. They are loaded separately now."]),
      EntryPatchNote(color: Values.colorEven, version: "1.3.8"),
      EntryPatchNote(color: Values.colorOdd, version: "1.3.7"),
      EntryPatchNote(color: Values.colorEven, version: "1.3.6", changes: const [
        "- Improvement of the Catch book and Trophy lodge. Added Export / Import feature.",
        "- Catch book record can now be created from Need Zones feature and Reserve's animal list. You can create it by swiping the list item to the right.",
        "- Patch Notes feature. Only in English for now. Link on Trello website with future plans and issues of the newest version of the app.",
        "- Improvement of the UI. Overhauled have been map zones (some zones can overlap) and various icons. Animal's images have been added including their anatomy. Filter for animal's recommended weapons in the settings. It chooses the weapons based on the highest minimum class and the greatest penetration. If possible at least one weapon is chosen from the base game and at least one is chosen from DLC."
      ]),
      EntryPatchNote(color: Values.colorOdd, version: "1.3.5"),
      EntryPatchNote(
          color: Values.colorEven, version: "1.3.4", changes: const ["- Improvement of the Catch book and Trophy lodge.", "- Great Ones added."]),
      EntryPatchNote(color: Values.colorOdd, version: "1.3.3"),
      EntryPatchNote(color: Values.colorEven, version: "1.3.2", changes: const ["- Trophy lodge feature.", "- Japanese language."]),
      EntryPatchNote(
          color: Values.colorOdd,
          version: "1.3.1",
          changes: const ["- Modern Rifle Pack update.", "- Catch book feature.", "- Improvement of the UI. Percentage chance for fur types."]),
      EntryPatchNote(
          color: Values.colorPrimary,
          version: "1.3.0",
          changes: const ["- Migration of the whole app to the new programming environment.", "- App re-released for Android. App should be also releasable for iOS."]),
      EntryPatchNote(color: Values.colorOdd, version: "1.2.9"),
      EntryPatchNote(color: Values.colorEven, version: "1.2.8", changes: const ["- Improvement of the landscape UI."]),
      EntryPatchNote(
          color: Values.colorOdd,
          version: "1.2.7",
          changes: const ["- Improvement of the UI. Need zones are changing over time. Improvement for colorblind users."]),
      EntryPatchNote(color: Values.colorEven, version: "1.2.6"),
      EntryPatchNote(color: Values.colorOdd, version: "1.2.5", changes: const ["- Mississippi Acres Preserve update."]),
      EntryPatchNote(color: Values.colorEven, version: "1.2.4"),
      EntryPatchNote(color: Values.colorOdd, version: "1.2.3", changes: const ["- Improvement of the UI. Dark mode now persists."]),
      EntryPatchNote(color: Values.colorEven, version: "1.2.2"),
      EntryPatchNote(color: Values.colorOdd, version: "1.2.1"),
      EntryPatchNote(color: Values.colorEven, version: "1.2.0", changes: const ["- Rancho Del Arroyo update."]),
      EntryPatchNote(color: Values.colorOdd, version: "1.1.4 - 1.1.9"),
      EntryPatchNote(
          color: Values.colorEven,
          version: "1.1.3",
          changes: const ["- Improvement of the UI. Need zones are changing based on set time. Temporary dark mode."]),
      EntryPatchNote(color: Values.colorOdd, version: "1.1.2"),
      EntryPatchNote(color: Values.colorEven, version: "1.1.1", changes: const ["- Improvement of the UI. Language option in the settings."]),
      EntryPatchNote(color: Values.colorOdd, version: "1.1.0", changes: const [
        "- Fur rarity for each animal.",
        "- Information about ammunition.",
        "- Portuguese language.",
        "- Improvement of the UI. Need zones for animals are now separate for each reserve."
      ]),
      EntryPatchNote(color: Values.colorEven, version: "1.0.9"),
      EntryPatchNote(color: Values.colorOdd, version: "1.0.8"),
      EntryPatchNote(color: Values.colorEven, version: "1.0.7"),
      EntryPatchNote(
          color: Values.colorOdd,
          version: "1.0.6",
          changes: const ["- Improvement of the UI. Added class of the animals and recommended callers for each reserve. Useful when you are preparing for the hunt."]),
      EntryPatchNote(color: Values.colorEven, version: "1.0.5", changes: const ["- Te Awaroa National Park update."]),
      EntryPatchNote(color: Values.colorOdd, version: "1.0.4", changes: const ["- Information about callers."]),
      EntryPatchNote(color: Values.colorEven, version: "1.0.3"),
      EntryPatchNote(color: Values.colorOdd, version: "1.0.2", changes: const ["- Information about weapons."]),
      EntryPatchNote(color: Values.colorEven, version: "1.0.1"),
      EntryPatchNote(color: Values.colorPrimary, version: "1.0.0", changes: const [
        "- 27. 11. 2020",
        "- Information about animals.",
        "- Semi-working maps.",
        "- English, Czech, Russian, Polish, German, France, and Spanish language."
      ])
    ]);
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('patch_notes'),
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
        children: [_buildLink(), _buildList()]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets(context);
  }
}
