
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/pagesof_appbar/model_classes/signin_model.dart';
import 'package:travel_app/splash_screen.dart';
import 'pagesof_appbar/navBar.dart';

Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SignInModelAdapter());
  await Hive.openBox<SignInModel>('signin');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(Myapp(isLoggedIn: isLoggedIn));
}
class Myapp extends StatelessWidget {
  final bool isLoggedIn;
  const Myapp({required this.isLoggedIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium:GoogleFonts.nunito()
        ),
       primarySwatch: Colors.amber
      ),
     home: isLoggedIn ? NavBar() : SplashScreen(),  
    );
  }
}