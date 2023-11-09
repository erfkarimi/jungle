import 'package:flutter/material.dart';
import 'package:jungle/model/text_field_model/text_field_model.dart';

class TextFieldValidation with ChangeNotifier{
  TextFieldModel _textFieldModel = TextFieldModel(null);

  // Getter
  TextFieldModel get textFieldModel => _textFieldModel;

  bool get isValid => textFieldModel.value != null ? true : false;

  // Setter
  void todoTextFieldTitleChange(String value){
    if(value.isNotEmpty){
      _textFieldModel = TextFieldModel(value);
    } else {
      _textFieldModel = TextFieldModel(null);
    }
    notifyListeners();
  }

}