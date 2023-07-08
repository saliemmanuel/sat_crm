import 'dart:convert';

class Requet {
  final String? OBJET;
  final String? MESSAGE;
  final String? PIECESJOINTES;
  final String? STATUT;
  final String? REPONSE;
  final String? DATEENVOI;
  final String? DATEREPONSE;
  final String? POINTDEVENTE_ID;
  final String? TYPEREQUETE_ID;
  final String? COMMERCIAL_ID;
  final String? SOLDE;
  Requet({
    this.OBJET,
    this.MESSAGE,
    this.PIECESJOINTES,
    this.STATUT,
    this.REPONSE,
    this.DATEENVOI,
    this.DATEREPONSE,
    this.POINTDEVENTE_ID,
    this.TYPEREQUETE_ID,
    this.COMMERCIAL_ID,
   required this.SOLDE,
  });
  

  Requet copyWith({
    String? OBJET,
    String? MESSAGE,
    String? PIECESJOINTES,
    String? STATUT,
    String? REPONSE,
    String? DATEENVOI,
    String? DATEREPONSE,
    String? POINTDEVENTE_ID,
    String? TYPEREQUETE_ID,
    String? COMMERCIAL_ID,
    String? SOLDE,
  }) {
    return Requet(
      OBJET: OBJET ?? this.OBJET,
      MESSAGE: MESSAGE ?? this.MESSAGE,
      PIECESJOINTES: PIECESJOINTES ?? this.PIECESJOINTES,
      STATUT: STATUT ?? this.STATUT,
      REPONSE: REPONSE ?? this.REPONSE,
      DATEENVOI: DATEENVOI ?? this.DATEENVOI,
      DATEREPONSE: DATEREPONSE ?? this.DATEREPONSE,
      POINTDEVENTE_ID: POINTDEVENTE_ID ?? this.POINTDEVENTE_ID,
      TYPEREQUETE_ID: TYPEREQUETE_ID ?? this.TYPEREQUETE_ID,
      COMMERCIAL_ID: COMMERCIAL_ID ?? this.COMMERCIAL_ID,
      SOLDE: SOLDE ?? this.SOLDE,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'OBJET': OBJET,
      'MESSAGE': MESSAGE,
      'PIECESJOINTES': PIECESJOINTES,
      'STATUT': STATUT,
      'REPONSE': REPONSE,
      'DATEENVOI': DATEENVOI,
      'DATEREPONSE': DATEREPONSE,
      'POINTDEVENTE_ID': POINTDEVENTE_ID,
      'TYPEREQUETE_ID': TYPEREQUETE_ID,
      'COMMERCIAL_ID': COMMERCIAL_ID,
      'SOLDE': SOLDE,
    };
  }

  factory Requet.fromMap(Map<String, dynamic> map) {
    return Requet(
      OBJET: map['OBJET'],
      MESSAGE: map['MESSAGE'],
      PIECESJOINTES: map['PIECESJOINTES'],
      STATUT: map['STATUT'],
      REPONSE: map['REPONSE'],
      DATEENVOI: map['DATEENVOI'],
      DATEREPONSE: map['DATEREPONSE'],
      POINTDEVENTE_ID: map['POINTDEVENTE_ID'],
      TYPEREQUETE_ID: map['TYPEREQUETE_ID'],
      COMMERCIAL_ID: map['COMMERCIAL_ID'],
      SOLDE: map['SOLDE'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Requet.fromJson(String source) => Requet.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Requet(OBJET: $OBJET, MESSAGE: $MESSAGE, PIECESJOINTES: $PIECESJOINTES, STATUT: $STATUT, REPONSE: $REPONSE, DATEENVOI: $DATEENVOI, DATEREPONSE: $DATEREPONSE, POINTDEVENTE_ID: $POINTDEVENTE_ID, TYPEREQUETE_ID: $TYPEREQUETE_ID, COMMERCIAL_ID: $COMMERCIAL_ID, SOLDE: $SOLDE)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Requet &&
      other.OBJET == OBJET &&
      other.MESSAGE == MESSAGE &&
      other.PIECESJOINTES == PIECESJOINTES &&
      other.STATUT == STATUT &&
      other.REPONSE == REPONSE &&
      other.DATEENVOI == DATEENVOI &&
      other.DATEREPONSE == DATEREPONSE &&
      other.POINTDEVENTE_ID == POINTDEVENTE_ID &&
      other.TYPEREQUETE_ID == TYPEREQUETE_ID &&
      other.COMMERCIAL_ID == COMMERCIAL_ID &&
      other.SOLDE == SOLDE;
  }

  @override
  int get hashCode {
    return OBJET.hashCode ^
      MESSAGE.hashCode ^
      PIECESJOINTES.hashCode ^
      STATUT.hashCode ^
      REPONSE.hashCode ^
      DATEENVOI.hashCode ^
      DATEREPONSE.hashCode ^
      POINTDEVENTE_ID.hashCode ^
      TYPEREQUETE_ID.hashCode ^
      COMMERCIAL_ID.hashCode ^
      SOLDE.hashCode;
  }
}
