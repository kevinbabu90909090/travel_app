import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/admin_side/admin_navbar.dart';
import 'package:travel_app/main.dart';
import '../functions/funtions.dart';
import '../model/signin_model.dart';
import '../reuseable_widgets/reuseable_widgets.dart';
import '../screens/navBar.dart';
import '../sign_up/signup_screen.dart';

class LoginPage extends StatefulWidget {


  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   bool error=false;
  Box signInBox=Hive.box<SignInModel>('signin');  

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(padding:const EdgeInsets.only(left: 30  ,right: 30),
          child: SafeArea(
            child:SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      const SizedBox(height: 200,),
                       appNAme(),
                       appNameDownTxt(),
                       sizedBox(height: 50),         

                       buildTextFormField(
                        controller:_usernameController , 
                        labelText: "Username",  
                        validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter username';
                      }else if(value.length<3){
                        return 'please enter atleast 3 characters';
                      }
                      return null;
                    }, 
                        onChanged:  (value){
                      setState(() {
                        if(error){
                          error=true;
                        }
                      });
                    }), 
                    
                       sizedBox(height: 15,),

                       buildTextFormField(
                        controller:_passwordController , 
                        labelText: "password",  
                        validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter your password'; 
                      }else if(value.length<4){
                        return 'please enter atleast 4 characters';
                      }
                      return null;
                    }, 
                        onChanged:  (value){
                      setState(() {
                        if(error){
                          error=true;
                        }
                      });
                    }),
              
                        const SizedBox(height: 15,),
                        
                       ElevatedButton(
                         onPressed: ()async{
                         loginCheck();
                            },
                       child:const Text('        LOG IN        ',
                       style: TextStyle(color: Colors.white),)),
              
                       Row(mainAxisAlignment: MainAxisAlignment.center, 
                       children: [const Text("You don't have account?", 
                       style: TextStyle(color: Colors.grey),),
                       TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const SignInPage(),));
                       }, 
                       child:const Text("SIGN UP"))]), 
                  ],
                ),
              ),
            )
             ),
        ),
      ),
    );

  }

  /////function//////


 Future<void> loginCheck() async {
  var signInData = signInBox.values.cast<SignInModel>().toList();
  String enteredUsername = _usernameController.text.trim();
  String enteredPassword = _passwordController.text.trim();

  if (enteredUsername == '@admin' && enteredPassword == 'admin123') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AdminNavbar()),
    );
    return; 
  }
  
  if (_formKey.currentState!.validate() ){
     SignInModel loggedInUser = signInData.firstWhere((data) => data.userName == enteredUsername && data.password == enteredPassword);

     // ignore: unnecessary_null_comparison
     if (loggedInUser !=null) {

     var loggedInUserKey = signInBox.keyAt(signInData.indexOf(loggedInUser)).toString();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', isloggedin=true);
       loggedInUsername = _usernameController.text.trim();
       prefs.setString('loggedInUsername', loggedInUsername!);      
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  NavBar(userId: loggedInUserKey,)),);
      return; 
    } 
  }else {
      
      showSnackBar(
        context: context,
        message: 'Username and password do not match',
        snakBarclr: Colors.red,
      );
    }
}



}

