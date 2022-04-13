import 'package:flutter/material.dart';
import 'package:myz_el_fali/desing/context_extension.dart';
import 'package:myz_el_fali/screens/login.dart';
import 'package:myz_el_fali/services/auth.dart';
import 'package:myz_el_fali/varaible/varaible.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.1)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 0, child: buildTextname()),
              SizedBox(
                height: 20,
              ),
              Expanded(flex: 0, child: buildTextpass()),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 0,
                child: buildRegisterButton(context),
              ),
            ]),
      ),
    );
  }

  Row buildRegisterButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _authService
                .createPerson(_emailController.text, _passwordController.text)
                .then((value) {
              if (errl == "Hata") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(title: new Text("Boş bırakılmaz"));
                    });
                errl = "";
              } else {
                return Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              }
            });
          },
          child: Text("Üye Ol"),
          style: ElevatedButton.styleFrom(
            minimumSize:
                Size(context.dynamicWidth(0.5), context.dynamicHeight(0.05)),
          ),
        )
      ],
    );
  }

  Row buildTextname() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your mail',
            ),
          ),
        )
      ],
    );
  }

  Row buildTextpass() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your pass',
            ),
          ),
        )
      ],
    );
  }
}
