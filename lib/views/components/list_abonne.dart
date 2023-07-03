import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/users.dart';
import '../../api/service_api.dart';
import '../../config/palette.dart';
import '../../provider/auth_provider.dart';
import '../../widget/dialogue.dart';

class ListAbonne extends StatefulWidget {
  const ListAbonne({super.key});

  @override
  State<ListAbonne> createState() => _ListAbonneState();
}

class _ListAbonneState extends State<ListAbonne> {
  Users? user;
  List listReq = [];
  var service = ServiceApi();

  initListReq() async {
    user = Provider.of<AuthProvider>(context, listen: false).users;
    listReq = await service.listRequete(user: user);
    print(listReq);
    setState(() {});
  }

  @override
  void initState() {
    initListReq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des requêtes")),
      body: Column(
        children: [
          if (listReq == [])
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              itemCount: listReq.length,
              itemBuilder: (context, index) {
                return Container(
                  // height: 130.0,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15.0)),
                  child: InkWell(
                    onTap: () {
                      simpleDialog(
                          context: context,
                          title: "Reponse ",
                          content: listReq[index]["REPONSE"]);
                    },
                    child: Row(children: [
                      Container(
                        width: 3,
                        decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.mark_as_unread),
                                    SizedBox(width: 10.0),
                                    Text("REQUETE: ")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: listReq[index]["STATUT"] !=
                                                    "TRAITE"
                                                ? Palette.primaryColor
                                                : Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                      ),
                                    ),
                                    Text(listReq[index]["STATUT"])
                                  ],
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            title: Text(listReq[index]["OBJET"]),
                            subtitle: Text(
                              listReq[index]["MESSAGE"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ))
                    ]),
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}
