import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showpass = true;
  bool Valid = false;

  bool _sumbimt = false;

  bool check = false;

  final _formKey = GlobalKey<FormState>();
  
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to this Webside!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                // ClipRRect(
                //   child: Container(
                //     height: 200,
                //     decoration: const BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage('images/'),
                //         fit: BoxFit.fill,
                //       )
                //     ),
                //   ),
                // ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: usernameController,
                  validator: (user) {
                    if (user == null || user.isEmpty) {
                      return "Username can't be blank";
                    } else if (user.length < 6) {
                      return "Username  should be more than 6 word";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyanAccent)),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      labelText: "Username",
                      hintText: "Enter your username",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: passwordController,
                  obscuringCharacter: "*",
                  obscureText: showpass,
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return "Password can't be blank";
                    } else if (password.length < 6) {
                      return "Password should be 6 word";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyanAccent)),
                      labelStyle: const TextStyle(color: Colors.grey),
                      labelText: "Password",
                      hintText: "Enter your password",
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showpass = !showpass;
                            });
                          },
                          splashRadius: 5,
                          icon: showpass
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ))),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _sumbimt = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  'userValue', usernameController.text);
                              prefs.setString(
                                  'passValue', passwordController.text);
                              setState(() {
                                Navigator.pushNamed(context, '/movie');
                              });
                            }
                          },
                          child: const Text("LogIN")),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
