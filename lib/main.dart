import 'package:flutter/material.dart';
import 'package:goodhand/Provider/user_fail_provider.dart';
import 'package:goodhand/Provider/user_success_provider.dart';
import 'middleware/api.dart';
import 'globles.dart';
import 'layouts/login.dart';
import 'package:provider/provider.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ ChangeNotifierProvider(
          create: (context) => UserSuccessProvider()),
        ChangeNotifierProvider(
            create: (context) => UserfailProvider()), ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue, primaryColor: Colors.red),
        home: Login(logo: SizedBox()),
      ),
    );
  }
}

