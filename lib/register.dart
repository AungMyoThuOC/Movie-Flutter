import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showpass = true;
  bool valid = false;

  bool sumbimt = false;

  bool check = false;

  bool isLoading = false;

  final _fromKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _fromKey,
        child: Center(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/movieflim.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     IconButton(
                //         onPressed: () {
                //           // Navigator.pushNamed(context, '/');
                //         },
                //         icon: Icon(
                //           Icons.arrow_back_ios_new,
                //           color: Colors.amber,
                //         )),
                //         IconButton(
                //           onPressed: (){},
                //           icon: Icon(
                //             Icons.menu_outlined
                //           )
                //         )
                //   ],
                // ),
                // SizedBox(
                //   height: 50,
                // ),
                // const Text(
                //   'Welcome to this Webside!',
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                // ),
                //  ClipRRect(
                //    child: Container(
                //      height: 200,
                //      decoration: const BoxDecoration(
                //        image: DecorationImage(
                //          image: AssetImage('images/cinema.jpg'),
                //          fit: BoxFit.fill,
                //        )
                //      ),
                //    ),
                //  ),
                // Image(
                //   width: 300,
                //   height: 300,
                //   image: AssetImage(
                //     'images/cinbg.png'
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
                  style: TextStyle(color: Colors.amber),
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
                            setState(() {
                              sumbimt = true;
                              isLoading = true;
                            });
                            await Future.delayed(const Duration(seconds: 3));
                            if (_fromKey.currentState!.validate()) {
                              try {
                                final auth = FirebaseAuth.instance;

                                final newUser =
                                    await auth.createUserWithEmailAndPassword(
                                        email: usernameController.text,
                                        password: passwordController.text);

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                prefs.setString('UserID', newUser.user!.uid);

                                setState(() {
                                  isLoading = false;
                                  Navigator.pushNamed(context, '/login');
                                  usernameController.clear();
                                  passwordController.clear();
                                });
                              } catch (e) {
                                isLoading = false;
                              }
                            }
                            //
                            //   final usernameValid =
                            //       _fromKey.currentState!.validate();
                            //   if (usernameValid) {
                            //     try {
                            //       final _auth = FirebaseAuth.instance;

                            //       final newUser =
                            //           await _auth.createUserWithEmailAndPassword(
                            //               email: usernameController.text,
                            //               password: passwordController.text);
                            //     } catch (e) {
                            //       print(e);
                            //     }
                            //   }
                            //   setState(() {
                            //     sumbimt = true;
                            //   });
                            //   if (_fromKey.currentState!.validate()) {
                            //     SharedPreferences prefs =
                            //         await SharedPreferences.getInstance();
                            //     prefs.setString(
                            //         'userValue', usernameController.text);
                            //     prefs.setString(
                            //         'passValue', passwordController.text);
                            //     setState(() {
                            //       Navigator.pushNamed(context, '/login');
                            //       usernameController.clear();
                            //       passwordController.clear();
                            //     });
                            //   }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(235, 229, 60, 60)),
                          child: (isLoading)
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1.5,
                                  ),
                                )
                              : const Text("Register")),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Existing user?",
                      style: TextStyle(color: Colors.amber),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'login',
                          style: TextStyle(
                            color: Colors.amberAccent,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
