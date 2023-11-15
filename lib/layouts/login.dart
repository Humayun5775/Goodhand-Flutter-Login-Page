import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:goodhand/Provider/user_fail_provider.dart';
import 'package:goodhand/Provider/user_success_provider.dart';
import 'package:goodhand/layouts/dashboard.dart';
import 'package:goodhand/middleware/api.dart';
import 'package:provider/provider.dart';
import '../globles.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.logo});
  final Widget logo;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  double size = 0;
  AnimationController? _controller;
  Animation<double>? _animation;
  String? number;
  String? password;
  bool isVisiblePassword = true;
  final _formKey = GlobalKey<FormState>();
  bool loading =false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      value: size,
    )..repeat(reverse: false);
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.linear, reverseCurve: Curves.linear);
    _controller!.forward();
  }

  @override
  void dispose() {
    if (_formKey.currentState != null) {
      _formKey.currentState!.dispose();
    }
    _controller!.dispose();
    _animation!.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: secondaryColor,
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(vertical: height * 0.05, horizontal: width * 0.1),
          child: ScaleTransition(
            scale: _animation!,
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Image.asset("assets/GoodHand.png", height: height * 0.2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign in to your account',
                      style: GoogleFonts.alegreya(color: tertiaryColor, fontWeight: FontWeight.bold, fontSize: 24.0, letterSpacing: 1.25),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.alegreya(color: tertiaryColor),
                    onSaved: (value) => number = value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.numbers, color: primaryColor),
                      hintText: '50xxxxxxx',
                      hintStyle: GoogleFonts.alegreya(color: primaryColor),
                      labelStyle: GoogleFonts.alegreya(color: primaryColor.withOpacity(0.8)),
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                    ),
                    cursorColor: primaryColor,
                    validator: (value) {
                      return null;
                    }
                    //   if (value == null || value.isEmpty) {
                    //     return 'Email Field can\'t be empty';
                    //   } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) == false) {
                    //     return 'Email format invalid';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  SizedBox(height: height * 0.025),
                  TextFormField(
                    onSaved: (value) => password = value,
                    style: GoogleFonts.alegreya(color: tertiaryColor),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: primaryColor),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisiblePassword = !isVisiblePassword;
                          });
                        },
                        icon: Icon(
                          isVisiblePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: primaryColor,
                        ),
                      ),
                      hintText: 'x23fDw#4',
                      labelText: 'Password',
                      hintStyle: GoogleFonts.alegreya(color: primaryColor),
                      labelStyle: GoogleFonts.alegreya(color: primaryColor.withOpacity(0.8)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                    ),
                    cursorColor: primaryColor,
                    obscureText: isVisiblePassword,
                    validator: (value) {
                        return null;

                    }
                      /*if (value == null || value.isEmpty) {
                        return 'Password Field can\'t be empty';
                      } else if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value) == false) {
                        return 'Password Must contain 8 characters and atleast one capital, small letter, special character and number';
                      } else {
                        return null;
                      }
                    },*/
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Forgot Password ?',
                        style: GoogleFonts.alegreya(
                          color:secondaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.025),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shadowColor: primaryColor,
                        primary: secondaryColor,
                        enableFeedback: true,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() =>loading =true);
                          await  AuthService().login(number!.trim(), password!, context);
                          setState(()=>loading=false);
                         if(Provider.of<UserSuccessProvider>(context, listen: false).getToken != null){
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashBoard()));
                         }else{
                           var snackBar = SnackBar(content: Text(Provider.of<UserfailProvider>(context,listen: false).getMessage));
                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                         }
                          /// enter your code for login process here and update below line as per your requirements
                          /// access value of your email and password by variables : 'email' and 'password' respectively
                        }
                      },
                      icon: loading? CircularProgressIndicator(): SizedBox(),
                      label: Text(
                        'Sign in',
                        style: GoogleFonts.alegreya(
                          color: tertiaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  //   child: Center(
                  //     child: RichText(
                  //       text: TextSpan(children: [
                  //         TextSpan(
                  //           text: 'Don\'t have  an account? ',
                  //           style: GoogleFonts.alegreya(
                  //             color: secondaryColor,
                  //           ),
                  //         ),
                  //         TextSpan(
                  //           text: 'Register Account',
                  //           style: GoogleFonts.alegreya(
                  //             color: primaryColor,
                  //             decoration: TextDecoration.underline,
                  //           ),
                  //           recognizer: TapGestureRecognizer()
                  //             ..onTap = () {
                  //               /// add signup page navigation code here.
                  //             },
                  //         ),
                  //       ]),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}