import 'package:mysite/backend/storage.dart';
import 'package:mysite/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  String? handle = Uri.base.queryParameters['handle'];
  String? theme = Uri.base.queryParameters['themeId'];
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage().init();
  if (handle != null) {
    AppStorage().settings.handle = handle;
  }
  if (theme != null) {
    int? themeId = int.tryParse(theme);
    if (themeId != null && 0 <= themeId && themeId <= 19) {
      AppStorage().settings.themeCode = themeId;
    }
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppStorage(),
      child: const CFPartner(),
    ),
  );
}

class CFPartner extends StatelessWidget {
  const CFPartner({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStorage>(
      builder: (BuildContext context, AppStorage value, Widget? child) {
        MaterialColor themeColor = value.getColorTheme();
        var lightTheme = ColorScheme.fromSeed(
            seedColor: themeColor, brightness: Brightness.light);
        var darkTheme = ColorScheme.fromSeed(
            seedColor: themeColor, brightness: Brightness.dark);
        return MaterialApp(
          // debugShowCheckedModeBanner: false,
          title: 'CF Partner Web',
          theme: ThemeData(
            colorScheme: lightTheme,
            tooltipTheme: TooltipThemeData(
              decoration: BoxDecoration(
                color: lightTheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: TextStyle(
                color: lightTheme.onSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            // dialogTheme: DialogTheme(
            //   surfaceTintColor: Colors.transparent,
            //   barrierColor: lightTheme.surfaceTint.withOpacity(0.12),
            // ),
            appBarTheme: AppBarTheme(
              scrolledUnderElevation: 0,
              backgroundColor: lightTheme.surface,
            ),
            navigationRailTheme: NavigationRailThemeData(
              backgroundColor: Color.alphaBlend(
                  lightTheme.primary.withOpacity(0.04), lightTheme.surface),
              indicatorColor: lightTheme.primaryContainer,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: darkTheme,
            tooltipTheme: TooltipThemeData(
              decoration: BoxDecoration(
                color: darkTheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: TextStyle(
                color: darkTheme.onSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            // dialogTheme: DialogTheme(
            //   surfaceTintColor: Colors.transparent,
            //   barrierColor: darkTheme.surfaceTint.withOpacity(0.12),
            // ),
            appBarTheme: AppBarTheme(
              scrolledUnderElevation: 0,
              backgroundColor: darkTheme.surface,
            ),
            navigationRailTheme: NavigationRailThemeData(
              backgroundColor: Color.alphaBlend(
                  darkTheme.primary.withOpacity(0.04), darkTheme.surface),
              indicatorColor: darkTheme.primaryContainer,
            ),
          ),
          themeMode: value.settings.themeMode,
          home: const Home(),
        );
      },
    );
  }
}
