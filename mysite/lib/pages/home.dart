import 'package:mysite/backend/storage.dart';
import 'package:mysite/pages/dashboard/dashboard.dart';
// import 'package:mysite/pages/exercises.dart';
// import 'package:mysite/pages/toolbox.dart';
import 'package:mysite/pages/settings.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentPageIndex = 0;
  // final _exercise = GlobalKey<NavigatorState>();
  final _challenge = GlobalKey<NavigatorState>();
  // final _toolbox = GlobalKey<NavigatorState>();
  final _settings = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    late final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        NavigationRail(
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          // indicatorShape: const CircleBorder(),

          minWidth: 70,
          // labelType: NavigationRailLabelType.all,
          labelType: NavigationRailLabelType.none,
          trailing: Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: 'Change theme mode',
                    hoverColor: colorScheme.primaryContainer,
                    iconSize: 28,
                    icon: Theme.of(context).brightness == Brightness.dark
                        ? const Icon(Icons.wb_sunny)
                        : const Icon(Icons.dark_mode),
                    onPressed: () {
                      setState(() {
                        AppStorage().settings.themeMode =
                            Theme.of(context).brightness == Brightness.dark
                                ? ThemeMode.light
                                : ThemeMode.dark;
                      });
                      AppStorage().saveSettings();
                      AppStorage().updateStatus();
                    },
                  ),
                  const SizedBox(
                    height: 4,
                  )
                ],
              ),
            ),
          ),
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              padding: EdgeInsets.symmetric(vertical: 4),
              icon: Icon(
                Icons.home_filled,
                size: 28,
              ),
              label: Text('Challenge'),
            ),
            // NavigationRailDestination(
            //   padding: EdgeInsets.symmetric(vertical: 4),
            //   icon: Icon(
            //     Icons.bookmark,
            //     size: 28,
            //   ),
            //   label: Text('Categories'),
            // ),
            // NavigationRailDestination(
            //   padding: EdgeInsets.symmetric(vertical: 4),
            //   icon: Icon(
            //     Icons.token_rounded,
            //     size: 28,
            //   ),
            //   label: Text('Toolbox'),
            // ),
            NavigationRailDestination(
              padding: EdgeInsets.symmetric(vertical: 4),
              icon: Icon(
                Icons.filter_vintage,
                size: 28,
              ),
              label: Text('Settings'),
            ),
          ],
        ),
        Expanded(
          child: IndexedStack(
            index: _currentPageIndex,
            children: [
              Navigator(
                key: _challenge,
                onGenerateRoute: (route) => MaterialPageRoute(
                  settings: route,
                  builder: (context) => const Challenge(),
                ),
              ),
              // Navigator(
              //   key: _exercise,
              //   onGenerateRoute: (route) => MaterialPageRoute(
              //     settings: route,
              //     builder: (context) => const Exercises(),
              //   ),
              // ),
              // Navigator(
              //   key: _toolbox,
              //   onGenerateRoute: (route) => MaterialPageRoute(
              //     settings: route,
              //     builder: (context) => const Toolbox(),
              //   ),
              // ),
              Navigator(
                key: _settings,
                onGenerateRoute: (route) => MaterialPageRoute(
                  settings: route,
                  builder: (context) => const Settings(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
