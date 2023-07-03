import 'package:flutter/material.dart';
import 'package:sat_crm/views/components/home_commercial.dart';

enum HOMESTATE { commercial, superviseur, caissier, assesdenied }

class HomeProvider extends ChangeNotifier {
  appHome(HOMESTATE homestate) {
    switch (homestate) {
      case HOMESTATE.commercial:
        return const HomeCommercial();
      case HOMESTATE.caissier:
        break;
      case HOMESTATE.superviseur:
        break;
      default:
        return HOMESTATE.assesdenied;
    }
    notifyListeners();
  }
}
