import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sat_crm/Models/requete.dart';
import 'package:sat_crm/Models/type_requete.dart';
import 'package:sat_crm/Models/users.dart';
import 'package:sat_crm/api/service_api.dart';
import 'package:sat_crm/provider/auth_provider.dart';

import '../../widget/dialogue.dart';

class PageRequet extends StatefulWidget {
  const PageRequet({super.key});

  @override
  State<PageRequet> createState() => _PageRequetState();
}

var objet = TextEditingController();
var numeros = TextEditingController();
var message = TextEditingController();

class _PageRequetState extends State<PageRequet> {
  String type = "Type requêt";
  FilePickerResult? result;
  File? file;
  List listTypeReq = [];
  String idReq = "";
  var service = ServiceApi();
  Users? user;

  @override
  void initState() {
    initListReq();
    user = Provider.of<AuthProvider>(context, listen: false).users;
    super.initState();
  }

  initListReq() async {
    listTypeReq = await service.getListTypeReq(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
          children: [
            const SizedBox(height: 15.0),
            TextFormField(
              controller: objet,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                icon: Icon(Icons.edit),
                hintText: 'Objet de la requête',
                labelText: 'Objet de la requête',
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
                                Text(type),
                              ],
                            ),
                          ),
                          focusColor: Colors.black,
                          iconEnabledColor: Colors.black,
                          dropdownColor: Colors.white,
                          items: listTypeReq
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child:
                                      Text("${e['NOM']} (${e['DESCRIPTION']})",
                                          style: const TextStyle(
                                            color: Colors.black,
                                          )),
                                ),
                              )
                              .toList(),
                          onChanged: (s) {
                            setState(() {
                              var typeRequeteModel = TypeRequete.fromMap(
                                  s as Map<String, dynamic>);
                              type = typeRequeteModel.NOM;
                              idReq = typeRequeteModel.ID.toString();
                            });
                          })),
                )
              ],
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: numeros,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: 'Numéros ',
                labelText: 'Numéros',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Row(children: [
              const Icon(Icons.message),
              const SizedBox(width: 15.0),
              Expanded(
                  child: Container(
                height: 105.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextFormField(
                  maxLines: 2,
                  minLines: 1,
                  controller: message,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: 'Message', border: InputBorder.none),
                ),
              ))
            ]),
            const SizedBox(height: 15.0),
            Row(
              children: [
                FilledButton.icon(
                    onPressed: () {
                      pickFile();
                    },
                    icon: const Icon(Icons.add_link_sharp),
                    label: const Text("Pièce jointe")),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  child: const Text('Envoyer'),
                  onPressed: () {
                    if (objet.text.isEmpty ||
                        type == "Type requêt" ||
                        numeros.text.isEmpty ||
                        message.text.isEmpty) {
                      simpleDialog(
                          title: "Erreur",
                          content: "Remplissez tous les champs svp!",
                          context: context);
                    } else {
                      service.creationRequet(
                          result: result,
                          number: numeros.text,
                          context: context,
                          requet: Requet(
                            OBJET: objet.text,
                            MESSAGE: message.text,
                            STATUT: "EN COURS",
                            TYPEREQUETE_ID: idReq,
                            COMMERCIAL_ID: user!.commercialid,
                            DATEREPONSE: DateTime.now().toString(),
                            PIECESJOINTES: "dpf/",
                            POINTDEVENTE_ID: "2",
                            REPONSE: "VIDE",
                            DATEENVOI: DateTime.now().toString(),
                          ));
                    }
                  },
                ),
                const SizedBox(width: 20.0),
                FilledButton(
                    child: const Text('Annuler'),
                    onPressed: () => Navigator.pop(context)),
                const SizedBox(width: 20.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  pickFile() async {
    result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: false);
    print(result);
    print("result");
    setState(() {});
  }
}