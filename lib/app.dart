import 'package:cotwcompanion/builders/home.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/generated/fonts.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/scroll_behavior.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/widgets/app/error.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int language = sharedPreferences.getInt("language") ?? 0;
  int compactLogbook = sharedPreferences.getInt("compactLogbook") ?? 3;
  bool darkMode = sharedPreferences.getBool("darkMode") ?? false;
  bool imperialUnits = sharedPreferences.getBool("imperialUnits") ?? false;
  bool mapZonesType = sharedPreferences.getBool("mapZonesType") ?? false;
  bool mapZonesStyle = sharedPreferences.getBool("mapZonesStyle") ?? false;
  bool mapZonesCount = sharedPreferences.getBool("mapZonesCount") ?? false;
  bool mapPerformanceMode = sharedPreferences.getBool("mapPerformanceMode") ?? false;
  bool bestWeaponsForAnimal = sharedPreferences.getBool("bestWeaponsForAnimal") ?? false;
  bool entryDate = sharedPreferences.getBool("entryDate") ?? true;
  bool trophyLodgeEntry = sharedPreferences.getBool("trophyLodgeEntry") ?? false;
  bool furRarityPerCent = sharedPreferences.getBool("furRarityPerCent") ?? false;
  Interface.setColors(darkMode);
  runApp(
    EasyLocalization(
      path: "assets/translations",
      startLocale: const Locale("en"),
      fallbackLocale: const Locale("en"),
      supportedLocales: Settings.languageCodes,
      saveLocale: true,
      useFallbackTranslations: true,
      child: ChangeNotifierProvider(
        create: (BuildContext context) => Settings(
          language: language,
          compactLogbook: compactLogbook,
          darkMode: darkMode,
          imperialUnits: imperialUnits,
          mapZonesType: mapZonesType,
          mapZonesStyle: mapZonesStyle,
          mapZonesCount: mapZonesCount,
          mapPerformanceMode: mapPerformanceMode,
          bestWeaponsForAnimal: bestWeaponsForAnimal,
          entryDate: entryDate,
          trophyLodgeEntry: trophyLodgeEntry,
          furRarityPerCent: furRarityPerCent,
        ),
        child: const App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  void get _errorBuilder {
    ErrorWidget.builder = ((e) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WidgetError(
            code: "ExA001",
            error: "${e.exception}",
            stack: e.toString(),
          ),
        ));
  }

  ThemeData get _themeData {
    return ThemeData(
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(Interface.ff42),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Interface.light,
        selectionHandleColor: Interface.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Interface.primaryDark,
        toolbarHeight: 0,
        elevation: 0,
      ),
      fontFamily: FontFamily.normal,
    );
  }

  ScrollConfiguration _scrollConfiguration(Widget? widget) {
    return ScrollConfiguration(
      behavior: InvisibleScrollBehavior(),
      child: widget!,
    );
  }

  MaterialApp _buildApp(BuildContext context) {
    precacheImage(AssetImage(Assets.graphics.images.cotw.path), context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? widget) {
        _errorBuilder;
        return _scrollConfiguration(widget);
      },
      theme: _themeData,
      home: const BuilderHome(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildApp(context);
}
