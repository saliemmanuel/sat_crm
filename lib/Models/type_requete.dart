import 'dart:convert';

class TypeRequete {
  final int ID;
  final String NOM;
  final String DESCRIPTION;
  final String created_at;
  final String updated_at;
  TypeRequete({
    required this.ID,
    required this.NOM,
    required this.DESCRIPTION,
    required this.created_at,
    required this.updated_at,
  });

  TypeRequete copyWith({
    int? ID,
    String? NOM,
    String? DESCRIPTION,
    String? created_at,
    String? updated_at,
  }) {
    return TypeRequete(
      ID: ID ?? this.ID,
      NOM: NOM ?? this.NOM,
      DESCRIPTION: DESCRIPTION ?? this.DESCRIPTION,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'NOM': NOM,
      'DESCRIPTION': DESCRIPTION,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory TypeRequete.fromMap(Map<String, dynamic> map) {
    return TypeRequete(
      ID: map['ID']?.toInt() ?? 0,
      NOM: map['NOM'] ?? '',
      DESCRIPTION: map['DESCRIPTION'] ?? '',
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeRequete.fromJson(String source) =>
      TypeRequete.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TypeRequete(ID: $ID, NOM: $NOM, DESCRIPTION: $DESCRIPTION, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TypeRequete &&
        other.ID == ID &&
        other.NOM == NOM &&
        other.DESCRIPTION == DESCRIPTION &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return ID.hashCode ^
        NOM.hashCode ^
        DESCRIPTION.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
