import 'dart:async';
import 'dart:convert';
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
      var idPointDeVent = await verifNumber(context: context, number: number);
      if (idPointDeVent != null) {
        print(result);
        // var request = http.MultipartRequest(
        //     "POST", host.baseUrl(endpoint: "envoyerrequete"));
        // request.fields['OBJET'] = requet!.OBJET!;
        // request.fields['MESSAGE'] = requet.MESSAGE!;
        // request.fields['REPONSE'] = requet.REPONSE!;
        // request.fields['DATEENVOI'] = requet.DATEENVOI!;
        // request.fields['DATEREPONSE'] = requet.DATEREPONSE!;
        // request.fields['POINTDEVENTE_ID'] = idPointDeVent['ID'].toString();
        // request.fields['TYPEREQUETE_ID'] = requet.TYPEREQUETE_ID!;
        // request.fields['COMMERCIAL_ID'] = requet.COMMERCIAL_ID!;

        // if (result == null || result.files.isEmpty) {
        //   throw Exception('No files picked or file picker was canceled');
        // }

        // final file = result.files.first;
        // final filePath = file.path;
        // final mimeType = filePath != null ? lookupMimeType(filePath) : null;
        // final contentType = mimeType != null ? MediaType.parse(mimeType) : null;

        // final fileReadStream = file.readStream;
        // if (fileReadStream == null) {
        //   throw Exception('Cannot read file from null stream');
        // }

        // final stream = http.ByteStream(fileReadStream);
        // final multipartFile = http.MultipartFile(
        //   'PIECESJOINTES',
        //   stream,
        //   file.size,
        //   filename: file.name,
        //   contentType: contentType,
        // );
        // request.files.add(multipartFile);

        // final httpClient = http.Client();
        // final response = await httpClient.send(request);

        // if (response.statusCode != 200) {
        //   throw Exception('HTTP ${response.statusCode}');
        // }

        // final body = await response.stream.transform(utf8.decoder).join();
        // print(body);
      } else {
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
