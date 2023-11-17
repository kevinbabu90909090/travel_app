
import 'package:flutter/material.dart';
import 'package:travel_app/first_page.dart';
import 'package:travel_app/reuseable_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigatingSplashScreen();
  }


  Future<void>navigatingSplashScreen ()async{
     await Future.delayed(const Duration(seconds: 3)); 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstPage(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  
        
           SingleChildScrollView(
             child: Column(
              children: [
                sizedBox(height: 200),
                appNAme(),
               const SizedBox(height: 10,),
                appNameDownTxt(),
               const SizedBox(height: 30,),
                SizedBox(
                  child:Image.asset('images/app_logo.png') , 
                  ),
                 
               Text('- lets start the journey enjoy\n the beautiful moments of life -' .toUpperCase(),style:const TextStyle(color: Colors.amber,fontSize:18),),

                     ],),
           )
        
       
    );
  }
}