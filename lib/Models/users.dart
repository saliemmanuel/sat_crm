import 'dart:convert';

class Users {
  final String id;
  final String email;
  final String nom;
  final String photo;
  final String urole;
  final String active;
  final String nomerotelephone;
  final String commercialid;
  Users({
    required this.id,
    required this.email,
    required this.nom,
    required this.photo,
    required this.urole,
    required this.active,
    required this.nomerotelephone,
    required this.commercialid,
  });

  Users copyWith({
    String? id,
    String? email,
    String? nom,
    String? photo,
    String? urole,
    String? active,
    String? nomerotelephone,
    String? commercialid,
  }) {
    return Users(
      id: id ?? this.id,
      email: email ?? this.email,
      nom: nom ?? this.nom,
      photo: photo ?? this.photo,
      urole: urole ?? this.urole,
      active: active ?? this.active,
      nomerotelephone: nomerotelephone ?? this.nomerotelephone,
      commercialid: commercialid ?? this.commercialid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'nom': nom,
      'photo': photo,
      'urole': urole,
      'active': active,
      'nomerotelephone': nomerotelephone,
      'commercialid': commercialid,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      nom: map['nom'] ?? '',
      photo: map['photo'] ?? '',
      urole: map['urole'] ?? '',
      active: map['active'] ?? '',
      nomerotelephone: map['nomerotelephone'] ?? '',
      commercialid: map['commercialid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Users(id: $id, email: $email, nom: $nom, photo: $photo, urole: $urole, active: $active, nomerotelephone: $nomerotelephone, commercialid: $commercialid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.id == id &&
        other.email == email &&
        other.nom == nom &&
        other.photo == photo &&
        other.urole == urole &&
        other.active == active &&
        other.nomerotelephone == nomerotelephone &&
        other.commercialid == commercialid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        nom.hashCode ^
        photo.hashCode ^
        urole.hashCode ^
        active.hashCode ^
        nomerotelephone.hashCode ^
        commercialid.hashCode;
  }
}
