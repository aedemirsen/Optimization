import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimization/auth_services.dart';
import 'package:optimization/optimization.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late String _warning;
  late Color _edge;
  late double _borderWidth;

  @override
  void initState() {
    _warning = '';
    _edge = Colors.black;
    _borderWidth = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent.withOpacity(0.7),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                '1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: 200,
              ),
              child: Text(
                'PROFİL OPTİMİZASYON SİSTEMİ',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                width: 400,
                height: 320,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 40),
                        child: Align(
                          child: Text('Kullanıcı Adı'),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                          right: 20,
                        ),
                        child: CupertinoTextField(
                          controller: emailController,
                          onSubmitted: (text) {},
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontFamily: 'Arial',
                          ),
                          prefix: const Padding(
                            padding: EdgeInsets.fromLTRB(15.0, 8, 8, 8),
                            child: Icon(
                              Icons.email,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _edge,
                              width: _borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Align(
                          child: Text('Parola'),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                          right: 20,
                        ),
                        child: CupertinoTextField(
                          controller: passwordController,
                          onSubmitted: (text) {},
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(
                            fontFamily: 'Arial',
                          ),
                          prefix: const Padding(
                            padding: EdgeInsets.fromLTRB(15.0, 8, 8, 8),
                            child: Icon(
                              Icons.vpn_key,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _edge,
                              width: _borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 40,
                          left: 20,
                          right: 20,
                        ),
                        child: SizedBox(
                          width: 360,
                          child: CupertinoButton(
                            onPressed: () {
                              String email = emailController.text,
                                  password = passwordController.text;
                              if (email.isNotEmpty && password.isNotEmpty) {
                                Authentication()
                                    .signInWithEmail(
                                        mail: email, password: password)
                                    .then((user) {
                                  try {
                                    print(user!.email);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Optimization(email: user.email),
                                      ),
                                      (route) => false,
                                    );
                                    print("başarılı giriş");
                                  } catch (e) {
                                    setState(() {
                                      _warning =
                                          'Kullanıcı adı ve ya parola yanlış!';
                                      _edge = Colors.red;
                                      _borderWidth = 2;
                                    });
                                    print("HATA! - " + e.toString());
                                  }
                                });
                              } else {
                                setState(() {
                                  _warning =
                                      'Kullanıcı adı ve ya parola yanlış!';
                                  _edge = Colors.red;
                                  _borderWidth = 2;
                                });
                                print("kullanıcı bilgileri yanlış.");
                                print(email);
                                print(password);
                              }
                            },
                            child: const Text(
                              'GİRİŞ',
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 16,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 0,
                            ),
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          _warning,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
