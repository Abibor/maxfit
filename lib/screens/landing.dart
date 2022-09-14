import 'package:flutter/material.dart';
import 'package:gps_ya/screens/auth.dart';
import 'package:gps_ya/screens/home.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // переменная isLoggedIn = false отвечает за отображение виджета аутентификации
    final bool isLoggedIn = true;

    return isLoggedIn ? HomePage() : AuthorizationPage();
  }
}