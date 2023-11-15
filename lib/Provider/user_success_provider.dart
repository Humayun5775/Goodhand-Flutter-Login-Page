import 'package:flutter/cupertino.dart';

class UserSuccessProvider with ChangeNotifier {
  String? _token;
  String? _message;

  setData(String t,String m){
    _token = t;
    _message = m;
    notifyListeners();
  }

  get getToken =>  _token;
  get getMessage => _message;
}