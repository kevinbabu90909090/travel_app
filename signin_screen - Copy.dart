import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:travel_app/login_screen.dart';
import 'package:travel_app/pagesof_appbar/model_classes/signin_model.dart';
import 'package:travel_app/reuseable_widgets.dart';

class SignInPage extends StatefulWidget {
   SignInPage({super.key});

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
     late Box signInBox;
  

    @override
    void initState() {
    super.initState();
      signInBox=Hive.box<SignInModel>('signin'); 
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                
               TextFormField(
                  controller:_userNameController ,
                  onSaved: (newValue) {
                    _userName=newValue;
                  }, 
      
                   validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'Please enter username ';
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
      
      
                
                    
                    sizedBox(height: 12 ),
                    
                TextFormField(
                  controller: _emailIdController,
                  onSaved: (newValue) {
                    _emailId=newValue;
                  },
                   autovalidateMode: AutovalidateMode.onUserInteraction,
                   validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'Please enter your E mail';
                    }else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                     .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if(error){
                        error=true;
                      }
                    });
                  },
                  decoration: InputDecoration(
                        border: OutlineInputBorder( 
                        borderRadius: BorderRadius.circular( 50)),
                              labelText: 'Email ID..',
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
                    
                  sizedBox(height: 12), 
                    
                TextFormField(
                  controller: _passwordController, 
                  onSaved: (newValue) {
                    _password=newValue;
                  },
                   validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'Please enter a password';
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
                  decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular( 50)),
                              labelText: 'Password..', 
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
                    
                     sizedBox(height: 12),
            
                   ElevatedButton(onPressed: (){
                    addingSignInData(); 
                   
                   },
                   child:const Text('        SIGN UP        ',
                   style: TextStyle(color: Colors.white),)),
            
                    Row(mainAxisAlignment: MainAxisAlignment.center, 
                       children: [const Text("Already you have account?", 
                       style: TextStyle(color: Colors.grey),),
                       TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                       }, 
                       child:const Text("LOG IN"))]),
                              
              ],),
            ),
          ),
      ),
      
    );
  }
  
   void addingSignInData(){
    final isvalid=_formKey.currentState?.validate();
     if(isvalid!=null && isvalid){
      _formKey.currentState?.save();
      signInBox.add(SignInModel(userName:_userName!, emailId: _emailId!, password: _password!));
      _userNameController.clear();
      _emailIdController.clear();
      _passwordController.clear();
       showSnackBar('Verified Sucessfuly');
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
     }

   }


  void showSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
      backgroundColor: Colors.green,
      content: Text(message),
    ),
  );
}


}