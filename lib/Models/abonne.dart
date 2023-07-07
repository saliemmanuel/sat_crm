import 'dart:convert';

class Abonne {
  final int? id;
  final String NOM;
  final String CNI;
  final String DOMICILE;
  final String EMAIL;
  final String GENRE;
  final String NUMEROTELEPHONE;
  final String PHOTO;
  Abonne({
    this.id,
    required this.NOM,
    required this.CNI,
    required this.DOMICILE,
    required this.EMAIL,
    required this.GENRE,
    required this.NUMEROTELEPHONE,
    required this.PHOTO,
  });

  Abonne copyWith({
    int? id,
    String? NOM,
    String? CNI,
    String? DOMICILE,
    String? EMAIL,
    String? GENRE,
    String? NUMEROTELEPHONE,
    String? PHOTO,
  }) {
    return Abonne(
      id: id ?? this.id,
      NOM: NOM ?? this.NOM,
      CNI: CNI ?? this.CNI,
      DOMICILE: DOMICILE ?? this.DOMICILE,
      EMAIL: EMAIL ?? this.EMAIL,
      GENRE: GENRE ?? this.GENRE,
      NUMEROTELEPHONE: NUMEROTELEPHONE ?? this.NUMEROTELEPHONE,
      PHOTO: PHOTO ?? this.PHOTO,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'NOM': NOM,
      'CNI': CNI,
      'DOMICILE': DOMICILE,
      'EMAIL': EMAIL,
      'GENRE': GENRE,
      'NUMEROTELEPHONE': NUMEROTELEPHONE,
      'PHOTO': PHOTO,
    };
  }

  factory Abonne.fromMap(Map<String, dynamic> map) {
    return Abonne(
      id: map['id']?.toInt(),
      NOM: map['NOM'] ?? '',
      CNI: map['CNI'] ?? '',
      DOMICILE: map['DOMICILE'] ?? '',
      EMAIL: map['EMAIL'] ?? '',
      GENRE: map['GENRE'] ?? '',
      NUMEROTELEPHONE: map['NUMEROTELEPHONE'] ?? '',
      PHOTO: map['PHOTO'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Abonne.fromJson(String source) => Abonne.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Abonne(id: $id, NOM: $NOM, CNI: $CNI, DOMICILE: $DOMICILE, EMAIL: $EMAIL, GENRE: $GENRE, NUMEROTELEPHONE: $NUMEROTELEPHONE, PHOTO: $PHOTO)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Abonne &&
        other.id == id &&
        other.NOM == NOM &&
        other.CNI == CNI &&
        other.DOMICILE == DOMICILE &&
        other.EMAIL == EMAIL &&
        other.GENRE == GENRE &&
        other.NUMEROTELEPHONE == NUMEROTELEPHONE &&
        other.PHOTO == PHOTO;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        NOM.hashCode ^
        CNI.hashCode ^
        DOMICILE.hashCode ^
        EMAIL.hashCode ^
        GENRE.hashCode ^
        NUMEROTELEPHONE.hashCode ^
        PHOTO.hashCode;
  }
}
