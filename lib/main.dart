import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/constants.dart';
import 'package:movie/pages/home.dart';
import 'package:movie/pages/tv.dart';
import 'package:movie/providerModels/movie.dart';
import 'package:movie/providerModels/networkStatus.dart';
import 'package:movie/providerModels/themeModel.dart';
import 'package:movie/widget/appBar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (context) => ThemeNotifier(),
        ),
        Provider<NetworkStatus>(
          create: (context) => NetworkStatus(),
          dispose: (context, service) => service.disposeStreams(),
        ),
        ChangeNotifierProvider<Movie>(
          create: (context) => Movie(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  List pages = [
    {'page': HomePage()},
    {'page': Tv()}
  ];

  void selectPage(int pageIndex) {
    _currentIndex = pageIndex;
    setState(() {});
  }

  var dark = false;

  Future<bool> getDarkTheme() async {
    var prefs = await SharedPreferences.getInstance();
    dark = prefs.getBool('darkMode');
    if (dark == null)
      return false;
    else if (dark != null && dark == true)
      return true;
    else
      return false;
  }

  setDarkTheme(var themeProv) async {
    themeProv.setIsDark(await getDarkTheme());
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);

    setDarkTheme(themeProvider);

    final isDark = themeProvider.getIsDark();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? darkTheme : lightTheme,
      home: Scaffold(
        appBar: CustomAppBar(),
        body: Consumer<NetworkStatus>(
          builder: (context, networkProvider, child) {
            return StreamProvider<ConnectivityResult>.value(
              value: networkProvider.networkStatusController.stream,
              child: Consumer<ConnectivityResult>(
                builder: (context, value, _) {
                  if (value == null) {
                    return buildBuilder();
                  }
                  return value != ConnectivityResult.none
                      ? pages[_currentIndex]['page']
                      : buildBuilder();
                },
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              title: Text('Movies'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              title: Text('TV Shows'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.amber[600],
          onTap: selectPage,
        ),
      ),
    );
  }

  Builder buildBuilder() {
    return Builder(
        builder: (BuildContext context) => AlertDialog(
              title: Text('Attention ! '),
              content: Container(
                child: Text(
                  'Internet Connection Required',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ));
  }
}
