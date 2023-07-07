import 'dart:convert';

class PointDeVente {
  final int? id;
  final String NOMPOINTVENTE;
  final String NUMCOMMERCIAL;
  final String LOCALISATION;
  final String ACTIVE;
  final String LATITUDE;
  final String LONGITUDE;
  final String TPDV;
  final String MICRO;
  final String DOSSIER;
  PointDeVente({
    this.id,
    required this.NOMPOINTVENTE,
    required this.NUMCOMMERCIAL,
    required this.LOCALISATION,
    required this.ACTIVE,
    required this.LATITUDE,
    required this.LONGITUDE,
    required this.TPDV,
    required this.MICRO,
    required this.DOSSIER,
  });

  PointDeVente copyWith({
    int? id,
    String? NOMPOINTVENTE,
    String? NUMCOMMERCIAL,
    String? LOCALISATION,
    String? ACTIVE,
    String? LATITUDE,
    String? LONGITUDE,
    String? TPDV,
    String? MICRO,
    String? DOSSIER,
  }) {
    return PointDeVente(
      id: id ?? this.id,
      NOMPOINTVENTE: NOMPOINTVENTE ?? this.NOMPOINTVENTE,
      NUMCOMMERCIAL: NUMCOMMERCIAL ?? this.NUMCOMMERCIAL,
      LOCALISATION: LOCALISATION ?? this.LOCALISATION,
      ACTIVE: ACTIVE ?? this.ACTIVE,
      LATITUDE: LATITUDE ?? this.LATITUDE,
      LONGITUDE: LONGITUDE ?? this.LONGITUDE,
      TPDV: TPDV ?? this.TPDV,
      MICRO: MICRO ?? this.MICRO,
      DOSSIER: DOSSIER ?? this.DOSSIER,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'NOMPOINTVENTE': NOMPOINTVENTE,
      'NUMCOMMERCIAL': NUMCOMMERCIAL,
      'LOCALISATION': LOCALISATION,
      'ACTIVE': ACTIVE,
      'LATITUDE': LATITUDE,
      'LONGITUDE': LONGITUDE,
      'TPDV': TPDV,
      'MICRO': MICRO,
      'DOSSIER': DOSSIER,
    };
  }

  factory PointDeVente.fromMap(Map<String, dynamic> map) {
    return PointDeVente(
      id: map['id']?.toInt(),
      NOMPOINTVENTE: map['NOMPOINTVENTE'] ?? '',
      NUMCOMMERCIAL: map['NUMCOMMERCIAL'] ?? '',
      LOCALISATION: map['LOCALISATION'] ?? '',
      ACTIVE: map['ACTIVE'] ?? '',
      LATITUDE: map['LATITUDE'] ?? '',
      LONGITUDE: map['LONGITUDE'] ?? '',
      TPDV: map['TPDV'] ?? '',
      MICRO: map['MICRO'] ?? '',
      DOSSIER: map['DOSSIER'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PointDeVente.fromJson(String source) =>
      PointDeVente.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PointDeVente(id: $id, NOMPOINTVENTE: $NOMPOINTVENTE, NUMCOMMERCIAL: $NUMCOMMERCIAL, LOCALISATION: $LOCALISATION, ACTIVE: $ACTIVE, LATITUDE: $LATITUDE, LONGITUDE: $LONGITUDE, TPDV: $TPDV, MICRO: $MICRO, DOSSIER: $DOSSIER)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PointDeVente &&
        other.id == id &&
        other.NOMPOINTVENTE == NOMPOINTVENTE &&
        other.NUMCOMMERCIAL == NUMCOMMERCIAL &&
        other.LOCALISATION == LOCALISATION &&
        other.ACTIVE == ACTIVE &&
        other.LATITUDE == LATITUDE &&
        other.LONGITUDE == LONGITUDE &&
        other.TPDV == TPDV &&
        other.MICRO == MICRO &&
        other.DOSSIER == DOSSIER;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        NOMPOINTVENTE.hashCode ^
        NUMCOMMERCIAL.hashCode ^
        LOCALISATION.hashCode ^
        ACTIVE.hashCode ^
        LATITUDE.hashCode ^
        LONGITUDE.hashCode ^
        TPDV.hashCode ^
        MICRO.hashCode ^
        DOSSIER.hashCode;
  }
}
