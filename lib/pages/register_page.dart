import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                // decoration: BoxDecoration(color: Color(0xff113A2D)),
                decoration: BoxDecoration(color: Colors.red),
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
                    ],
                  ),
                ),
              ),

              // Column(
              //   children: [
              //     TextFormField(
              //       controller: _emailController,
              //       decoration: InputDecoration(
              //         labelText: "Correo electrónico",
              //       ),
              //       keyboardType: TextInputType.emailAddress,
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return "Ingrese su correo electrónico";
              //         }
              //         if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.trim())) {
              //           return "Ingrese un correo válido";
              //         }
              //         return null;
              //       },
              //     ),
              //     TextFormField(
              //       controller: _passwordController,
              //       decoration: InputDecoration(
              //         labelText: "Ingresa la contaseña",
              //       ),
              //       obscureText: true,
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return "Ingrese su correo electrónico";
              //         }
              //         if (value.trim().length < 6) {
              //           return "La contraseña debe contener al menos 6 caracteres";
              //         }
              //         return null;
              //       },
              //     ),
              //     ElevatedButton(onPressed: () {}, child: Text("Registrar")),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
