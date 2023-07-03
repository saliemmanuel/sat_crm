import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';

import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import '../Models/requete.dart';
import '../Models/users.dart';
import '../provider/auth_provider.dart';
// import '../widget/route.dart';
import '../views/home.dart';
import '../widget/dialogue.dart';
import '../widget/route.dart';
import 'host.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ServiceApi {
  var host = Host();
  bool isEmail(String email) {
    String p =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  connexion({String? email, String? password, var context}) async {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .changeValConnexionIsLoading(true);
      if (isEmail(email!)) {
        var data = await http.post(host.baseUrl(endpoint: "connexion"), body: {
          "EMAIL": email,
          'MOTDEPASSE': password
        }).timeout(const Duration(seconds: 10), onTimeout: () {
          throw TimeoutException(
              'Connexion perdue, verifier votre connexion internet');
        });
        var response = await jsonDecode(data.body);
        if (data.statusCode > 201) {
          Provider.of<AuthProvider>(context, listen: false)
              .changeValConnexionIsLoading(false);
          simpleDialog(
              context: context,
              title: "Erreur",
              content: "Une erreur s'est produit");
        }

        if (data.statusCode == 200) {
          Provider.of<AuthProvider>(context, listen: false)
              .changeValConnexionIsLoading(false);
          var user = Users(
            id: response['utilisateur']['ID'].toString(),
            email: response['utilisateur']['EMAIL'],
            nom: response['utilisateur']['NOM'],
            photo: response['utilisateur']['PHOTO'],
            urole: response['utilisateur']['UROLE'].toString().toLowerCase(),
            active: response['utilisateur']['ACTIVE'].toString(),
            nomerotelephone: response['utilisateur']['NUMEROTELEPHONE'],
            commercialid: response['utilisateur']['COMMERCIAL_ID'].toString(),
          );
          Provider.of<AuthProvider>(context, listen: false).saveUserData(user);
          pushNewPageRemoveUntil(const Home(), context);
        }
      } else {
        Provider.of<AuthProvider>(context, listen: false)
            .changeValConnexionIsLoading(false);
        simpleDialog(
            context: context, title: "Erreur", content: "E-mail incorrect");
      }
    } on Exception catch (e) {
      Provider.of<AuthProvider>(context, listen: false)
          .changeValConnexionIsLoading(false);
      simpleDialog(context: context, title: "Erreur", content: e.toString());
    }
  }

  creationRequet(
      {required FilePickerResult? result,
      Requet? requet,
      required String? number,
      var context}) async {
    try {
      simpleDialogueCardSansTitle(
          msg: "Patientez svp...", context: context!, barrierDismissible: true);
      var idPointDeVent = await verifNumber(context: context, number: number);
      if (idPointDeVent != null) {
        var request = http.MultipartRequest(
            "POST", host.baseUrl(endpoint: "envoyerrequete"));
        request.fields['OBJET'] = requet!.OBJET!;
        request.fields['MESSAGE'] = requet.MESSAGE!;
        request.fields['REPONSE'] = requet.REPONSE!;
        request.fields['DATEENVOI'] = requet.DATEENVOI!;
        request.fields['DATEREPONSE'] = requet.DATEREPONSE!;
        request.fields['POINTDEVENTE_ID'] = idPointDeVent['ID'].toString();
        request.fields['TYPEREQUETE_ID'] = requet.TYPEREQUETE_ID!;
        request.fields['COMMERCIAL_ID'] = requet.COMMERCIAL_ID!;

        var piece = await http.MultipartFile.fromPath(
            "PIECESJOINTES", requet.PIECESJOINTES!);
        request.files.add(piece);

        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          Navigator.pop(context);
          simpleDialog(
              title: "Message",
              content: "Requête soumise avec succès",
              context: context);
        } else {
          Navigator.pop(context);
          simpleDialog(
              title: "Message",
              content: "Une erreur est survenue lors de l'envoi réessayer",
              context: context);
        }
      } else {
        Navigator.pop(context);
        simpleDialog(
            context: context,
            title: "Erreur",
            content:
                "Le numéros indiqué pour la requête n'existe pas dans le système");
      }
    } on Exception catch (e) {
      simpleDialog(context: context, title: "Erreur", content: e.toString());
    }
  }

  getListTypeReq({var context}) async {
    try {
      var data = await http
          .get(host.baseUrl(endpoint: "trequetes"))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });

      var response = await jsonDecode(data.body);
      if (data.statusCode > 201) {
        Provider.of<AuthProvider>(context, listen: false)
            .changeValConnexionIsLoading(false);
        simpleDialog(
            context: context,
            title: "Erreur",
            content: "Une erreur s'est produit");
      }

      if (data.statusCode == 200) {
        return response['data'];
      } else {
        return [];
      }
    } on Exception catch (e) {
      Provider.of<AuthProvider>(context, listen: false)
          .changeValConnexionIsLoading(false);
      simpleDialog(context: context, title: "Erreur", content: e.toString());
    }
  }

  verifNumber({String? number, var context}) async {
    try {
      var data = await http
          .get(host.baseUrl(endpoint: "recup/$number"))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      var response = await jsonDecode(data.body);
      if (data.statusCode == 200) {
        return response["ID"];
      }
      return [];
    } on Exception catch (e) {
      simpleDialog(context: context, title: "Erreur", content: e.toString());
    }
  }

  listRequete({required Users? user, var context}) async {
    try {
      var data = await http
          .get(host.baseUrl(
              endpoint: "commercial/${user!.commercialid}/requetes"))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      var response = await jsonDecode(data.body);
      if (data.statusCode == 200) {
        return response["requetes"];
      }
      return [];
    } on Exception catch (e) {
      simpleDialog(context: context, title: "Erreur", content: e.toString());
    }
  }
}
