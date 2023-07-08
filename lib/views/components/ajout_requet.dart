import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sat_crm/Models/requete.dart';
import 'package:sat_crm/Models/type_requete.dart';
import 'package:sat_crm/Models/users.dart';
import 'package:sat_crm/api/service_api.dart';
import 'package:sat_crm/config/palette.dart';
import 'package:sat_crm/provider/auth_provider.dart';

import '../../widget/dialogue.dart';

class PageRequet extends StatefulWidget {
  const PageRequet({super.key});

  @override
  State<PageRequet> createState() => _PageRequetState();
}

var objet = TextEditingController();
var numeros = TextEditingController();
var solde = TextEditingController();
var message = TextEditingController();

class _PageRequetState extends State<PageRequet> {
  String type = "Type requêt";
  FilePickerResult? result;
  List listTypeReq = [];
  String idReq = "";
  var service = ServiceApi();
  Users? user;

  dynamic pieceJointe;
  bool pieceJointeIsLoading = false;
  bool showSolde = false;
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
      appBar: AppBar(
        title: const Text("Requêtes"),
      ),
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
                                  child: Text("${e['NOM']}",
                                      overflow: TextOverflow.ellipsis,
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
                              if (type == "LS") {
                                showSolde = true;
                              } else {
                                showSolde = false;
                                solde.clear();
                              }
                            });
                          })),
                )
              ],
            ),
            Visibility(
              visible: showSolde,
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  TextFormField(
                    controller: solde,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.monetization_on),
                      hintText: 'Solde',
                      labelText: 'Solde',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: TextFormField(
                    maxLines: 2,
                    minLines: 1,
                    controller: message,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Message', border: InputBorder.none),
                  ),
                ),
              ))
            ]),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  FilledButton.icon(
                      onPressed: () {
                        _pickPiece();
                      },
                      icon: const Icon(Icons.add_link_sharp),
                      label: const Text("Pièce jointe")),
                ],
              ),
            ),
            pieceJointeIsLoading
                ? const Center(child: CircularProgressIndicator())
                : pieceJointe == null
                    ? const SizedBox()
                    : buildFile(pieceJointe)
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton(
                child: const Text('Annuler'),
                onPressed: () => Navigator.pop(context)),
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
                  if (pieceJointe == null) {
                    simpleDialog(
                        title: "Erreur",
                        content:
                            "Veillez ajouter le dossier comme pièce jointe",
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
                            PIECESJOINTES: pieceJointe.path,
                            POINTDEVENTE_ID: "2",
                            REPONSE: "VIDE",
                            DATEENVOI: DateTime.now().toString(),
                            SOLDE: solde.text.isEmpty ? "" : solde.text));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickPiece() async {
    setState(() {
      pieceJointeIsLoading = true;
    });

    try {
      var temp = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
        type: FileType.custom,
      );
      PlatformFile file = temp!.files.first;
      setState(() {
        if (!mounted) return;
        pieceJointe = file;
        pieceJointeIsLoading = false;
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
}
