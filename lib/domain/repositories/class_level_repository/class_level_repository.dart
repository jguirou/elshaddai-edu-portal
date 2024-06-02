import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/resource.dart';
import '../../entities/class_level/class_level.dart';

class ClassLevelRepository {
  final _db = FirebaseFirestore.instance;

  /// -- Get class level
  Future<Resource<List<String>>> getAllClassLevels() async {
    try {
      final snapshot = await _db.collection('ClassLevel').get();

      List<String> classLevelsList = [];

      for (var document in snapshot.docs) {
        final classLevel = ClassLevel.fromSnapshot(document);

        if (classLevel.jardin != null) {
          classLevelsList.addAll(classLevel.jardin!.values);
        }
        if (classLevel.premierCycle != null) {
          classLevelsList.addAll(classLevel.premierCycle!.values);
        }
        if (classLevel.secondCycle != null) {
          classLevelsList.addAll(classLevel.secondCycle!.values);
        }
      }

      return Resource.success(classLevelsList);
    } catch (e) {
      print("Error when getting class levels: $e");
      return Resource.error("Error: $e");
    }
  }

  Stream<Resource<List<String>>> getAllClassLevelsStream() async* {
    try {
      final result = await getAllClassLevels();

      if (result is Success<List<String>>) {
        yield Resource.success(result.data);
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }

}
