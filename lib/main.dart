// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/builders/home.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/scroll_behavior.dart';
import 'package:cotwcompanion/widgets/error.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int language = sharedPreferences.getInt("language") ?? 0;
  int color = sharedPreferences.getInt("color") ?? Interface.orange.value;
  int compactLogbook = sharedPreferences.getInt("compactLogbook") ?? 3;
  bool darkMode = sharedPreferences.getBool("darkMode") ?? false;
  bool imperialUnits = sharedPreferences.getBool("imperialUnits") ?? false;
  bool mapZonesType = sharedPreferences.getBool("mapZonesType") ?? false;
  bool mapZonesStyle = sharedPreferences.getBool("mapZonesStyle") ?? false;
  bool mapZonesAccuracy = sharedPreferences.getBool("mapZonesAccuracy") ?? false;
  bool bestWeaponsForAnimal = sharedPreferences.getBool("bestWeaponsForAnimal") ?? false;
  bool dateOfRecord = sharedPreferences.getBool("dateOfRecord") ?? false;
  bool trophyLodgeRecord = sharedPreferences.getBool("trophyLodgeRecord") ?? false;
  bool furRarityPerCent = sharedPreferences.getBool("furRarityPerCent") ?? false;
  Interface.setPrimaryColor(Color(color));
  Interface.setColors(darkMode);
  runApp(EasyLocalization(
      path: 'assets/translations',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('cs'),
        Locale('pl'),
        Locale('de'),
        Locale('fr'),
        Locale('es'),
        Locale('pt'),
        Locale('ja'),
        Locale('hu'),
        Locale('tr')
      ],
      saveLocale: true,
      useOnlyLangCode: true,
      child: ChangeNotifierProvider(
        create: (BuildContext context) => Settings(
            language: language,
            color: color,
            compactLogbook: compactLogbook,
            darkMode: darkMode,
            imperialUnits: imperialUnits,
            mapZonesType: mapZonesType,
            mapZonesStyle: mapZonesStyle,
            mapZonesAccuracy: mapZonesAccuracy,
            bestWeaponsForAnimal: bestWeaponsForAnimal,
            dateOfRecord: dateOfRecord,
            trophyLodgeRecord: trophyLodgeRecord,
            furRarityPerCent: furRarityPerCent),
        child: const App(),
      )));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = ((details) => MaterialApp(
                debugShowCheckedModeBanner: false,
                home: WidgetError(
                  text: details.exceptionAsString(),
                ),
              ));
          return ScrollConfiguration(
            behavior: InvisibleScrollBehavior(),
            child: widget!,
          );
        },
        theme: ThemeData(
            brightness: Brightness.dark,
            scrollbarTheme: ScrollbarThemeData(thumbColor: MaterialStateProperty.all(Interface.ff42)),
            textSelectionTheme: TextSelectionThemeData(selectionColor: Interface.light, selectionHandleColor: Interface.dark),
            fontFamily: 'Normal'),
        home: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: Container(
            color: Interface.primary,
            child: const BuilderHome(),
          ))
        ]));
  }
}
