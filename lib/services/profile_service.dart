import 'package:contracterApp/model/profile_model/profile_model.dart';
import 'package:hive_flutter/adapters.dart';

class Profileservices{


Future<List<ProfileModel>>getAllProfile()async{
final profilDb=await Hive.openBox<ProfileModel>('profiledb');
return profilDb.values.toList();

}
Future<void> addToProfile(ProfileModel value)async{
  final profileDb=await Hive.openBox<ProfileModel>("profiledb");
  await profileDb.add(value);
}

 Future<void>logOut()async{
    final profileDb=await Hive.openBox<ProfileModel>("profiledb");
   await profileDb.clear();
 }
}
