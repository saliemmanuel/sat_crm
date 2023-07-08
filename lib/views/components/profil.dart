import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sat_crm/Models/users.dart';
import 'package:sat_crm/api/host.dart';
import 'package:sat_crm/provider/auth_provider.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Users? user;
  var host = Host();
  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthProvider>(context).users;
    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                  child: Container(
                height: 190.0,
                width: 190.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(190.0),
                    image: DecorationImage(
                        image:
                            NetworkImage("${host.imageUrl()}${user!.photo}"))),
              )),
              const SizedBox(height: 15.0),
              Card(
                child: ListTile(
                    trailing: const Icon(Icons.person_2),
                    title: Text(user!.nom)),
              ),
              Card(
                child: ListTile(
                    trailing: const Icon(Icons.email),
                    title: Text(user!.email)),
              ),
              Card(
                child: ListTile(
                    trailing: const Icon(Icons.phone),
                    title: Text(user!.nomerotelephone)),
              ),
              const SizedBox(height: 30.0),
              FilledButton(
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .deconnexion(context);
                  },
                  child: const Text("Déconnexion"))
            ],
          ),
        ),
      ),
    );
  }
}
