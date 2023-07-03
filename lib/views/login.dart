import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/service_api.dart';
import '../provider/auth_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:sat_crm/config/palette.dart';

import '../widget/dialogue.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var service = ServiceApi();
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(Provider.of<AuthProvider>(context, listen: false).users);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150.0),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 2.0,
                                offset: const Offset(1, 0))
                          ],
                        ),
                        child: Consumer<AuthProvider>(
                          builder: (context, value, child) => Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/logo.jpeg"),
                                const SizedBox(height: 25.0),
                                TextFormField(
                                  controller: email,
                                  decoration: InputDecoration(
                                    icon:
                                        const Icon(Icons.mail_outline_outlined),
                                    hintText: 'Entrez une votre E-mail',
                                    labelText: "E-mail",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                  onSaved: (String? value) {},
                                  validator: (String? value) {
                                    return (value != null &&
                                            value.contains('@'))
                                        ? 'Do not use the @ char.'
                                        : null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: password,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.security),
                                    hintText: 'Entrez un mot de passe',
                                    labelText: 'Mot de passe',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  onSaved: (String? value) {},
                                  validator: (String? value) {
                                    return (value != null &&
                                            service.isEmail(email.text))
                                        ? 'Do not use the @ char.'
                                        : null;
                                  },
                                ),
                                const SizedBox(height: 15.0),
                                const SizedBox(height: 25.0),
                                SelectableText.rich(
                                    onTap: () {},
                                    const TextSpan(
                                        text:
                                            "Vous n'avez pas encore de compte ? ",
                                        children: [
                                          TextSpan(
                                              text: "Contactez un admin ! ",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline))
                                        ])),
                                const SizedBox(height: 30.0),
                                Visibility(
                                    visible: value.connexionIsLoading!,
                                    child: Lottie.asset(
                                        'assets/lotties/loading.json',
                                        width: 200.0)),
                                Visibility(
                                    visible: !value.connexionIsLoading!,
                                    child: FilledButton(
                                      child: const Text(
                                        "Se connecter",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        if (email.text.isNotEmpty ||
                                            password.text.isNotEmpty) {
                                          service.connexion(
                                              context: context,
                                              email: email.text,
                                              password: password.text);
                                        } else {
                                          simpleDialog(
                                              context: context,
                                              title: "Erreur",
                                              content:
                                                  "Entrez un e-mail et un mot de passe svp!");
                                        }
                                      },
                                    )),
                                const SizedBox(height: 15.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
