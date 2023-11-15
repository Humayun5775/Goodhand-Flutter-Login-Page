import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../Provider/user_fail_provider.dart';
import '../Provider/user_success_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthService {
  static const apiUrl = "http://192.168.18.137:3000/user/login";

   Future login(String phone, String password, BuildContext context) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'number': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successful login
      var data1 = json.decode(response.body);
      Provider.of<UserSuccessProvider>(context, listen: false).setData(data1["token"], data1["message"]);
      return ;
    } else {
      // Login failed
      var data1 = json.decode(response.body);
      Provider.of<UserfailProvider>(context, listen: false).setData(data1["message"]);

      return ;
    }
  }
}
