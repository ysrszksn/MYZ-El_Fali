import 'package:flutter/material.dart';
import 'package:myz_el_fali/desing/context_extension.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myz_el_fali/screens/register.dart';
import 'package:myz_el_fali/services/auth.dart';
import 'package:myz_el_fali/varaible/varaible.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GoogleSignInAccount? _currentUser;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthService _authService = AuthService();

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildWidget());
  }

  Widget _buildWidget() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.1)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("data"),
              ElevatedButton(
                  onPressed: () {
                    signOut();
                  },
                  child: Text("çık"))
            ]),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.1)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name),
              Expanded(flex: 0, child: buildTextname()),
              SizedBox(
                height: 20,
              ),
              Expanded(flex: 0, child: buildTextpass()),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 0,
                child: buildSignButton(context),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 0,
                child: buildSignWithGoogleButton(context),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 0,
                child: buildRegisterButton(context),
              ),
            ]),
      );
    }
  }

  Row buildSignOutButton() {
    return Row(
      children: [
        ElevatedButton(onPressed: signOut, child: const Text('Çıkış')),
      ],
    );
  }

  Row buildGoogleUserAvatar(GoogleSignInAccount user) {
    return Row(
      children: [
        ListTile(
          leading: GoogleUserCircleAvatar(identity: user),
          title: Text(
            user.displayName ?? '',
            style: TextStyle(fontSize: 22),
          ),
          subtitle: Text(user.email, style: TextStyle(fontSize: 22)),
        ),
      ],
    );
  }

  Row buildSignButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _authService
                .signIn(_emailController.text, _passwordController.text)
                .then((value) {
              if (errl == "Hata") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(title: new Text("Yanlış giriş"));
                    });
                errl = "";
              } else {
                return Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              }
            });
          },
          child: Text("Giriş Yap"),
          style: ElevatedButton.styleFrom(
            minimumSize:
                Size(context.dynamicWidth(0.5), context.dynamicHeight(0.05)),
          ),
        )
      ],
    );
  }

  Row buildRegisterButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
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

  Row buildSignWithGoogleButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            signIn();
          },
          child: Text("Google İle Giriş Yap"),
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
              labelText: 'Enter your username',
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

  void signOut() {
    _googleSignIn.disconnect();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print('Error signing in $e');
    }
  }
}
