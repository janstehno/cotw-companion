// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/helpers/scroll_behavior.dart';
import 'package:cotwcompanion/thehunter/builders/home.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_error.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool darkMode = sharedPreferences.getBool("darkMode") ?? false;
  bool imperialUnits = sharedPreferences.getBool("imperialUnits") ?? false;
  int compactLogbook = sharedPreferences.getInt("compactLogbook") ?? 3;
  int language = sharedPreferences.getInt("language") ?? 0;
  int color = sharedPreferences.getInt("color") ?? Values.colorThird;
  int fontSize = sharedPreferences.getInt("fontSize") ?? 3;
  bool furRarityPerCent = sharedPreferences.getBool("furRarityPerCent") ?? false;
  bool bestWeaponsForAnimal = sharedPreferences.getBool("bestWeaponsForAnimal") ?? false;
  bool mapZonesStyle = sharedPreferences.getBool("mapZonesStyle") ?? false;
  bool dateOfRecord = sharedPreferences.getBool("dateOfRecord") ?? false;
  bool trophyLodgeRecord = sharedPreferences.getBool("trophyLodgeRecord") ?? false;
  Values.setColors(darkMode);
  Values.setPrimaryColor(color);
  Values.setFontSize(fontSize);
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
        Locale('tr')
      ],
      saveLocale: true,
      useOnlyLangCode: true,
      child: ChangeNotifierProvider(
        create: (BuildContext context) => Settings(
            darkMode: darkMode,
            imperialUnits: imperialUnits,
            compactLogbook: compactLogbook,
            language: language,
            color: color,
            fontSize: fontSize,
            furRarityPerCent: furRarityPerCent,
            bestWeaponsForAnimal: bestWeaponsForAnimal,
            mapZonesStyle: mapZonesStyle,
            dateOfRecord: dateOfRecord,
            trophyLodgeRecord: trophyLodgeRecord),
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
            scrollbarTheme: ScrollbarThemeData(thumbColor: MaterialStateProperty.all(const Color(Values.color61))),
            textSelectionTheme: TextSelectionThemeData(selectionColor: Color(Values.colorLight), selectionHandleColor: Color(Values.colorDark)),
            fontFamily: 'Manrope'),
        home: Column(mainAxisSize: MainAxisSize.max, children: [Expanded(child: Container(color: Color(Values.colorPrimary), child: const BuilderHome()))]));
  }
}
