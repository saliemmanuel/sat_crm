import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sat_crm/provider/auth_provider.dart';
import 'package:sat_crm/provider/home_provider.dart';
import 'package:sat_crm/views/components/page_requete.dart';
import 'package:sat_crm/widget/widget.dart';

import 'components/ajout_abonne.dart';
import 'components/list_abonne.dart';
import 'components/list_requete.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int topIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(child: Image.asset('assets/logo.png')),
              ExpansionTile(
                leading: const Icon(Icons.question_answer_rounded),
                title: const Text("Requêtes"),
                trailing: const Icon(Icons.arrow_right_rounded),
                childrenPadding: const EdgeInsets.only(left: 60),
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text("Ajouter requête"),
                    trailing: const Icon(Icons.arrow_right_rounded),
                    onTap: () {
                      pushNewPage(const PageRequet(), context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list_alt_sharp),
                    title: const Text("Liste requête"),
                    trailing: const Icon(Icons.arrow_right_rounded),
                    onTap: () {
                      pushNewPage(const ListRequete(), context);
                    },
                  )
                ],
              ),
              ExpansionTile(
                leading: const Icon(Icons.group_sharp),
                title: const Text("Abonnés"),
                trailing: const Icon(Icons.arrow_right_rounded),
                childrenPadding: const EdgeInsets.only(left: 60),
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_add_alt_1),
                    title: const Text("Ajout abonné"),
                    trailing: const Icon(Icons.arrow_right_rounded),
                    onTap: () {
                      pushNewPage(const AjoutAbonne(), context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list_alt_sharp),
                    title: const Text("Liste abonné"),
                    trailing: const Icon(Icons.arrow_right_rounded),
                    onTap: () {
                      pushNewPage(const ListAbonne(), context);
                    },
                  )
                ],
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("A-propos"),
                trailing: const Icon(Icons.arrow_right_rounded),
                onTap: () {
                  showAboutDialog(context: context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Accueil"),
        ),
        body: Provider.of<HomeProvider>(context, listen: false).appHome(
          Provider.of<AuthProvider>(context, listen: false).getHomeState()!,
        ));
  }
}
