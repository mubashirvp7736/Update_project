import 'dart:io';

import 'package:contracterApp/controller/worker_provider.dart';
import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:contracterApp/view/home_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Addworkers with ChangeNotifier{
  File? _picked;
String?  _selectedJobCategory;

  File? get pickedImage => _picked;
  String ? get selectedjob=>_selectedJobCategory;
  String? get selectedJob => _selectedJobCategory;
   final TextEditingController nameController = TextEditingController();
   final TextEditingController numberController = TextEditingController();
   final TextEditingController ageController = TextEditingController();
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
Future<void> onAddStudentOnClick(context) async {
    final name = nameController.text.trim();
    final numb = numberController.text.trim();
    final age =  ageController.text.trim();
    final jobCategories =selectedJob ?? '';
    if (name.isEmpty || age.isEmpty || jobCategories.isEmpty) {
      return;
    }
    notifyListeners();
    final worker = Jobworkers(
      name: name,
      number: numb,
      age: age,
      jobcategories: jobCategories,
      image: _picked?.path ?? '',
    );
     Provider.of<WorkerProvider>(context,listen: false).addWorkers(worker);
     notifyListeners();
     nameController.clear();
    numberController.clear();
    ageController.clear();
   _picked=null;
    _selectedJobCategory=null;
   
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListWorkers(selectedJobCategory: jobCategories)),
    );
    
    notifyListeners();
  }
  void selectJobCategory(String newValue) {
    _selectedJobCategory = newValue;
    notifyListeners();
  }
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    var img = await imagePicker.pickImage(source: source);
    _picked = File(img?.path ?? '');
    notifyListeners();
  }

}
