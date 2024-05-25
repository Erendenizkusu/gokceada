import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/product/text_field_custom.dart';
import 'package:gokceada/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/textFont.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);
  static String? fullName;

  static String? getFullName() {
    return fullName;
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User oturumu kapalı');
      } else {
        debugPrint('User oturumu açık');
      }
    });
  }

  String? errorMessage = '';
  bool isLogin = true;
  late final TextEditingController _controllerEmail = TextEditingController();
  late final TextEditingController _controllerPassword = TextEditingController();
  late final TextEditingController _controllerUsername = TextEditingController();

  Widget _entryField(
    String labelText,
    String hintText,
    IconData icon,
    TextEditingController controller,
    bool secretText,
  ) {
    return Expanded(
        child: TextFieldCustom(
      controller: controller,
      label_text: labelText,
      hint_text: hintText,
      icon: icon,
      secretText: secretText,
        ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.instance.titleColor,
      ),
      onPressed: isLogin
          ? loginUserEmailAndPassword
          : () => createUserWithEmailAndPassword(),
      child: Text(
        isLogin ? AppLocalizations.of(context)!.login : AppLocalizations.of(context)!.register,
        style: TextFonts.instance.middleWhiteColor,
      ),
    );

  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(
        isLogin ? AppLocalizations.of(context)!.hesabinYokMu : AppLocalizations.of(context)!.bununYerineGiris,
        style: TextFonts.instance.commentTextThin,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context)!.girisEkrani, style: TextFonts.instance.appBarTitleColor),
          foregroundColor: ColorConstants.instance.titleColor,
          elevation: 1,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(AppLocalizations.of(context)!.loginTitle, style: TextFonts.instance.titleFont),
                ),
                SizedBox(
                  height: 300,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _entryField(AppLocalizations.of(context)!.email, AppLocalizations.of(context)!.emailGirin,
                            Icons.email_outlined, _controllerEmail,false),
                        _entryField(AppLocalizations.of(context)!.password, AppLocalizations.of(context)!.sifreGirin,
                            Icons.key, _controllerPassword,true),
                        _errorMessage(),
                        _submitButton(),
                        _loginOrRegisterButton(),
                      ]),
                ),
                const LoginScreenBottomSide(),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context)!.kayitEkrani, style: TextFonts.instance.appBarTitleColor),
          foregroundColor: ColorConstants.instance.titleColor,
          elevation: 1,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          height: double.infinity,
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(AppLocalizations.of(context)!.registerTitle, style: TextFonts.instance.titleFont),
              ),
              SizedBox(
                height: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _entryField(AppLocalizations.of(context)!.isimSoyisim, AppLocalizations.of(context)!.isimSoyisimGirin, Icons.person,
                          _controllerUsername,false),
                      _entryField(AppLocalizations.of(context)!.email, AppLocalizations.of(context)!.emailGirin,
                          Icons.email_outlined, _controllerEmail,false),
                      _entryField(AppLocalizations.of(context)!.password, AppLocalizations.of(context)!.sifreGirin, Icons.key,
                          _controllerPassword,true),

                      _errorMessage(),
                      _submitButton(),
                      _loginOrRegisterButton(),
                    ]),
              ),
              const LoginScreenBottomSide(),
            ]),
          ),
        ),
      );
    }
  }

  void createUserWithEmailAndPassword() async {
    try {
      UserCredential _userCredential = await auth.createUserWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text);

      var _myUser = _userCredential.user;

      await _myUser!.updateDisplayName(_controllerUsername.text);

      setState(() {
        LoginPage.fullName = _controllerUsername.text;
      });

      // Kullanıcı adını ve UID'yi kullanarak Firestore'a kaydedebilirsiniz
      String uid = _myUser.uid;
      String username = _controllerUsername.text;
      saveUsernameToFirestore(uid, username);

      // Kayıt başarılı olduğunda kullanıcıyı yönlendirebilirsiniz
      // Örneğin, anasayfaya veya giriş yaptıktan sonra sayfaya yönlendirme yapabilirsiniz
      Navigator.pushReplacementNamed(context, '/login'); // '/home' yerine uygun sayfa rotasını kullanın
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }


  void saveUsernameToFirestore(String uid, String username) {
    try {
      FirebaseFirestore.instance
          .collection('users') // Kullanıcıların bulunduğu koleksiyon adı
          .doc(uid) // Kullanıcının UID'sine göre belgeyi hedefleme
          .set({
        'username': username,
      }).then((_) {
        print('Username saved to Firestore');
      }).catchError((error) {
        print('Error saving username to Firestore: $error');
      });
    } catch (e) {
      print('Error saving username to Firestore: $e');
    }
  }

  void loginUserEmailAndPassword() async {
    try {
      UserCredential _userCredential = await auth.signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);

      auth.authStateChanges().listen((User? user) {
        if (user == null) {
          debugPrint('User oturumu kapalı');
        } else {
          Navigator.of(context).pushReplacementNamed('/usersConsole');
        }
      });

      debugPrint(_userCredential.toString());
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void deleteUser() async {
    if (auth.currentUser != null) {
      await auth.currentUser!.delete();
    }
  }

  /*void loginWithGoogle() async {
    try {
      // Google ile oturum açma işlemini başlat
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Kimlik doğrulama bilgilerini al
        final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;
        print('Google Auth: $googleAuth');
        // Google kimlik bilgilerini kullanarak Firebase kimlik bilgileri oluştur
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        print('Credential: $credential');

        final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        print(userCredential);
        final String? username = userCredential.user?.displayName;
        if (username != null) {
          saveUsernameToFirestore(userCredential.user!.uid, username);
          print('Username: $username');
        } else {
          print('Kullanıcı adı bulunamadı');
        }
        Navigator.of(context).pushReplacementNamed('/usersConsole');
      } else {
        // Google ile oturum açma işlemi iptal edildi veya hata alındı
      }
    } catch (error) {
      print(error);
      // Hata durumunda yapılacaklar
    }
  }*/

}

class LoginScreenBottomSide extends StatelessWidget {
  final Function()? onTap;

  const LoginScreenBottomSide({Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Or Login With', style: TextFonts.instance.commentTextThin),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: ()=> AuthService().signInWithGoogle(),
                  icon: Image.asset('images/google_icon.png')),
            ],
          ),
        ),
      ]),
    );
  }
}
