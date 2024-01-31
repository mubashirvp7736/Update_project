import 'package:contracterApp/controller/worker_provider.dart';
import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProvider extends ChangeNotifier {
  List<Jobworkers> searchedPatient = [];

  void loadPatient(BuildContext context) async {
    final getProvider = Provider.of<WorkerProvider>(context, listen: false);
    final allPatient = getProvider.workersList;

    searchedPatient = allPatient;
    notifyListeners();
  }

  void filter(String enteredName, BuildContext context) {
    final getProvider = Provider.of<WorkerProvider>(context, listen: false);

    if (enteredName.isEmpty) {
      searchedPatient = [...getProvider.workersList];
    } else {
      searchedPatient = getProvider.workersList
          .where((Jobworkers patient) =>
              patient.name.toLowerCase().contains(enteredName.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }
}