import 'package:cloud_firestore/cloud_firestore.dart';

class ClassLevel {
  final Map<String, String>? jardin;
  final Map<String, String>? premierCycle;
  final Map<String, String>? secondCycle;

  const ClassLevel( {
     this.jardin,
     this.premierCycle,
     this.secondCycle,
  });

  /// Empty helper function


  factory ClassLevel.fromJson(Map<String, dynamic> json) {
    return ClassLevel(

      jardin: json['jardin'] != null
          ? Map<String, String>.from(json['jardin'])
          : null,
      premierCycle: json['premierCycle'] != null
          ? Map<String, String>.from(json['premierCycle'])
          : null,
      secondCycle: json['secondCycle'] != null
          ? Map<String, String>.from(json['secondCycle'])
          : null,
    );
  }

  // Method to convert Student instance to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'jardin': jardin,
      'premierCycle': premierCycle,
      'secondCycle': secondCycle
    };
  }

  factory ClassLevel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return ClassLevel(

      jardin: data['jardin'] != null
          ? Map<String, String>.from(data['jardin'])
          : null,

      premierCycle: data['premierCycle'] != null
          ? Map<String, String>.from(data['premierCycle'])
          : null,
      secondCycle: data['secondCycle'] != null
          ? Map<String, String>.from(data['secondCycle'])
          : null,
    );
  }

  ClassLevel copyWith({
    Map<String, String>? jardin,
    Map<String, String>? premierCycle,
    Map<String, String>? secondCycle,
  }) {
    return ClassLevel(
      jardin: jardin ?? this.jardin,
      premierCycle: premierCycle ?? this.premierCycle,
      secondCycle: secondCycle ?? this.secondCycle,
    );
  }
}


