import 'dart:io';
import 'package:contracterApp/controller/profile_provider.dart';
import 'package:contracterApp/model/profile_model/profile_model.dart';
import 'package:contracterApp/view/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenDrawer extends StatelessWidget {
  const ScreenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   Provider.of<ProfileProvider>(context,listen: false).getAllProfile();
    return Drawer(
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: const Text('My Profile'),
        ),
        body: 
        Consumer<ProfileProvider>(
        
          builder: (context, value, child) {
            return value.userId.isEmpty ? Container(
              height: 60,
              width: 180,
            //  color: Colors.grey,
              decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.black,),
              margin: const EdgeInsets.only(top: 220,left: 60),
              child: TextButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: ((context) =>const Details() )));
              }, child: const Icon(Icons.add,size: 40,)),
            ):
           ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              final data = value.userId[index];
              return Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Container(
                     decoration: BoxDecoration( color: Colors.deepPurple[50],// Background color
              borderRadius: const BorderRadius.horizontal(left:Radius.circular(30),right:Radius.circular(30) ), // Rounded corners
              border: Border.all(
                color: Colors.black,
                width: 1,)),
                    
                  child: Column(
                  
                    children: [
                      CircleAvatar(
                         backgroundImage: FileImage(File(data.image!)),maxRadius:60 ,
                      ),
                      Text('Name: ${data.name}',style: const TextStyle(fontSize: 30),),const SizedBox(height: 10,),
                      Text('No:  ${data.age}',style: const TextStyle(fontSize: 30),),const SizedBox(height: 10,),
                       Text('Age:${data.number}',style: const TextStyle(fontSize: 30),),const SizedBox(height: 10,),
                    ],
                  ),
                ),
              );
            },
                     );
   } ),
      ),
    );
  }
}
