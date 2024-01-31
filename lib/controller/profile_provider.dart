import 'package:contracterApp/model/profile_model/profile_model.dart';
import 'package:contracterApp/services/profile_service.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier{


  List<ProfileModel>userId=[];
  Profileservices userProfile =Profileservices();

 // get ismpty => false;
   
Future getAllProfile()async{
  userId=await userProfile.getAllProfile();
  notifyListeners();
}
Future<void>addProfile(ProfileModel value)async{
  await userProfile.addToProfile(value);
  getAllProfile();
  notifyListeners();  

}
Future<void>logOute()async{
await userProfile.logOut();
getAllProfile();
notifyListeners();


}

}