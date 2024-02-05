import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:flutter/material.dart';

class Workerdetail with ChangeNotifier {


  List<Jobworkers> filteredworkerList = [];
  List<Jobworkers> workersList = [];
   TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  void filterWorkers(String search) {
    if (search.isEmpty) {
      filteredworkerList = List.from(workersList);
      notifyListeners();
    } else {
      filteredworkerList = workersList
          .where((worker) =>
              worker.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searCh() {
    isSearching = !isSearching;
    if (!isSearching) {
      searchController.clear();
      filteredworkerList = List.from(workersList);
    }
    notifyListeners();
  }
}

  
