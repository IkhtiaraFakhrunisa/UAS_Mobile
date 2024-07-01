// view_models/detail_view_model.dart
import 'package:flutter/material.dart';
import 'model_character.dart';

class DetailViewModel extends ChangeNotifier {
  late Character character;

  void setCharacter(Map<String, dynamic> data) {
    character = Character.fromJson(data);
    notifyListeners();
  }
}
