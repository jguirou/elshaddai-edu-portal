import 'dart:convert';
import 'package:flutter/services.dart';

class FirebaseConfig {
  static String databaseURL = '';
  static String apiKey = '';
  static String appId = '';
  static String messagingSenderId = '';
  static String projectId = '';

  static Future<void> load() async {
    try {
      String configString = await rootBundle.loadString('assets/firebase_config.json');
      Map<String, dynamic> config = json.decode(configString);
      databaseURL = config['databaseURL'];
      apiKey = config['apiKey'];
      appId = config['appId'];
      messagingSenderId = config['messagingSenderId'];
      projectId = config['projectId'];
    } catch (e) {
      print('Error loading Firebase config: $e');
    }
  }
}
