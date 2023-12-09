

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/model/comment.dart';
import 'package:travel_app/model/fav_model.dart';

import '../login/login_screen.dart';

Widget appNAme(){
  return const Align(
    child:  Text('TrekFlow',
    style: TextStyle(
      fontSize: 50,
      color: Colors.amber,
      fontWeight: FontWeight.bold),));
}

Widget appNameDownTxt(){
  return const Text('- I F   N O T   N O W,   W H E N ? -',
  style: TextStyle(color: Colors.amber,fontSize:13),);

}

Widget sizedBox({double? height,double? width }){
  return SizedBox(
    height:height,
    width: width,
  );
}


Widget trentingPlacesNow({
  required String imageUrl,
  required void Function()  buttonAction ,
   required String placeName
}){
  return  Stack(
     children: [
     SizedBox(
      child: ClipRRect(
        child: InstaImageViewer(
          child: FadeInImage(
            placeholder: AssetImage('images/placeholder.png'),
            image: NetworkImage(
              imageUrl,
            ),
             fit: BoxFit.cover,
          ),
        ),
        borderRadius: BorderRadius.circular(30 ),
      ),
      height: 600,
      width: 330,
    ),


    Positioned( 
      right: 0,
      left: 0 ,
      top: 10,
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(placeName,style:const TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold,color: Colors.white),)
      ],
    )),
      
    Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width:100,
            child: ClipRRect(
               borderRadius: BorderRadius.circular(100), 
               child: ElevatedButton(
                onPressed: buttonAction,
                child: const Text('Details',style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
);

}


Widget trentingPlaceDetails({
  required String placeName,
  required String location,
  required String img1,
  required String img2,
  required String img3,
  required String img4,
  required String descriptionTxt
}){
  
  return Scaffold(
    appBar: AppBar(actions: [sizedBox(width: 47)],
      centerTitle: true,
      elevation: 0, 
      backgroundColor: Colors.white,
      title:
         Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(placeName,style:const TextStyle(fontWeight: FontWeight.w400) ,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Icon( Icons.location_on,color: Colors.amber,),
                Text(location,style:const TextStyle(fontWeight: FontWeight.w400,color: Colors.grey,fontSize: 17),), 
                ])
        ],),
      ),
       
       body: Column( 
         children: [
           AspectRatio(aspectRatio:1,
             child: ScrollConfiguration(
              behavior:const ScrollBehavior().copyWith(overscroll: false),
               child: GridView(
                padding:const EdgeInsets.all(15),
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 10/10   
                  ),
                   
                   children: [ 
                         InstaImageViewer(
                         child:ClipRRect(borderRadius: BorderRadius.circular(10),
                         child: Image.network(img1,fit: BoxFit.cover,)) ),
                         InstaImageViewer(
                         child:ClipRRect(borderRadius: BorderRadius.circular(10),
                         child: Image.network(img2,fit: BoxFit.cover,)) ),
                         InstaImageViewer(
                         child:ClipRRect(borderRadius: BorderRadius.circular(10),
                         child: Image.network(img3,fit: BoxFit.cover,)) ),
                         InstaImageViewer(
                         child:ClipRRect(borderRadius: BorderRadius.circular(10),
                         child: Image.network(img4,fit: BoxFit.cover,)) ),
                       
                   ],
                        
                ),
             ),
           ),

            Expanded(
              child: ScrollConfiguration(behavior:const ScrollBehavior().copyWith(overscroll: false),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        sizedBox(height: 15),
                        const Text('Description',style: TextStyle(fontSize: 20),),
                        Padding(padding:const EdgeInsets.all(20), 
                          child: SizedBox(
                                child: Text(descriptionTxt,style:const TextStyle(fontSize: 15),),
                               ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              
              )
                  
         ],
       ),


  );

}

 


sheduledAllDatas({
  required String details,
  required data
}){
return Row(children: [ 
   Text(details,style:const TextStyle(fontSize: 17),),
   Text(data,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)],);
}



singOut(BuildContext context){
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', false);
              Navigator.pushAndRemoveUntil( 
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
               
            },  
          child: const Text('Yes'))
      ],
    );
  },);
 }

 warnningAleartMsg({
  required BuildContext context,
   required String title,
   required String content,
   required VoidCallback? onYesPressed,
   }){
   showDialog(context:context,   builder: (context) {
    return AlertDialog(
       title: Text(title),
      content: Text(content), 
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        },
         child: const Text('cancel')),
         TextButton( onPressed: onYesPressed ,
        
          child: const Text('Yes')),
          
          
      ],
    );
  },);
 }



 Widget profileItems({
  required IconData icon,
  required String text,
  void Function()? ontap, 
 }){
  return Container(padding:const EdgeInsets.only(left: 15,right: 15 ),
              margin:const EdgeInsets.only(top: 13,), 
              height: 80 ,
              width: double.infinity,
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(16),
                color: Colors.white, 
              ),
              child: Row(children: [
                InkWell(onTap: ontap, child: Icon(icon,color: Colors.amber,size: 30,)),
                sizedBox(width:10 ),
                InkWell(onTap: ontap, child: Text(text,style:const TextStyle(fontSize: 20 ) ,)),
              ],),
             );
 }


Widget userSideDisplayAllDatas({
  required BuildContext context,
  required String placeName,
   required String location,
    required String discription,
    required String img1,
     required String img2,
      required String img3,
       required String img4,
       required String placeId,
}){
   return Scaffold(
       appBar: AppBar(actions: [sizedBox(width: 47)],
      centerTitle: true,
      elevation: 0, 
      backgroundColor: Colors.white,
      title:
         Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(placeName,style:const TextStyle(fontWeight: FontWeight.w400) ,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Icon( Icons.location_on,color: Colors.amber,),
                Text(location,style:const TextStyle(fontWeight: FontWeight.w400,color: Colors.grey,fontSize: 17),), 
                ])
        ],),
      ),
     body: Column(
      children: [ 
         AspectRatio(aspectRatio:10/9.3 ,
           child: ScrollConfiguration(behavior:const ScrollBehavior().copyWith(overscroll: false),
             child: GridView(
              padding:const EdgeInsets.all(15),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 10/9  
                ),
                 
                 children: [ 
                       InstaImageViewer(
                       child:ClipRRect(borderRadius: BorderRadius.circular(10), 
                       child: Image.file(File(img1),fit: BoxFit.cover,)) ),
                       InstaImageViewer(
                       child:ClipRRect(borderRadius: BorderRadius.circular(10),
                       child: Image.file(File(img2),fit: BoxFit.cover,)) ),
                       InstaImageViewer(
                       child:ClipRRect(borderRadius: BorderRadius.circular(10),
                       child: Image.file(File(img3),fit: BoxFit.cover,)) ),
                       InstaImageViewer(
                       child:ClipRRect(borderRadius: BorderRadius.circular(10),
                       child: Image.file(File(img4),fit: BoxFit.cover,)) ),    
                 ],
                    
              ),
           ),
         ),

          
         Padding(padding:const EdgeInsets.only(left: 10,right: 10 ),
         child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween , 
          children: [const Text('Discription',
          style: TextStyle(fontSize: 20 ,color: Colors.amber),),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewDetails(placeId:placeId ),));
          },
           icon:const Icon(Icons.reviews_rounded ,color: Colors.grey,size: 26 ,))
          ],)),
         Expanded(child:  ScrollConfiguration(behavior:const ScrollBehavior().copyWith(overscroll: false) ,
           child: ListView(
            padding:const EdgeInsets.only(right: 10,left: 10),
            children: [
             sizedBox(height: 10,),
            Text(discription,style:const TextStyle(fontSize: 15.5)),
            ],
                 ),
         ))
      ],
     ),
    );
 }





Widget catagorysFiltering({
 required String title,
  bool isSelected = false
}){
  return   Container(
    
                    child: Center(
                      child: Text(title,style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w400,),),
                    ),
                    margin:const EdgeInsets.only(right: 7 ),
                    width: 100, 
                    decoration: BoxDecoration( 
                    color: isSelected ? const Color.fromARGB(93, 255, 193, 7) : Colors.white,                      borderRadius: BorderRadius.circular(10  )
                      ), 
                  );                  
} 



TextFormField buildTextFormField({
  required TextEditingController controller,
  required String labelText,
   Function (String?)? onSaved,
  required String? Function(String?) validator,
  required Function(String) onChanged,
}) {
  return TextFormField(
    controller: controller,
    onSaved: onSaved,
    validator: validator,
    onChanged: onChanged,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      labelText: labelText,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: Colors.amber,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: Colors.amber,
          width: 2,
        ),
      ),
    ),
  );
}
 

 const String aboutText='''Our travel app allows users to discover and select their favorite destinations, schedule trips, utilize search and filter functionality, and enjoy an enhanced user profile experience, while administrators can seamlessly add new places, creating a comprehensive and personalized travel platform. 

The travel app is a comprehensive platform designed to offer users a seamless and personalized travel experience. At its core, the app empowers users to explore a diverse array of destinations, providing them with the tools to curate their travel preferences, plan and schedule trips, and connect with a community of fellow travelers. With a user-friendly interface, the app aims to enhance the overall travel journey from exploration to execution.

One of the primary features of the app is the ability for users to choose from a vast selection of places. Whether it's a bustling city, a tranquil beach, or a picturesque mountain retreat, the app caters to a variety of preferences. Users can browse through detailed descriptions, captivating images, and relevant information to make informed decisions about their desired destinations.

To further personalize their experience, users can mark specific places as favorites. This feature allows individuals to create a curated list of preferred destinations, fostering a sense of connection and ownership over their travel choices. The favorite places feature not only serves as a quick reference for users but also adds a layer of personalization to their overall travel profile within the app.

The app goes beyond mere destination selection by empowering users to plan and schedule their trips. The trip scheduling feature enables users to set dates, add activities, and organize their itinerary, ensuring a well-structured and memorable travel experience. This functionality is geared towards streamlining the planning process and providing users with a convenient tool to manage their trips efficiently.

 ''';


 class ReviewDetails extends StatefulWidget {
  ReviewDetails({super.key, required this.placeId});
  final String placeId;

  @override
  State<ReviewDetails> createState() => _ReviewDetailsState();
}

class _ReviewDetailsState extends State<ReviewDetails> {
  TextEditingController comment = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<dynamic> comments = [];
  Box<CommentModel> commentBox = Hive.box<CommentModel>('comment');

  @override
  void initState() {
    super.initState();
    loadComments();
  }
   void loadComments() {
    setState(() {
      // Filter comments based on the selected place ID
      comments = commentBox.values.where((comment) => comment.placeId == widget.placeId).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: comment,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Comments',
                  suffixIcon: IconButton(
                    onPressed: () {
                    commentAdding();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
              ),
             const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.chat, size: 20, color: Colors.amber),
                     title: Text(comments[index].comment),
                     
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: comments.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

void commentAdding() {
    if (_formKey.currentState!.validate()) {
      CommentModel newComment = CommentModel(placeId: widget.placeId, comment: comment.text);
      commentBox.add(newComment);
      loadComments(); // Reload comments to update the UI
      comment.clear();
    }
  }
}
    

  



 