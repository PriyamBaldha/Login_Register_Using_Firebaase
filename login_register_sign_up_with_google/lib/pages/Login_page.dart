import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_auth_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signINFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();

  final TextEditingController emailsignINController = TextEditingController();
  final TextEditingController PasswordsignINController =
      TextEditingController();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                alignment: Alignment.center,
                child: Form(
                  key: signINFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: TextFormField(
                                controller: emailsignINController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  return (val!.isEmpty)
                                      ? "Enter your email first"
                                      : null;
                                },
                                onSaved: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email Address",
                                    hintStyle: TextStyle(color: Colors.black)),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: PasswordsignINController,
                                obscureText: true,
                                validator: (val) {
                                  return (val!.isEmpty)
                                      ? "Enter your password first"
                                      : null;
                                },
                                onSaved: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.black)),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          if (signINFormKey.currentState!.validate()) {
                            signINFormKey.currentState!.save();
                            User? user = await FirebaseAuthHelper
                                .firebaseAuthHelper
                                .SignINUser(email: email!, password: password!);
                            // ignore: duplicate_ignore
                            if (user != null) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Login Successful\nID: ${user.uid}"),
                                  backgroundColor: Colors.teal,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pushReplacementNamed(
                                  'HomePage',
                                  arguments: user);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Login Failed"),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                            email = "";
                            password = "";
                            emailsignINController.clear();
                            PasswordsignINController.clear();
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff858bf3),
                                Colors.teal.shade200,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () async {
                          User? user = await FirebaseAuthHelper
                              .firebaseAuthHelper
                              .SignWithGoogle();
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Login Successful\nID: ${user.uid}"),
                                backgroundColor: Colors.teal,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.of(context).pushReplacementNamed(
                                'HomePage',
                                arguments: user);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Failed"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/images/google.png",
                                scale: 30,
                              ),
                            ),
                            const Text(
                              "Signing with Google",
                              style: TextStyle(
                                color: Color(0xff777be7),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have any account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            onPressed: validateAndSignUpUser,
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff777be7),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          User? user = await FirebaseAuthHelper
                              .firebaseAuthHelper
                              .SignInAnonymously();
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Login Successful\nID: ${user.uid}"),
                                backgroundColor: Colors.teal,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.of(context).pushReplacementNamed(
                                'HomePage',
                                arguments: user);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Failed"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Anonymous Login",
                          style: TextStyle(
                            color: Color(0xff777be7),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateAndSignUpUser() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text("Sign UP"),
        ),
        content: Form(
          key: signUpFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: emailController,
                validator: (val) =>
                    (val!.isEmpty) ? "Enter email First..." : null,
                onSaved: (val) {
                  email = val;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Enter email here..."),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: PasswordController,
                obscureText: true,
                validator: (val) =>
                    (val!.isEmpty) ? "Enter password First..." : null,
                onSaved: (val) {
                  password = val;
                },
                //keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Enter password here..."),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              child: const Text("Sign UP"),
              onPressed: () async {
                if (signUpFormKey.currentState!.validate()) {
                  signUpFormKey.currentState!.save();

                  User? user = await FirebaseAuthHelper.firebaseAuthHelper
                      .SignUPUser(email: email!, password: password!);

                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("sign Up Successfull\nUID : ${user.uid}"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Sign Up Failed "),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }

                  emailController.clear();
                  PasswordController.clear();

                  setState(() {
                    email = "";
                    password = "";
                  });

                  Navigator.of(context).pop();
                }
              }),
          OutlinedButton(
            onPressed: () {
              emailController.clear();
              PasswordController.clear();

              setState(() {
                email = "";
                password = "";
              });

              Navigator.of(context).pop();
            },
            child: const Text("Cancle"),
          ),
        ],
      ),
    );
  }
}
