import 'package:cards_app/ui/screens/auth/login_screen.dart';
import 'package:cards_app/ui/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

import '../../../data/local/shared_prefs.dart';
import '../../../resources/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static Future open(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => SplashScreen(),
      ),
      (_) => false,
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showImage = false;

  void checks() async {
    final navigator = Navigator.of(context);

    await Future.delayed(
      const Duration(seconds: 1),
      () => setState(() => _showImage = true),
    );
    await Future.delayed(const Duration(seconds: 3));

    var token = await Prefs.getToken();
    if (token == null) {
      LoginScreen.open(context);
    } else {
      MainScreen.open(context);
    }
  }

  @override
  void initState() {
    super.initState();
    checks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.25,
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 900),
            alignment: _showImage ? Alignment.center : Alignment.bottomCenter,
            child: Image.asset(Images.logo),
          ),
        ),
      ),
    );
  }
}
