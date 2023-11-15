import 'package:flutter/cupertino.dart';

class UserfailProvider with ChangeNotifier {
  String? _message;

  setData(String m){
    _message = m;
    notifyListeners();
  }

  get getMessage => _message;
}