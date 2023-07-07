import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_myscript/flutter_myscript.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sim_data/sim_data.dart';
import 'package:ussd_advanced/ussd_advanced.dart';
import 'ajout_abonne.dart';
import '../../widget/card_home.dart';

class HomeCommercial extends StatefulWidget {
  const HomeCommercial({super.key});

  @override
  State<HomeCommercial> createState() => _HomeCommercialState();
}

class _HomeCommercialState extends State<HomeCommercial> {
  var pageController = PageController();
  var genre = "Genre";

  @override
  void initState() {
    getCurrentLocation().then((value) {
      lat = value.latitude.toString();
      long = value.longitude.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 25.0,
            padding: const EdgeInsets.all(15.0),
            children: [
              CardHome(
                  label: "Transfert credit",
                  imagePath: "assets/externe.PNG",
                  onTap: () {
                    showModalBottomSheet(
                        useSafeArea: true,
                        context: context,
                        showDragHandle: true,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Scaffold(
                            appBar: AppBar(
                                title: const Text('Transferer du crédit')),
                            body: SingleChildScrollView(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.phone),
                                          hintText:
                                              'Téléphone du point de vente',
                                          labelText: 'Téléphone',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FilledButton(
                                            child: const Text('Executer'),
                                            onPressed: () => transfertCredit(),
                                          ),
                                          const SizedBox(width: 20.0),
                                          FilledButton.tonal(
                                              child: const Text('Annuler'),
                                              onPressed: () =>
                                                  Navigator.pop(context)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
              CardHome(
                  label: "Client",
                  imagePath: "assets/abonne.PNG",
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        showDragHandle: true,
                        useRootNavigator: true,
                        builder: (BuildContext context) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const AjoutAbonne());
                        });
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> transfertCredit() async {
    final status = await GetPermission.phone.request().isGranted;
    if (status) {
      try {
        int selectedSubscriptionId = 0;
        var sim = await SimDataPlugin.getSimData();
        for (var val in sim.cards) {
          if (val.carrierName == "orange") {
            selectedSubscriptionId = val.subscriptionId;
          }
        }
        await UssdAdvanced.sendUssd(
            code: "#150#", subscriptionId: selectedSubscriptionId);
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      GetPermission.phone.request();
    }
  }
}

String lat = "";
String long = "";

Future<Position> getCurrentLocation() async {
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnable) {
    return Future.error("Localisation désactivé");
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Localisation refuser");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error("Localisation désactiver définitivement");
  }
  return await Geolocator.getCurrentPosition();
}
