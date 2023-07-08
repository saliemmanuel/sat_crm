import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sat_crm/provider/home_provider.dart';
import 'package:sat_crm/views/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/theme.dart';
import 'provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  var isLogged = prefs.getString("ID");
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        title: "crm sahel telecom",
        theme: ThemeApp.lightTheme(),
        debugShowCheckedModeBanner: false,
        home: Splash(isLogged: isLogged),
      )));
}
