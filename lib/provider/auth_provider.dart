import 'package:flutter/material.dart';
import 'package:sat_crm/provider/home_provider.dart';

import '../Models/users.dart';

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
}
