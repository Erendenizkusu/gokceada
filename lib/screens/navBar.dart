import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../product/languageButton.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar>{
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  User? get user => auth.currentUser;


  //final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Drawer(
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
           NavBarListTile(title: AppLocalizations.of(context).neredeYenir,icon: Icons.fastfood,path: 'foodareas'),
           NavBarListTile(title: AppLocalizations.of(context).gormeyeDeger,icon: Icons.remove_red_eye_outlined,path: 'gezilecek'),
           NavBarListTile(title: AppLocalizations.of(context).aktiviteler,icon: Icons.surfing,path: 'activities'),
           NavBarListTile(title: AppLocalizations.of(context).atm,icon: Icons.atm,path: 'atm'),
           NavBarListTile(title: AppLocalizations.of(context).koyler,icon: Icons.holiday_village_outlined,path: 'koyler'),
           NavBarListTile(title: AppLocalizations.of(context).feribotSaatleri,icon: Icons.directions_ferry,path: 'fery'),
           NavBarListTile(title: AppLocalizations.of(context).hediyelikEsyalar,icon: Icons.card_giftcard_outlined,path: 'hediyelik'),
           NavBarListTile(title: AppLocalizations.of(context).tavsiyeler,icon: Icons.recommend_rounded,path: 'advices'),
           NavBarListTile(title: AppLocalizations.of(context).iletisim,icon: Icons.comment_outlined,path: 'iletisim'),
           NavBarListTile(title: AppLocalizations.of(context).sizinGozunuzdenAda, icon: CupertinoIcons.eye, path: 'usersConsole'),
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
      onPressed: () {
        signOut();
        Navigator.pop(context);
        setState(() {
          _userUid();
        });
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(AppLocalizations.of(context).cikisYapildi),
          ),
        );
      },
      child: Text(AppLocalizations.of(context).signOut),
    );
  }
}

class NavBarListTile extends StatelessWidget {
  const NavBarListTile({
    Key? key, required this.icon, required this.title, required this.path,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String path;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.of(context).popAndPushNamed('/$path'),
    );
  }
}
