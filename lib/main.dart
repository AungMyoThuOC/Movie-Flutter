import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:top_rate_movie/login.dart';
import 'package:top_rate_movie/screens/search_page.dart';
import 'package:top_rate_movie/signin.dart';
import 'register.dart';
import 'login.dart';
import '../pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Future main() async {
//   await DotEnv().load('.env');
//   runApp(MyApp());
// }

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  // int _selectedIndex = 0;
  // final List<Widget> _childWidgets = [MyHomePage(), SearchMovies()];

  // _onItemTapped(int index) {
  //   setState(() {
  //     this._selectedIndex = index;
  //   });
  // }

  // @override
  // bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SigninPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/movie': (context) => MoviePage(),
        '/search' :(context) => const GetSearch(),
      },
      title: 'Movie Zone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink[200],
        //   primarySwatch: Colors.grey,
        //   scaffoldBackgroundColor: Colors.grey
      ),
      // home: Scaffold(
      //     body: _childWidgets[_selectedIndex],
      //     bottomNavigationBar: BottomNavigationBar(
      //       type: BottomNavigationBarType.fixed,
      //       items: <BottomNavigationBarItem>[
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.home),
      //           label: 'Home',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.search),
      //           label: 'Search',
      //         ),
      //       ],
      //       selectedItemColor: Colors.pink[200],
      //       currentIndex: _selectedIndex,
      //       onTap: _onItemTapped,
      //     )),
    );
  }
}
