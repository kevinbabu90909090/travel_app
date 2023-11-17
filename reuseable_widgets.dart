import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

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
          child: Image.network(
            imageUrl,
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
      child: Row(mainAxisAlignment: MainAxisAlignment.center   ,
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

            Expanded(

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
              
              )
                  
         ],
       ),


  );

}

  