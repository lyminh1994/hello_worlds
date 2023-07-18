import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hello_worlds/providers/app_provider.dart';
import 'package:hello_worlds/screens/home_screen.dart';
import 'package:hello_worlds/screens/favorites_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    Widget screen;
    switch (selectedIndex) {
      case 0:
        screen = HomeScreen();
        break;
      case 1:
        screen = FavoritesScreen();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: screen,
      ),
    );

    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: colorScheme.secondaryContainer),
        ),
        home: LayoutBuilder(builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: colorScheme.secondaryContainer,
              title: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/avatar.jpeg'),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        'Welcome!',
                      ),
                      Text(
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        'Minh Lys',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: mainArea,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.grey[200],
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
