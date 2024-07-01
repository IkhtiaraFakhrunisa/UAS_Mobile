import 'package:flutter/material.dart';
import 'package:harry_potter_app/domain/local_storage.dart';
import 'package:harry_potter_app/screen/detail.dart';
import 'package:harry_potter_app/screen/home.dart';
import 'package:harry_potter_app/screen/splash.dart';
import 'package:harry_potter_app/screen/login.dart';
import 'package:harry_potter_app/screen/signup.dart';
import 'package:harry_potter_app/screen/user_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harry Potter App',
      theme: ThemeData(
        primaryColor: Color(0xFF641e1e),
        hintColor: Color(0xFFc39a1c),
        scaffoldBackgroundColor: Color(0xFFefeee9),
        fontFamily: 'HarryP',
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF3d2f22)),
          bodyMedium: TextStyle(color: Color(0xFF3d2f22)),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF641e1e),
          titleTextStyle: TextStyle(color: Color(0xFFefeee9), fontFamily: 'HarryP', fontSize: 24),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Color(0xFFc39a1c)),
            foregroundColor: WidgetStateProperty.all(Color(0xFF3d2f22)),
            textStyle: WidgetStateProperty.all(TextStyle(fontFamily: 'HarryP')),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3d2f22)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFc39a1c)),
          ),
          labelStyle: TextStyle(color: Color(0xFF3d2f22), fontFamily: 'HarryP'),
        ),
      ),
      initialRoute: '/splash',
      routes: <String, WidgetBuilder>{
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/detail': (context) => DetailScreen(character: {}),
        '/profile': (context) => UserProfilePage(userId: 1,), // Replace with actual user ID
      },
    );
  }
}
