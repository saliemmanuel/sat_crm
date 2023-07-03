import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sat_crm/provider/home_provider.dart';
import 'package:sat_crm/views/login.dart';

import 'config/theme.dart';
import 'provider/auth_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        title: "crm sahel telecom",
        theme: ThemeApp.lightTheme(),
        debugShowCheckedModeBanner: false,
        home: const Login(),
      )));
}
