import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar>{

  late FirebaseAuth auth;
  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;
  var adUnit = "ca-app-pub-3940256099942544/1033173712";

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    initIntersitialAd();
  }

  User? get user => auth.currentUser;

  initIntersitialAd(){
    InterstitialAd.load(
        adUnitId: adUnit,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad){
              interstitialAd = ad;
              setState(() {
                isAdLoaded = true;
              });
              interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
                  onAdDismissedFullScreenContent: (ad){
                    ad.dispose();
                    setState(() {
                      isAdLoaded = false;
                    });
                  },
                  onAdFailedToShowFullScreenContent: (ad, error){
                    ad.dispose();
                    setState(() {
                      isAdLoaded = false;
                    });
                  }
              );
            },
            onAdFailedToLoad: ((error){
              interstitialAd.dispose();
            })
        ));
  }


  //final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Color(0xffeac056),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: const Text('Gokceada'),
              accountEmail: _userUid(),
              currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                      child: Image.asset(
                          'images/gokceadapp.jpg',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                            )
                  )
              ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/nbbackground.jpg'),
                fit: BoxFit.cover,
              )
            ),
              ),
           NavBarListTile(title: 'neredeYenir'.tr(),icon: Icons.fastfood,path: () {
             if(isAdLoaded){
               interstitialAd.show();
             }
             Navigator.of(context).popAndPushNamed('/foodareas');}),
           NavBarListTile(title: 'gormeyeDeger'.tr(),icon: Icons.remove_red_eye_outlined,path: () => Navigator.of(context).popAndPushNamed('/gezilecek')),
           NavBarListTile(title: 'aktiviteler'.tr(),icon: Icons.surfing,path: () => Navigator.of(context).popAndPushNamed('/activities')),
           NavBarListTile(title: 'atm'.tr(),icon: Icons.atm,path: () => Navigator.of(context).popAndPushNamed('/atm')),
           NavBarListTile(title: 'koyler'.tr(),icon: Icons.holiday_village_outlined,path: () => Navigator.of(context).popAndPushNamed('/koyler')),
           NavBarListTile(title: 'feribotSaatleri'.tr(),icon: Icons.directions_ferry,path: (){
             if(isAdLoaded){
               interstitialAd.show();
             }
             Navigator.of(context).popAndPushNamed('/fery');}),
           NavBarListTile(title: 'hediyelikEsyalar'.tr(),icon: Icons.card_giftcard_outlined,path: () => Navigator.of(context).popAndPushNamed('/hediyelik')),
           NavBarListTile(title: 'tavsiyeler'.tr(),icon: Icons.recommend_rounded,path: () => Navigator.of(context).popAndPushNamed('/advices')),
           NavBarListTile(title: 'iletisim'.tr(),icon: Icons.comment_outlined,path: () => Navigator.of(context).popAndPushNamed('/iletisim')),
           NavBarListTile(title: 'sizinGozunuzdenAda'.tr(), icon: CupertinoIcons.eye, path: () => Navigator.of(context).popAndPushNamed('/usersConsole')),
           const Divider(),
           _signOutButton(context),
        ],
      ),
    );
  }
  Widget _userUid(){
    return Text(user?.email ?? 'Gokceada');
  }

  void signOut() async {
    var _user = GoogleSignIn().currentUser;
    if(_user != null) {
      await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();
    }
    await auth.signOut();
  }

  Widget _signOutButton(BuildContext context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(elevation: 10),
      onPressed: () {
        signOut();
        Navigator.pop(context);
        setState(() {
          _userUid();
        });
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text('cikisYapildi'.tr()),
          ),
        );
      },
      child: Text('signOut'.tr()),
    );
  }
}

class NavBarListTile extends StatelessWidget {
  const NavBarListTile({
    Key? key, required this.icon, required this.title, required this.path,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final void Function() path;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: path,
    );
  }
}
