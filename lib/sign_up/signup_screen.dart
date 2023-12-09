import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../functions/funtions.dart';
import '../login/login_screen.dart';
import '../model/signin_model.dart';
import '../reuseable_widgets/reuseable_widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
     bool error=false;
     String? _userName;
     String? _emailId;
     String? _password; 
     Box signInBox=Hive.box<SignInModel>('signin'); 
    

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body:  SingleChildScrollView(
          child: Padding(padding:const EdgeInsets.only(right: 30,left: 30),
              child: Form(
                key: _formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  sizedBox(height: 200), 
                  appNAme(),
                  appNameDownTxt(),
                  sizedBox(height: 50),
                  
                 buildTextFormField(
                  controller: _userNameController,
                   labelText: "Username",
                    onSaved: (newValue) {
                      _userName=newValue;
                    },
                     validator: (value) {
                        if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                        } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                        return 'Username can only contain letters, numbers, and underscores';
                        } else if (value.length < 3) {
                        return 'Username must be at least 3 characters long';
                        }
                        return null;
                     },
                      onChanged:  (value) {
                      setState(() {
                        if(error){
                          error=true;
                        }
                      });
                    },
                      ),

                      sizedBox(height: 15),

                      buildTextFormField(
                  controller: _emailIdController,
                   labelText: "Email Id",
                    onSaved: (newValue) {
                      _emailId=newValue;
                    },
                     validator:  (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter your E mail';
                      }else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                       .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                     },
                      onChanged:  (value) {
                      setState(() {
                        if(error){
                          error=true;
                        }
                      });
                    },
                      ),
                      
                 
                      
                    sizedBox(height: 15), 


                       buildTextFormField(
                  controller: _passwordController,
                   labelText: "Password",
                    onSaved: (newValue) {
                      _password=newValue;
                    },
                     validator:  (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                         } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                           return 'Password can only contain letters and numbers, ';
                          } else if (value.length < 4) {
                           return 'Password must be at least 4 characters long';
                           }
                           return null;
                     },
                      onChanged:  (value) {
                      setState(() {
                        if(error){
                          error=true;
                        }
                      });
                    },
                      ),
                    
                      
                       sizedBox(height: 15),
              
                     ElevatedButton(onPressed: (){
                      addingSignInData(); 
                     
                     },
                     child:const Text('        SIGN UP        ',
                     style: TextStyle(color: Colors.white),)),
              
                      Row(mainAxisAlignment: MainAxisAlignment.center, 
                         children: [const Text("Already you have account?", 
                         style: TextStyle(color: Colors.grey),),
                         TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const LoginPage(),));
                         }, 
                         child:const Text("LOG IN"))]),
                                
                ],),
              ),
            ),
        ),
        
      ),
    );
  }


  ///////function///////
  

   void addingSignInData() {   
  final isvalid = _formKey.currentState?.validate();
  if (isvalid != null && isvalid) {
    _formKey.currentState?.save();
    
    if (_userName != null && _emailId != null && _password != null) {
      String userId=DateTime.now().millisecondsSinceEpoch.toString() ;
      signInBox.put(userId,
        SignInModel(
          userId:userId,
          userName: _userName!.trim(),
          emailId: _emailId!.trim(),
          password: _password!.trim()));
      showSnackBar(context: context, message: 'verified successfully', snakBarclr: Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const LoginPage()),
      );
    } else {
      showSnackBar(context: context,message:'please enter username and password',snakBarclr: Colors.red);
    }
  }
}
   

}