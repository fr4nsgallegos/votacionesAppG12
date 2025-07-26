import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:votacionesappg12/pages/auth_service.dart';
import 'package:votacionesappg12/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  Widget _buildField({
    required String label,
    required String hint,
    bool isPassword = false,
    bool isEmail = false,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.orange,
        style: TextStyle(fontWeight: FontWeight.bold),
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Ingrese su $label";
          }
          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.trim()) && isEmail) {
            return "Ingrese un correo válido";
          }
          if (value.trim().length < 6 && isPassword) {
            return "La contraseña debe contener al menos 6 caracteres";
          }
          return null;
        },
      ),
    );
  }

  // Future<void> _signInWithGoogle() async {
  //   try {
  //     GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleUser.authentication;
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );

  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .signInWithCredential(credential);
  //       User? user = userCredential.user;
  //       print("--------------------------------");
  //       print(user);
  //       print("--------------------------------");
  //     }
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeigth,
            width: screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff113A2D), Colors.white],
                stops: [0.5, 0.5],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  bottomRight: Radius.circular(50),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: screenHeigth / 2 - 24,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://images.pexels.com/photos/697244/pexels-photo-697244.jpeg?_gl=1*1thf7bk*_ga*ODI4MzUxMDczLjE3MjI2NDc0MzI.*_ga_8JE65Q40S6*czE3NTM0OTAzMjQkbzU3JGcxJHQxNzUzNDkwMzQzJGo0MSRsMCRoMA..",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: screenHeigth / 2 - 24,
                      color: Color(0xff113A2D).withOpacity(0.7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Color(0xffF6BA3D),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.abc,
                              color: Colors.white,
                              size: 80,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Bienvenido de nuevo!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                height: screenHeigth / 2 + 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                ),
                child: Column(
                  children: [
                    _buildField(
                      label: "Correo electrónico",
                      hint: "Ingresa el correo",
                      controller: _emailController,
                    ),
                    _buildField(
                      label: "Contraseña",
                      hint: "Ingresa la contraseña",
                      controller: _passwordController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            Text(
                              "Recordar",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("¿Olvidaste la contraseña?"),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff6F9675),
                        ),
                        onPressed: () {
                          AuthService.loginWithEmailPassword(
                            _emailController.text,
                            _passwordController.text,
                            context,
                          );
                        },
                        child: Text(
                          "INICIAR SESIÓN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No tienes una cuenta?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text("CREA UNA"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Ó inicia sesión con"),
                        ElevatedButton(
                          onPressed: () {
                            // _signInWithGoogle();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                          ),
                          child: Icon(Icons.g_mobiledata, weight: 50),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
