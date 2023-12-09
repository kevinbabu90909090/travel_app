
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/fav&comments/favorite.dart';
import 'package:travel_app/reuseable_widgets/reuseable_widgets.dart';
import 'package:travel_app/screens/about_page.dart';
import 'package:travel_app/screens/edit_sheduled_details.dart';


class Profile extends StatefulWidget {
   const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

    String? loggedInUsername;
     @override
  void initState() {
    super.initState();
    loadUsername();
  
  }

  Future<void> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedInUsername = prefs.getString('loggedInUsername') ?? ''; 
    setState(() {}); 
  } 
  XFile? profilePic;
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor:const Color.fromARGB(10, 255, 193, 7),
      appBar: AppBar( 
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title:const Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
             Text('Profile ',style: TextStyle(fontSize: 25),), 
             Icon(Icons.person,color: Colors.amber,size: 27,)
             ]),
      ),
      body:Padding(padding:const EdgeInsets.all(18 ), 
        child: SingleChildScrollView(
          child: Column(children: [
               Container(
                padding:const EdgeInsets.all(20),
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(25), 
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  SizedBox(
                    height: double.infinity,
                    width: 100 ,
                    child: GestureDetector( 
                      onTap: () {
                        profileImageTaking();
                      },
                      child: ClipRRect( 
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset('images/placeholder.png',fit: BoxFit.cover,),
                    ),
                    )
                  ),
                    Flexible(child: Text(loggedInUsername??'',style:const TextStyle(fontSize:22 ),)),
                   sizedBox(width: 40),
                   
                ],),
               ),
        
               profileItems(icon: Icons.favorite, text:'F a v o r i t e',ontap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>const Favorite() ,));
               },),

               profileItems(icon: Icons.list_alt_rounded, text:'S c h e d u l e d  L i s t',ontap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const EditSheduledDetails() ,));
               },),
               profileItems(icon: Icons.share_rounded, text:'S h a r e'),
               profileItems(icon: Icons.info_rounded, text:'A b o u t',ontap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>const AboutPage() ,));
               },),
               profileItems(icon: Icons.logout_rounded, text:'L o g  O u t',ontap: () {
                 singOut(context);
               },),
        
               
          ],),
        ),
      )
    );
  }

    profileImageTaking()async{
    
      // ignore: invalid_use_of_visible_for_testing_member
      final image=await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
      setState(() {
       if(image!=null){
         profilePic=image;
       }
      });
      
    }

   
}



 
