import 'dart:io';
import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:contracterApp/services/worker_service.dart';
import 'package:flutter/material.dart';


class WorkerProvider extends ChangeNotifier{

  List<Jobworkers> workersList=[];
  Jobworkservices dbServices=Jobworkservices();
    File? selectimage;
  
  Future getAllWorker()async{
    workersList=await dbServices.getAllWorker();
    notifyListeners();
  }
   
 Future<void>addWorkers(Jobworkers value)async{
  await dbServices.addWorker(value);
  getAllWorker();
  notifyListeners(); 
 }
  Future deleteWorker(int index)async{
  await dbServices.deleteWorker(index);
  getAllWorker();
  notifyListeners();

 }

 Future<void> editWorker(int id, Jobworkers value) async {
    await dbServices.updateWorker(id, value);
    await getAllWorker();
  }
  

  
   
}