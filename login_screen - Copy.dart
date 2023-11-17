import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/admin_side/admin_page.dart';
import 'package:travel_app/pagesof_appbar/navBar.dart';
import 'package:travel_app/reuseable_widgets.dart';
import 'package:travel_app/signin_screen.dart';
import 'pagesof_appbar/model_classes/signin_model.dart';

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

  late Box signInBox;
@override
    void initState() {
    super.initState();
      signInBox=Hive.box<SignInModel>('signin');  
    }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            
                    TextFormField(
                      controller: _usernameController,
                   validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'Please enter username';
                    }return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if(error){
                        error=true;
                      }
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                        border: OutlineInputBorder( 
                        borderRadius: BorderRadius.circular( 50)),
                              labelText: 'Username..',
                              focusedBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                borderSide:const BorderSide(
                                  color: Colors.amber,
                                  width: 2
                                )
                              ) ,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:const BorderSide(
                                  color: Colors.amber,
                                  width: 2
                                )
                              ),
                            ),
                ),
                  
                    const SizedBox(height: 15,),
            
                    TextFormField(
                      controller: _passwordController,
                   validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'Please enter your password'; 
                    }return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if(error){
                        error=true;
                      }
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                        border: OutlineInputBorder( 
                        borderRadius: BorderRadius.circular( 50)),
                              labelText: 'password..',
                              focusedBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                borderSide:const BorderSide(
                                  color: Colors.amber,
                                  width: 2
                                )
                              ) ,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:const BorderSide(
                                  color: Colors.amber,
                                  width: 2
                                )
                              ),
                            ),
                ),
            
            
                      const SizedBox(height: 15,),
                      
                     ElevatedButton(
                       onPressed: ()async{
                        if (_formKey.currentState?.validate() ?? false) {
                          if (await loginCheck()) {
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBar()));
                        }
                         }
                          },
                     child:const Text('        LOG IN        ',
                     style: TextStyle(color: Colors.white),)),
            
                     Row(mainAxisAlignment: MainAxisAlignment.center, 
                     children: [const Text("You don't have account?", 
                     style: TextStyle(color: Colors.grey),),
                     TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage(),));
                     }, 
                     child:const Text("SIGN UP"))]), 
                ],
              ),
            ),
          )
           ),
      ),
    );

  }

    
Future<bool> loginCheck()async{
  
  String _adminUserName=_usernameController.text.trim();
  String _adminpassword=_passwordController.text.trim();
  if(_adminUserName=='@admin'&&_adminpassword=='admin123'){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPage(),));
    
  }
  
  var signInData = signInBox.values.cast<SignInModel>().toList();
  String _enteredUsername = _usernameController.text.trim();
  String _enteredPassword = _passwordController.text.trim();

  bool credentialsMatch = signInData.any((data) =>
      data.userName == _enteredUsername && data.password == _enteredPassword);

  if (credentialsMatch) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  } else {
    if(_adminpassword!='admin123'){
       showSnackBar('Username and password do not match');
    } 
    
  }

  return credentialsMatch;
}

void showSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red, 
    ),
  );
}

}


