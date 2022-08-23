import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showpass = true;
  bool valid = false;

  bool submit = false;

  bool check = false;

  bool isLoading = false;

  final _fromKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal,
      body: Form(
        key: _fromKey,
        child: Center(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/logmove.jpg'),
                    fit: BoxFit.cover)),
            // child: Container(
            //   width: double.infinity,
            //   child: SingleChildScrollView(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     IconButton(onPressed: onPressed, icon: icon)
            // ],)
            // ],
            //     ),
            //   ),
            // )
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to this Webside!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
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
                  style: const TextStyle(color: Colors.amber),
                  cursorColor: Colors.amber,
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
                          borderSide: BorderSide(color: Colors.amber)),
                      labelStyle: TextStyle(
                        color: Colors.amber,
                      ),
                      labelText: "Username",
                      hintText: "Enter your username",
                      hintStyle: TextStyle(color: Colors.amber),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.amber,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.amber
                  ),
                  cursorColor: Colors.amber,
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
                          borderSide: BorderSide(color: Colors.amber)),
                      labelStyle: const TextStyle(color: Colors.amber),
                      labelText: "Password",
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: Colors.amber),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.amber,
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
                                  color: Colors.amber,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.amber,
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
                            final prefs = await SharedPreferences.getInstance();
                            final String? username = prefs.getString('UserID');
                            setState(() {
                              submit = true;
                              isLoading = true;
                              print('$username');
                            });
                            if (_fromKey.currentState!.validate()) {
                              try {
                                final auth = FirebaseAuth.instance;
                                UserCredential currentUser =
                                    await auth.signInWithEmailAndPassword(
                                        email: usernameController.text,
                                        password: passwordController.text);
                                print(currentUser.user!.uid);
                                if (currentUser.user!.uid != null) {
                                  isLoading = false;
                                  // ignore: use_build_context_synchronously
                                  // Navigator.popUntil(
                                  // context, ModalRoute.withName('/'));
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacementNamed(
                                      context, '/movie');
                                  usernameController.clear();
                                  passwordController.clear();
                                }
                              } on FirebaseException catch (e) {
                                if (e.code == 'user-not-found') {
                                  errorMessage =
                                      'No user found with this E-mail';
                                } else if (e.code == 'wrong-password') {
                                  errorMessage = ' Wrong password !';
                                } else {
                                  errorMessage = e.code;
                                }
                                setState(() {
                                  isLoading = false;
                                });
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(errorMessage),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 1)));
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(e.toString()),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 1)));
                              }
                            }
                            //
                            // final prefs = await SharedPreferences.getInstance();
                            // final String? username =
                            //     prefs.getString('username');
                            // final String? password =
                            //     prefs.getString("password");
                            // final loginValidate =
                            //     _fromKey.currentState!.validate();

                            // if (loginValidate) {
                            //   try {
                            //     final _auth = FirebaseAuth.instance;

                            //     UserCredential currentUser =
                            //         await _auth.signInWithEmailAndPassword(
                            //             email: usernameController.text,
                            //             password: passwordController.text);
                            //   } catch (e) {
                            //     print(e.toString());
                            //   } finally {
                            //     Navigator.pushReplacementNamed(
                            //         context, "/movie");
                            //   }
                            // }
                            // if (usernameController.text == username &&
                            //     passwordController.text == password) {
                            //   usernameController.clear();
                            //   passwordController.clear();
                            // } else {
                            //   if (usernameController.text.isNotEmpty &&
                            //       passwordController.text.isNotEmpty) {
                            //     var snackBar = const SnackBar(
                            //       backgroundColor: Colors.red,
                            //       duration: Duration(seconds: 1),
                            //       content: Text("Invalid email or password"),
                            //     );
                            //     ScaffoldMessenger.of(context)
                            //         .showSnackBar(snackBar);
                            //   } else {
                            //     Container();
                            //   }
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(235, 229, 60, 60)),
                          child: (isLoading)
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1.5,
                                  ),
                                )
                              : const Text("Login")),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
