import 'package:flutter/material.dart';
import 'package:travel_app/login_screen.dart';
import 'package:travel_app/reuseable_widgets.dart';
import 'package:travel_app/signin_screen.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 243, 244, 250),
      body: SafeArea(
        child: Stack(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  child: Image.asset('images/login_img.png'), 
                ),
              ],
            ),
             Column(mainAxisAlignment: MainAxisAlignment.start, 
              children: [
                 const SizedBox(height: 160,),
                 appNAme(),
                 const SizedBox(height: 7,), 
                 appNameDownTxt(),
                 const SizedBox(height: 50,),
                 ElevatedButton(onPressed: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                 },
                 child:const Text('        LOG IN        ',style: TextStyle(color: Colors.white),)), 
                  
                 const SizedBox(height: 5,),
                 
                 ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SignInPage() ,));
                 },
                  child:const Text('       SIGN IN       ',style: TextStyle(color: Colors.white),)),
                
              ],
            ) 
            
          ],
        ),
      )
    );
  }
}












