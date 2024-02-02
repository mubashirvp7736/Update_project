
import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:hive/hive.dart';
 class Jobworkservices{

Future<List<Jobworkers>>getAllWorker()async{
    final studentDb= await Hive.openBox<Jobworkers>("jobworker_db");
   return studentDb.values.toList();
  }
 
Future <void> addWorker(Jobworkers value)async{
  
  final jobworkerDb = await Hive.openBox<Jobworkers>("jobworker_db");
   await jobworkerDb.add(value);
}
 
Future<void> deleteWorker(int index)async{
  final jobworkerDb= await Hive.openBox<Jobworkers>("jobworker_db"); 
   jobworkerDb.deleteAt(index);
 }

Future<void> logout()async{
  final jobworkerDb= await Hive.openBox<Jobworkers>("jobworker_db"); 
   await jobworkerDb.clear();
}

  Future updateWorker(id, Jobworkers value) async {
    final jobWorkerDb = await Hive.openBox<Jobworkers>("jobworker_db");
    await jobWorkerDb.putAt(id, value);
   
  }
 }