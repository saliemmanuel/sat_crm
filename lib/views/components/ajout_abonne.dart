import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sat_crm/Models/abonne.dart';
import 'package:sat_crm/Models/point_de_vente.dart';
import 'package:sat_crm/api/service_api.dart';

import '../../config/palette.dart';
import '../../widget/dialogue.dart';
import 'home_commercial.dart';

class AjoutAbonne extends StatefulWidget {
  const AjoutAbonne({super.key});

  @override
  State<AjoutAbonne> createState() => _AjoutAbonneState();
}

class _AjoutAbonneState extends State<AjoutAbonne> {
  var pageController = PageController();
  var genre = "Genre";
  var typepdv = "Type point de vente";
  var microzone = "Microzone";
  var listTypePdv = [];
  var listMircrozone = [];

  @override
  void initState() {
    initLists();
    super.initState();
  }

  initLists() async {
    listTypePdv = await service.getListTypepdv(context: context);
    // ignore: use_build_context_synchronously
    listMircrozone = await service.getListMircrozone(context: context);
    print("listTypePdv");
    print(listTypePdv);
    print("listMircrozone");
    print(listMircrozone);

    setState(() {});
  }

  var service = ServiceApi();
  dynamic image;
  bool imageIsLoading = false;
  dynamic dossier;
  bool dossierIsLoading = false;
  var nom = TextEditingController();
  var cni = TextEditingController();
  var domicile = TextEditingController();
  var email = TextEditingController();
  var telephone = TextEditingController();
  var nompdv = TextEditingController();
  var localisationpdv = TextEditingController();
  var numcmr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajout abonné")),
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
                    controller: nom,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Nom du client',
                      labelText: 'Nom du client',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    controller: cni,
                    keyboardType: TextInputType.text,
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
                        imageIsLoading
                            ? const Center(child: CircularProgressIndicator())
                            : image == null
                                ? InkWell(
                                    onTap: () {
                                      showBottomSheet();
                                    },
                                    child: Container(
                                      height: 95.0,
                                      width: 95.0,
                                      decoration: BoxDecoration(
                                          color: Palette.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: const Center(
                                        child: Icon(Icons.image_rounded,
                                            size: 35.0, color: Colors.white),
                                      ),
                                    ),
                                  )
                                : buildImge(image),
                        const Text("      4x4")
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    controller: domicile,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.home_filled),
                      hintText: 'Domicile du client',
                      labelText: 'Domicile du client',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail),
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
                      const SizedBox(width: 15.0),
                      Expanded(
                        child: Container(
                            height: 60.0,
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
                    controller: telephone,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton.tonal(
                          child: const Text('Annuler'),
                          onPressed: () => Navigator.pop(context)),
                      FilledButton(
                        child: const Text('Suivant'),
                        onPressed: () {
                          pageController.animateToPage(1,
                              duration: const Duration(microseconds: 1),
                              curve: Curves.bounceIn);
                        },
                      ),
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
                    controller: nompdv,
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
                    controller: localisationpdv,
                    keyboardType: TextInputType.text,
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
                  Row(
                    children: [
                      const Icon(Icons.wysiwyg_rounded),
                      const SizedBox(width: 15.0),
                      Expanded(
                        child: Container(
                            height: 60.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: listTypePdv.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : DropdownButton<String>(
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 5.0),
                                          Text(typepdv),
                                        ],
                                      ),
                                    ),
                                    focusColor: Colors.black,
                                    iconEnabledColor: Colors.black,
                                    dropdownColor: Colors.white,
                                    items: listTypePdv
                                        .map((e) => DropdownMenuItem<String>(
                                              value: e['NOM'],
                                              child: Text(e['NOM'],
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  )),
                                            ))
                                        .toList(),
                                    onChanged: (s) {
                                      setState(() {
                                        typepdv = s!;
                                      });
                                    })),
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    controller: numcmr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: 'Numero commercial point de vente',
                      labelText: 'Numero commercial pointde vente',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      const Icon(Icons.person_pin_circle),
                      const SizedBox(width: 15.0),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 60.0,
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
                  Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(width: 15.0),
                      Expanded(
                        child: Container(
                            height: 60.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: listMircrozone.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : DropdownButton(
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 5.0),
                                          Text(microzone),
                                        ],
                                      ),
                                    ),
                                    focusColor: Colors.black,
                                    iconEnabledColor: Colors.black,
                                    dropdownColor: Colors.white,
                                    items: listMircrozone
                                        .map((e) => DropdownMenuItem<String>(
                                              value: e['NOM'],
                                              child: Text(e['NOM'],
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  )),
                                            ))
                                        .toList(),
                                    onChanged: (s) {
                                      setState(() {
                                        microzone = s.toString();
                                      });
                                    })),
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        FilledButton.icon(
                            onPressed: () {
                              _pickDossier();
                            },
                            icon: const Icon(Icons.add_link_sharp),
                            label: const Text("Dossier")),
                      ],
                    ),
                  ),
                  dossierIsLoading
                      ? const Center(child: CircularProgressIndicator())
                      : dossier == null
                          ? const SizedBox()
                          : buildFile(dossier),
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton.tonal(
                        child: const Text('Précedent'),
                        onPressed: () {
                          pageController.animateToPage(0,
                              duration: const Duration(microseconds: 5),
                              curve: Curves.bounceIn);
                        },
                      ),
                      const SizedBox(width: 20.0),
                      FilledButton(
                          child: const Text('Envoyer'),
                          onPressed: () {
                            if (nom.text.isEmpty ||
                                cni.text.isEmpty ||
                                domicile.text.isEmpty ||
                                email.text.isEmpty ||
                                genre == 'Genre' ||
                                telephone.text.isEmpty ||
                                nompdv.text.isEmpty ||
                                localisationpdv.text.isEmpty ||
                                typepdv == "Type point de vente" ||
                                microzone == "Microzone" ||
                                numcmr.text.isEmpty) {
                              simpleDialog(
                                  title: "Erreur",
                                  content: "Remplissez tous les champs svp!",
                                  context: context);
                            } else {
                              if (dossier == null || image == null) {
                                simpleDialog(
                                    title: "Erreur",
                                    content:
                                        "Selectionner un dossier et une image du client",
                                    context: context);
                              } else {
                                service.ajoutAbonne(
                                    context: context,
                                    abonne: Abonne(
                                        NOM: nom.text,
                                        EMAIL: email.text,
                                        NUMEROTELEPHONE: telephone.text,
                                        DOMICILE: domicile.text,
                                        CNI: cni.text,
                                        GENRE: genre == "Homme" ? "1" : "0",
                                        PHOTO: image.path),
                                    pdv: PointDeVente(
                                        NOMPOINTVENTE: nompdv.text,
                                        NUMCOMMERCIAL: numcmr.text,
                                        LOCALISATION: localisationpdv.text,
                                        ACTIVE: "1",
                                        LATITUDE: lat,
                                        LONGITUDE: long,
                                        MICRO: microzone,
                                        TPDV: typepdv,
                                        DOSSIER: dossier.path));
                              }
                            }
                          }),
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

  void _pickDossier() async {
    setState(() {
      dossierIsLoading = true;
    });

    try {
      var temp = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
        type: FileType.custom,
      );
      PlatformFile file = temp!.files.first;
      setState(() {
        if (!mounted) return;
        dossier = file;
        dossierIsLoading = false;
      });
    } on PlatformException catch (e) {
      simpleDialog(title: 'Error', content: e.toString(), context: context);
    } catch (e) {
      simpleDialog(title: 'Error', content: e.toString(), context: context);
    }
  }

  void _pickImg({bool? isCamera}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? _image;
    setState(() {
      imageIsLoading = true;
    });
    try {
      if (isCamera!) {
        _image = await picker.pickImage(source: ImageSource.camera);
      } else {
        _image = await picker.pickImage(source: ImageSource.gallery);
      }
      setState(() {
        if (!mounted) return;
        image = _image;
        imageIsLoading = false;
        Navigator.pop(context);
      });
    } on PlatformException catch (e) {
      simpleDialog(title: 'Error', content: e.toString(), context: context);
    } catch (e) {
      simpleDialog(title: 'Error', content: e.toString(), context: context);
    }
  }

  buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final filesize =
        mb > 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} Ko';
    return Container(
      padding: const EdgeInsets.all(15.0),
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.circular(10.0)),
      child: Text(
        '${file.name} $filesize',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  buildImge(XFile file) {
    return InkWell(
      onTap: () {
        showBottomSheet();
      },
      child: Container(
        height: 95.0,
        width: 95.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(File(file.path)), fit: BoxFit.fill),
            color: Palette.primaryColor,
            borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  showBottomSheet() {
    return showModalBottomSheet(
        useSafeArea: true,
        context: context,
        showDragHandle: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton.icon(
                        onPressed: () {
                          _pickImg(isCamera: true);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text("Camera")),
                    FilledButton.icon(
                        onPressed: () {
                          _pickImg(isCamera: false);
                        },
                        icon: const Icon(Icons.image),
                        label: const Text("Galerie"))
                  ],
                ),
              ],
            ),
          );
        });
  }
}
