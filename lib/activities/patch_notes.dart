// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/patch_note.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityPatchNotes extends StatelessWidget {
  const ActivityPatchNotes({
    Key? key,
  }) : super(key: key);

  Widget _buildList() {
    return Column(children: [
      WidgetPatchNote(
        background: Interface.even,
        version: "1.9.6",
        changes: const [
          "- Chinese language",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.9.1 - 1.9.5",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.9.0",
        changes: const [
          "- New Year update.",
          "- New features, improvements of the UI, and other fixes.",
          "- Planner for skills and perks was added. It works like the one in the game. You can also set your current level. Perks and skills are only translated to English and Czech.",
          "- Missions for each reserve were added. You can find them under the list of callers in reserve's detailed info. Difficulty of mission is subjective and can always be changed. Missions are only translated to English and Czech.",
          "- Counters were added. You can create any number of counter groups (for each reserve or animal for example). Each counter group can contain any number of counters.",
          "- Matmat's multi trophy mounts were added. You can see what multi mounts you can assemble based on saved harvests in the Trophy lodge.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.8.6 - 1.8.9",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.8.5",
        changes: const [
          "- Improvement of the UI. You can now choose, where the file with all your harvests will be saved to / loaded from. Permission is still needed, otherwise the app will not be able to save or load the file."
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.8.3 - 1.8.4",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.8.2",
        changes: const [
          "- Improvement of the UI. Introduced map performance mode. Should let users to choose between estimated and exact positions of need zones. More on this in the map info section. I would appreciate some feedback for sure."
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.8.1",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.8.0",
        changes: const ["- Improvement of the UI. Minor changes to the home screen. Added fast search. Contains reserves, animals, furs, weapons, ammo, and callers."],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.7.9",
        changes: const ["- Ambusher Pack update."],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.7.8",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.7.7",
        changes: const ["- Improvement of the UI. Added new statistics for recorded harvests. Suggestions for other stats are more then welcome."],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.7.4 - 1.7.6",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.7.3",
        changes: const ["- Improvement of the UI. Added filter option for general lists. Suggestions for other filters are more then welcome."],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.7.2",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.7.1",
        changes: const ["- Improvement of the UI. Mostly minor changes."],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.6.8 - 1.7.0",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.6.7",
        changes: const ["- Added option to set whatever trophy rating when creating logs. Already created logs will stay the same unless manually changed."],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.6.6",
        changes: const [
          "- Emerald Coast Australia update.",
          "- Improvement of the UI. Changed class filter in the Need zones feature. Changed time progression to better reflect the in-game one. Added bird tag for animals that should be downed while flying for full trophy rating. Added female tag for animals who make diamond as females only.",
          "- Added help section for maps. Explains how the feature works and what can be shown on the map.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.6.5",
        changes: const [
          "- Improvement of the UI. Need zones feature now shows what zone animal has at, and will have after the current and next hour. There is now also a slider to filter animals based on their class.",
          "- Added filter for the Weapons. You can now filter weapons by their type. E.g. typing 'shotgun' in the search box will filter out everything but shotguns."
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.6.2 - 1.6.4",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.6.1",
        changes: const [
          "- Improvement of the UI. Added scrollbars.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.6.0",
        changes: const [
          "- Improvement of the UI. Maps were reworked due to performance issues. Keep in mind that there could still appear some even after the change.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.5.9",
        changes: const [
          "- Hunter Power Pack update.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.5.8",
        changes: const [
          "- Improvement of the UI. Added zoom feature for maps. As well as new background. There could appear some performance issues.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.5.7",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.5.6",
        changes: const [
          "- Hungarian language.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.5.5",
        changes: const [
          "- Improvement of the UI. Loadouts can be edited now.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.5.2 - 1.5.4",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.5.1",
        changes: const [
          "- New England Mountains update.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.5.0",
        changes: const [
          "- Improvement of the UI. Fixed few problems when creating a record in Catch book and Trophy lodge.",
          "- Changed word values (mostly from rare to uncommon) of furs for almost every animal. Per cent values remained the same.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.4.9",
        changes: const [
          "- Turkish language.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.4.8",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.4.7",
        changes: const [
          "- Improvement of the UI. Added back button for each page.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.4.6",
        changes: const [
          "- App released for iOS, available in the App Store.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.4.5",
        changes: const [
          "- Assorted Sidearms Pack update.",
          "- Improvement of the UI. You can now switch between dots and circles in the maps.",
          "- Catch book and Trophy lodge now shows corrupted logs. Corrupted log is a log that has incorrect value/s. For now they will be invisible but saved. I am working on a feature which will help you fix them and therefore show them in the list.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.4.4",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.4.3",
        changes: const [
          "- Improvement of the UI. You can now show the details of the loadout by single tapping it. Select loadout by tapping the button beside its name.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.4.2",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.4.1",
        changes: const [
          "- Loadouts feature. Uneditable for now, you will have to create a new loadout. You will have to select a loadout every time you start up the application. Use double tap for the deletion.",
          "- Improvement of the UI. Compact view for Need zones feature. Maximum items per screen is 10, works only in portrait mode.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.4.0",
        changes: const [
          "- Revontuli Coast update.",
          "- Improvement of the UI. As there is very low variety in ammo for shotguns, bows, and crossbows, animal's recommended weapons of these types now show as an ammo instead of a weapon.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.3.9",
        changes: const [
          "- Improvement of the UI. Catch book and Trophy lodge features are loaded separately now.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.3.8",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.3.7",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.3.6",
        changes: const [
          "- Improvement of the UI. Added Export / Import feature for Catch book and Trophy lodge feature.",
          "- Catch book record can now be created from Need Zones feature and Reserve's animal list. You can create it by swiping the list item to the right.",
          "- Patch Notes feature. Only in English for now. Link on GitHub website with future plans and issues of the newest version of the app.",
          "- Improvement of the UI. Overhauled have been map zones (some zones can overlap) and various icons. Animal's images have been added including their anatomy.",
          "- Filter for animal's recommended weapons in the settings. It chooses the weapons based on the highest minimum class and the greatest penetration. If possible at least one weapon is chosen from the base game and at least one is chosen from DLC.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.3.5",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.3.4",
        changes: const [
          "- Improvement of the UI. Especially of the Catch book and Trophy lodge feature.",
          "- Great Ones added.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.3.3",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.3.2",
        changes: const [
          "- Trophy lodge feature.",
          "- Japanese language.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.3.1",
        changes: const [
          "- Modern Rifle Pack update.",
          "- Catch book feature.",
          "- Improvement of the UI. Percentage chance for fur types.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.3.0",
        changes: const [
          "- Migration of the whole app to the new programming environment.",
          "- App re-released for Android. App should be also releasable for iOS.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.2.9",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.2.8",
        changes: const [
          "- Improvement of the UI. Mostly of landscape view.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.2.7",
        changes: const [
          "- Improvement of the UI. Need zones are changing over time. Improvement for colorblind users.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.2.6",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.2.5",
        changes: const [
          "- Mississippi Acres Preserve update.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.2.4",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.2.3",
        changes: const [
          "- Improvement of the UI. Dark mode now persists.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.2.2",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.2.1",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.2.0",
        changes: const [
          "- Rancho Del Arroyo update.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.1.4 - 1.1.9",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.1.3",
        changes: const [
          "- Improvement of the UI. Need zones will change when hour is set. Temporary dark mode.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.1.2",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.1.1",
        changes: const [
          "- Improvement of the UI. Language option in the settings.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.1.0",
        changes: const [
          "- Fur rarity for each animal.",
          "- Information about ammunition.",
          "- Portuguese language.",
          "- Improvement of the UI. Need zones for animals are now separate for each reserve.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.0.9",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.0.8",
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.0.7",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.0.6",
        changes: const [
          "- Improvement of the UI. Added class of the animals and recommended callers for each reserve. Useful when you are preparing for the hunt.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.0.5",
        changes: const [
          "- Te Awaroa National Park update.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.0.4",
        changes: const [
          "- Information about callers.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.0.3",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.0.2",
        changes: const [
          "- Information about weapons.",
        ],
      ),
      WidgetPatchNote(
        background: Interface.even,
        version: "1.0.1",
      ),
      WidgetPatchNote(
        background: Interface.odd,
        version: "1.0.0",
        changes: const [
          "- 27. 11. 2020",
          "- Information about animals.",
          "- Semi-working maps.",
          "- English, Czech, Russian, Polish, German, France, and Spanish language.",
        ],
      )
    ]);
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr("patch_notes"),
        context: context,
      ),
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
