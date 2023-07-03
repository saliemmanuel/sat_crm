import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_myscript/flutter_myscript.dart';
import 'package:sim_data/sim_data.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text("Transactions"),
          ),
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
                          return SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    const Text('Transferer du crédit'),
                                    const SizedBox(height: 20.0),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.phone),
                                        hintText: 'Téléphone du point de vente',
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
                          );
                        });
                  }),
              CardHome(
                  label: "Point de vente",
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
                            child: PageView(
                              controller: pageController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Text(
                                            "Information du point de vente",
                                            style: TextStyle(fontSize: 22)),
                                        const SizedBox(height: 15.0),
                                        TextFormField(
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.home_filled),
                                            hintText: 'Nom du point de vente',
                                            labelText: 'Nom du point de vente',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15.0),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.home),
                                            hintText: 'Localisation ',
                                            labelText: 'Localisation',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15.0),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.wysiwyg_rounded),
                                            hintText: 'Type point de vente',
                                            labelText: 'Type point de vente',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15.0),
                                        Row(
                                          children: [
                                            const Icon(Icons.person_pin_circle),
                                            const SizedBox(width: 20.0),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 55.0,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "    lat: $lat, long: $long"),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 15.0),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.phone),
                                            hintText: 'Microzone',
                                            labelText: 'Microzone',
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
                                              child: const Text('Suivant'),
                                              onPressed: () {
                                                pageController.animateToPage(1,
                                                    duration: const Duration(
                                                        microseconds: 5),
                                                    curve: Curves.bounceIn);
                                              },
                                            ),
                                            const SizedBox(width: 20.0),
                                            FilledButton.tonal(
                                                child: const Text('Annuler'),
                                                onPressed: () =>
                                                    Navigator.pop(context)),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 500,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Text("Information du commercial",
                                            style: TextStyle(fontSize: 22)),
                                        const SizedBox(height: 15.0),
                                        TextFormField(
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.home_filled),
                                            hintText: 'Nom du commercial',
                                            labelText: 'Nom du commercial',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15.0),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                                Icons.call_to_action_rounded),
                                            hintText: 'N° CNI',
                                            labelText: 'N° CNI',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15.0),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                                Icons.call_to_action_rounded),
                                            hintText: 'Date exp CNI',
                                            labelText: 'Date exp CNI',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15.0),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.home),
                                            hintText: 'Domicile commercial',
                                            labelText: 'Domicile commercial',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15.0),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.wysiwyg_rounded),
                                            hintText: 'E-mail',
                                            labelText: 'E-mail',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15.0),
                                        Row(
                                          children: [
                                            const Icon(Icons.person),
                                            const SizedBox(width: 20.0),
                                            Expanded(
                                              child: Container(
                                                  height: 55.0,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: DropdownButton(
                                                      isExpanded: true,
                                                      underline: SizedBox(),
                                                      hint: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                                width: 5.0),
                                                            Text(genre),
                                                          ],
                                                        ),
                                                      ),
                                                      focusColor: Colors.black,
                                                      iconEnabledColor:
                                                          Colors.black,
                                                      dropdownColor:
                                                          Colors.white,
                                                      items: const [
                                                        DropdownMenuItem(
                                                          value: "Homme",
                                                          child: Text("Homme",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: "Femme",
                                                          child: Text("Femme",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                      ],
                                                      onChanged: (s) {
                                                        setState(() {
                                                          genre = s!;
                                                        });
                                                      })),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 15.0),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.phone),
                                            hintText: 'Téléphone',
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
                                              child: const Text('Précedent'),
                                              onPressed: () {
                                                pageController.animateToPage(0,
                                                    duration: const Duration(
                                                        microseconds: 1),
                                                    curve: Curves.bounceIn);
                                              },
                                            ),
                                            const SizedBox(width: 20.0),
                                            FilledButton.tonal(
                                                child: const Text('Annuler'),
                                                onPressed: () =>
                                                    Navigator.pop(context)),
                                            const SizedBox(width: 20.0),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
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

  Future<void> getCurrentPosition() async {}
}

var lat = "10.${Random().nextInt(99999999)}";
var long = "14.${Random().nextInt(9999999)}";
