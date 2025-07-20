import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:votacionesappg12/pages/auth_service.dart';
import 'package:votacionesappg12/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();

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

  Future<void> regiter() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = await AuthService.registerWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );

        if (user != null) {
          print("USUARIO CREADO");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error al registrar usuario")));
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${e.message}")));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Otro tipo de error: ${e.toString()}")),
        );
      }
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    double heigthScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                height: heigthScreen,
                width: widthScreen,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff113A2D), Colors.white],
                    stops: [0.5, 0.5],
                  ),
                ),
                // decoration: BoxDecoration(color: Colors.red),
                child: SingleChildScrollView(
                  child: Column(
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
                              height: heigthScreen / 7,
                              color: Color(0xff113A2D),
                              padding: EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orangeAccent,
                                    ),
                                    child: Icon(
                                      Icons.keyboard_arrow_left_outlined,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "Create account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 32,
                          horizontal: 40,
                        ),
                        height: heigthScreen - 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            _buildField(
                              label: "Nombre",
                              hint: "Ingresa tu nombre",
                              controller: _nameController,
                            ),
                            _buildField(
                              label: "Correo electrónico",
                              hint: "Ingresa el correo",
                              controller: _emailController,
                              isEmail: true,
                            ),
                            _buildField(
                              label: "Teléfono",
                              hint: "Ingresa tu contacto",
                              controller: _phoneController,
                            ),
                            _buildField(
                              label: "Fecha de cumpleaños",
                              hint: "Ingresa tu nacimiento",
                              controller: _birthController,
                              isPassword: true,
                            ),
                            _buildField(
                              label: "Contraseña",
                              hint: "Ingresa la contraseña",
                              controller: _passwordController,
                              isPassword: true,
                            ),

                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff6E9774),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  regiter();
                                },
                                child: Text(
                                  "REGÍSTRATE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 35),
                            RichText(
                              text: TextSpan(
                                text: "Si ya tienes una cuenta  ",
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "INICIA SESIÓN",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xff113A2D),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
