import 'package:flutter/material.dart';
import 'package:sat_crm/provider/home_provider.dart';
import 'package:sat_crm/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/users.dart';
import '../views/home.dart';
import '../widget/widget.dart';

class AuthProvider extends ChangeNotifier {
  bool _connexionIsLoading = false;
  Users? _users;

  bool? get connexionIsLoading => _connexionIsLoading;
  Users? get users => _users;
  HOMESTATE? getHomeState() {
    switch (_users!.urole) {
      case "commercial":
        return HOMESTATE.commercial;
      case "superviseur":
        return HOMESTATE.superviseur;
      case "caissier":
        return HOMESTATE.caissier;
      default:
        return HOMESTATE.assesdenied;
    }
  }

  changeValConnexionIsLoading(bool val) {
    _connexionIsLoading = val;
    notifyListeners();
  }

  saveUserData(Users? users) {
    _users = users;
    notifyListeners();
  }

  deconnexion(var context) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove("ID");
    pushNewPageRemoveUntil(const Login(), context);
    notifyListeners();
  }
}
