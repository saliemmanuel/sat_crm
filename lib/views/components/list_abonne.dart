import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/users.dart';
import '../../api/host.dart';
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
  List listAbonne = [];
  var service = ServiceApi();
  var host = Host();

  initlistAbonne() async {
    user = Provider.of<AuthProvider>(context, listen: false).users;
    listAbonne = await service.getListAbonne(user: user);
    print(listAbonne);
    setState(() {});
  }

  @override
  void initState() {
    initlistAbonne();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des abonnés")),
      body: Column(
        children: [
          if (listAbonne == [])
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              itemCount: listAbonne.length,
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
                      // simpleDialog(
                      //     context: context,
                      //     title: "Reponse ",
                      //     content: listAbonne[index]["REPONSE"]);
                    },
                    child: Row(children: [
                      Container(
                        height: 95.0,
                        width: 3,
                        decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: Container(
                            height: 150.0,
                            width: 95.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "${host.imageUrl()}${listAbonne[index]["PHOTO"]}"))),
                          ),
                          title: Text("Nom : ${listAbonne[index]["NOM"]}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Numéros : ${listAbonne[index]["NUMEROTELEPHONE"]}",
                              ),
                              Text(
                                  "Domicile :${listAbonne[index]["NUMEROTELEPHONE"]}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              Text("Email : ${listAbonne[index]["EMAIL"]}",
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      )
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
