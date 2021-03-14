import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import './providers/tasks.dart';

void main() {
  //aligning the system navigation bar color with the apps primary color
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.amber[400],
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Tasks())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          //containers and cards will use the backgroundColor property
          backgroundColor: Colors.white,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueGrey[700],
          ),
          hintColor: Colors.blueGrey[700],
          scaffoldBackgroundColor: Colors.white,
          buttonColor: Colors.blueGrey[700],
          primaryColor: Colors.amber[400],
          accentColor: Colors.indigo[400],
          iconTheme: IconThemeData(color: Colors.blueGrey[700]),
          shadowColor: Colors.blueGrey[700].withOpacity(.6),
          textTheme: TextTheme(
            headline1: GoogleFonts.karla(
              textStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[600],
              ),
            ),
            bodyText1: GoogleFonts.karla(
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey[700],
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: .0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          //containers and cards will use the backgroundColor property
          backgroundColor: Colors.grey[900],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueGrey[700],
          ),
          hintColor: Colors.blueGrey[700],
          scaffoldBackgroundColor: Colors.black12,
          buttonColor: Colors.blueGrey[700],
          primaryColor: Colors.orange[300],
          accentColor: Colors.indigo[300],
          iconTheme: IconThemeData(color: Colors.blueGrey[700]),
          shadowColor: Colors.blueGrey[700].withOpacity(.6),
          textTheme: TextTheme(
            headline1: GoogleFonts.karla(
              textStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xffFAFAFA),
              ),
            ),
            headline2: GoogleFonts.karla(
              textStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            bodyText1: GoogleFonts.karla(
              textStyle: TextStyle(
                fontSize: 16,
                color: Color(0xffFAFAFA),
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: .0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
