import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2),
        () => Navigator.of(context).popAndPushNamed('/homepage')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/splash_foto.jpg',fit: BoxFit.fill);
  }
}
