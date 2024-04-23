import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gokceada/classes/language_constants.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/pages/login_register_page.dart';
import 'package:gokceada/screens/barlarMap.dart';
import 'package:gokceada/screens/cafelerMap.dart';
import 'package:gokceada/screens/campingMap.dart';
import 'package:gokceada/screens/fery.dart';
import 'package:gokceada/screens/hediyelikMap.dart';
import 'package:gokceada/screens/hotelsMap.dart';
import 'package:gokceada/screens/kahvaltiMap.dart';
import 'package:gokceada/screens/navBar/activitiesMap.dart';
import 'package:gokceada/screens/navBar/atmList.dart';
import 'package:gokceada/screens/navBar/gezilecekMap.dart';
import 'package:gokceada/screens/navBar/iletisim.dart';
import 'package:gokceada/screens/navBar/koyler.dart';
import 'package:gokceada/screens/navBar/nerdeyenirview.dart';
import 'package:gokceada/pages/users_console.dart';
import 'package:gokceada/pages/home_page.dart';
import 'package:gokceada/screens/navBar/tavsiyeler.dart';
import 'package:gokceada/screens/pansionMaps.dart';
import 'package:gokceada/screens/plajlar.dart';
import 'package:gokceada/screens/restaurantsMap.dart';
import 'package:gokceada/screens/splash_screen.dart';
import 'package:gokceada/screens/surfingMap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'l10n/l10n.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:919333673755:android:556e785f5fae57dc1051be',
      apiKey: 'AIzaSyAPFd-5utIlJQbFC7WcjuQpNNpttDvYEps',
      projectId: 'gokceada-688c7', messagingSenderId: '919333673755',
      // ... other options
    ),
  );

  runApp(const Gokceada());
}

class Gokceada extends StatefulWidget {
  const Gokceada({Key? key}) : super(key: key);

  @override
  State<Gokceada> createState() => _GokceadaState();

  static void setLocale(BuildContext context, Locale newLocale){
    _GokceadaState? state = context.findAncestorStateOfType<_GokceadaState>();
    state?.setLocale(newLocale);
  }
}

class _GokceadaState extends State<Gokceada> {
  Locale? _locale;

  setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: L10n.all,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: ColorConstants.instance.commentColor,
          ),
        ),
      ),
      title: 'Gokceada',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/atm': (context) =>  const AtmList(),
        '/pansionList': (context) => const PansionDetay(),
        '/advices': (context) => const Advices(),
        '/cafe': (context) => const CafeDetay(),
        '/iletisim': (context) => const Iletisim(),
        '/restaurantsView': (context) => const RestaurantDetay(),
        '/kahvalti': (context) => const BreakfastDetay(),
        '/hediyelik': (context) => const HediyelikDetay(),
        '/bar': (context) => const BarDetay(),
        '/plajlar': (context) => const PlajlarView(),
        '/gezilecek': (context) => const GezilecekDetay(),
        '/activities': (context) => const ActivitiesDetay(),
        '/foodareas': (context) => const NerdeYenirView(),
        '/login': (context) => const LoginPage(),
        '/fery': (context) => const Feribot(),
        '/villages': (context) => const Koyler(),
        '/usersConsole': (context) => const UsersConsole(),
        '/homepage': (context) => const HomePage(),
        '/koyler': (context) => const Koyler(),
        '/oteller': (context) =>  const OtelDetay(),
        '/camping': (context) =>  const CampingDetay(),
        '/surfing': (context) =>  const SurfingDetay(),
      },
    );
  }
}

