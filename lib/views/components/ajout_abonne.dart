import 'package:flutter/material.dart';

import 'home_commercial.dart';

class AjoutAbonne extends StatefulWidget {
  const AjoutAbonne({super.key});

  @override
  State<AjoutAbonne> createState() => _AjoutAbonneState();
}

class _AjoutAbonneState extends State<AjoutAbonne> {
  @override
  Widget build(BuildContext context) {
    var pageController = PageController();
    var genre = "Genre";
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Information du client",
                      style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.home_filled),
                      hintText: 'Nom du client',
                      labelText: 'Nom du client',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.call_to_action_rounded),
                      hintText: 'N° CNI',
                      labelText: 'N° CNI',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                useSafeArea: true,
                                context: context,
                                showDragHandle: true,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            FilledButton.icon(
                                                onPressed: () {},
                                                icon: const Icon(Icons.camera),
                                                label: const Text("Camera")),
                                            FilledButton.icon(
                                                onPressed: () {},
                                                icon: const Icon(Icons.image),
                                                label: const Text("Galerie"))
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 95.0,
                            width: 95.0,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: const Center(
                              child: Icon(Icons.image_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.home),
                      hintText: 'Quartier du client',
                      labelText: 'Quartier du client',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.wysiwyg_rounded),
                      hintText: 'E-mail du client',
                      labelText: 'E-mail du client ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                borderRadius: BorderRadius.circular(10.0)),
                            child: DropdownButton(
                                isExpanded: true,
                                underline: const SizedBox(),
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 5.0),
                                      Text(genre),
                                    ],
                                  ),
                                ),
                                focusColor: Colors.black,
                                iconEnabledColor: Colors.black,
                                dropdownColor: Colors.white,
                                items: const [
                                  DropdownMenuItem(
                                    value: "Homme",
                                    child: Text("Homme",
                                        style: TextStyle(
                                          color: Colors.black,
                                        )),
                                  ),
                                  DropdownMenuItem(
                                    value: "Femme",
                                    child: Text("Femme",
                                        style: TextStyle(
                                          color: Colors.black,
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
                      hintText: 'Téléphone du client',
                      labelText: 'Téléphone du client',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        child: const Text('Suivant'),
                        onPressed: () {
                          pageController.animateToPage(1,
                              duration: const Duration(microseconds: 1),
                              curve: Curves.bounceIn);
                        },
                      ),
                      const SizedBox(width: 20.0),
                      FilledButton.tonal(
                          child: const Text('Annuler'),
                          onPressed: () => Navigator.pop(context)),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Information du point de vente",
                      style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.home_filled),
                      hintText: 'Nom du point de vente',
                      labelText: 'Nom du point de vente',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            children: [
                              Text("    lat: $lat, long: $long"),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        child: const Text('Précedent'),
                        onPressed: () {
                          pageController.animateToPage(0,
                              duration: const Duration(microseconds: 5),
                              curve: Curves.bounceIn);
                        },
                      ),
                      const SizedBox(width: 20.0),
                      FilledButton.tonal(
                          child: const Text('Annuler'),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  const SizedBox(
                    height: 500,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
