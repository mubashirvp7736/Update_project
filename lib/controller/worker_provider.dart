import 'dart:io';
import 'package:contracterApp/main.dart';
import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:contracterApp/services/worker_service.dart';
import 'package:contracterApp/view/bottom_bar.dart';
import 'package:contracterApp/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WorkerProvider extends ChangeNotifier{

  List<Jobworkers> workersList=[];
  Jobworkservices dbServices=Jobworkservices();
  
  Future getAllStud()async{
    workersList=await dbServices.getAllStud();
    notifyListeners();
  }
  
Future<void>addworkers(Jobworkers value)async{
 await dbServices.addstud(value);
 getAllStud();
 notifyListeners();
}
 Future deletestud(int index)async{
  await dbServices.deletestud(index);
  getAllStud();
  notifyListeners();
 }
  void showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
      Rect.fromPoints(
          const Offset(100, 100), 
          const Offset(200, 200),
        ),
        Offset.zero & MediaQuery.of(context).size
      ),
      items: [
        
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              logout();
             // logout();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => UserLogin(),), (route) => false);
            },
          ),
        ),
      ],
    );
    
  }
//   Future<void>logout()async{
//   final profile_db= await Hive.openBox<ProfileModel>('profiledb');
//   profile_db.clear();
//   getProfile();
// }
  Future<void> logout()async{
  final jobworkerDb= await Hive.openBox<Jobworkers>("jobworker_db"); 
   await jobworkerDb.clear();
  getAllStud();
  notifyListeners();
}
 void checkLogin(BuildContext context,_username,_password)async{
  final usernames=_username.text;
  final passwords=_password.text;

  if(usernames=='mubu'&& passwords=='7736'){
    final sharedprefe=await SharedPreferences.getInstance();
    await sharedprefe.setBool(save_key,true);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreen()));
       }else{
    const SnackBar(content: Text('user name password does not match'));
  }

  }
    Future<void> gotoScreen(context)async{
    await Future.delayed(const Duration(seconds: 4));
  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => UserLogin(),));
  }
  Future<void>checkuserlogin(context)async{
    final sharedprefer= await SharedPreferences.getInstance();
    final userlogin=sharedprefer.getBool(save_key);
   if(userlogin==null){
    UserLogin();
   }else{
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const HomeScreen()));

   }
  }
 
    File? selectimage;
   fromgallery() async {
    
    final returnedimage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      selectimage = File(returnedimage!.path);
      notifyListeners();
  
  }

  fromcam() async {
    
    File? selectimage;
    final returnedimage =
    await ImagePicker().pickImage(source: ImageSource.camera);
  
    selectimage = File(returnedimage!.path);
    notifyListeners();
  }
   Future<void> editTrip(int id, Jobworkers value) async {
    await dbServices.updateTrip(id, value);
    await getAllStud();
  }
}