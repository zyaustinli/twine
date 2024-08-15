import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

//import 'pages/catalog/swipe/swipe_widget.dart';

import 'pages/catalog/search/search_widget.dart';
import 'pages/catalog/search_results/search_results_widget.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Redthread',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Swipe';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Swipe': const SwipeWidget(),
      'catalog': const CatalogWidget(),
      'cart': const CartWidget(),
      'inbox': const InboxWidget(),
      'profile': const ProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName]!,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        selectedItemColor: FlutterFlowTheme.of(context).primaryText,
        unselectedItemColor: FlutterFlowTheme.of(context).primaryText,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.tshirt,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 15.0,
            ),
            label: 'Swipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 1 ? Icons.apps : Icons.apps_outlined,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            label: 'Catalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 2 ? Icons.shopping_cart : Icons.shopping_cart_outlined,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 3 ? Icons.inbox : Icons.inbox_outlined,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 4 ? Icons.person : Icons.person_outline,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
GoRouter createRouter(AppStateNotifier appStateNotifier) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const NavBarPage(),
      ),
      GoRoute(
        name: 'search',
        path: '/search',
        builder: (context, state) => const SearchWidget(), // Add your SearchScreen here
      ),
      GoRoute(
        name : 'search_results',
        path: '/search_results',
        builder: (context, state) => SearchResultsWidget(
          initialQuery: (state.extra as Map<String, dynamic>?)?['query'] as String? ?? '',

        ),
      ),
      // Add other routes as needed
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Page not found'),
      ),
    ),
    redirect: (BuildContext context, GoRouterState state) {
      // Add any global redirects here if needed
      return null;
    },
  );
}
/*
class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}


/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Swipe';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Swipe': const SwipeWidget(),
      'catalog': const CatalogWidget(),
      'cart': const CartWidget(),
      'inbox': const InboxWidget(),
      'profile': const ProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: MediaQuery(
          data: queryData
              .removeViewInsets(removeBottom: true)
              .removeViewPadding(removeBottom: true),
          child: _currentPage ?? tabs[_currentPageName]!),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        selectedItemColor: FlutterFlowTheme.of(context).primaryText,
        unselectedItemColor: FlutterFlowTheme.of(context).primaryText,
        selectedBackgroundColor: const Color(0x00000000),
        borderRadius: 1234.0,
        itemBorderRadius: 8.0,
        margin: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        width: 350.0,
        elevation: 0.0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.tshirt,
                  color: currentIndex == 0
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).primaryText,
                  size: 15.0,
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 1 ? Icons.apps : Icons.apps_outlined,
                  color: currentIndex == 1
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).primaryText,
                  size: currentIndex == 1 ? 24.0 : 24.0,
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 2
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                  color: currentIndex == 2
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).primaryText,
                  size: currentIndex == 2 ? 24.0 : 24.0,
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 3 ? Icons.inbox : Icons.inbox_outlined,
                  color: currentIndex == 3
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).primaryText,
                  size: currentIndex == 3 ? 24.0 : 24.0,
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 4 ? Icons.person : Icons.person_outline,
                  color: currentIndex == 4
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).primaryText,
                  size: currentIndex == 4 ? 24.0 : 24.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  
}
*/
