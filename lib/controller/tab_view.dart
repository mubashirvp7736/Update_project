import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:flutter/material.dart';

class TabviewDetail with ChangeNotifier{

  List<Jobworkers> filteredWorkerList = [];
  List<Jobworkers> workersl = [];
  void filterWorkers(String search) {

    if (search.isEmpty) { 
        filteredWorkerList = List.from(workersl);
        notifyListeners();
    
    }else{
        filteredWorkerList = workersl
            .where((student) =>
                student.name.toLowerCase().contains(search.toLowerCase()))
            .toList();
            notifyListeners();
      }
    }
    
  bool  isSearching = false;
  
   TextEditingController searchController = TextEditingController();
   void search(){
    isSearching = !isSearching;
        if (!isSearching) {
          searchController.clear();
         filteredWorkerList = List.from(workersl);
         notifyListeners();
        }
        notifyListeners();
   }
  

}