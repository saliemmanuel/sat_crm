import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sat_crm/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/users.dart';
import '../provider/auth_provider.dart';
import '../widget/route.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  final String? isLogged;
  const Splash({super.key, required this.isLogged});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Users? user;
  @override
  void initState() {
    initPage();
    super.initState();
  }

  initPage() async {
    if (widget.isLogged != null) {
      var prefs = await SharedPreferences.getInstance();
      user = Users(
        id: prefs.getString("ID")!,
        email: prefs.getString("EMAIL")!,
        nom: prefs.getString("NOM")!,
        photo: prefs.getString("PHOTO")!,
        urole: prefs.getString("UROLE")!,
        active: prefs.getString("ACTIVE")!,
        nomerotelephone: prefs.getString("NUMEROTELEPHONE")!,
        commercialid: prefs.getString("COMMERCIAL_ID")!,
      );
      pushPage();
    } else {
      pushNewPageRemoveUntil(const Login(), context);
    }
  }

  pushPage() {
    Provider.of<AuthProvider>(context, listen: false).saveUserData(user);
    pushNewPageRemoveUntil(const Home(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
