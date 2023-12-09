
import 'package:flutter/material.dart';

import '../login/login_screen.dart';

adminSingOut(BuildContext context){
  showDialog(context: context,   builder: (context) {
    return AlertDialog(
       title:const Text('Logout'),
      content:const Text('you want to log out?'), 
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        },
         child: const Text('cancel')),
         TextButton( onPressed: () async {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>LoginPage() ,), (route) => false);
            }, 
          child: const Text('Yes'))
      ],
    );
  },);
 }




 void showSnackBar({required context, required String? message, required Color?  snakBarclr}) {
  ScaffoldMessenger.of(context??'').showSnackBar(
    SnackBar(
      content: Text(message!),
      backgroundColor: snakBarclr
    ),
  );
}



 
