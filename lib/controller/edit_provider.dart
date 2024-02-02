
  
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Editprovider with ChangeNotifier{

   String? selectedJobCategory;

  void updateJobCategory(String? newValue) {
    selectedJobCategory = newValue;
    notifyListeners();
  }
     File? selectedImage;
     
    pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    
        selectedImage = File(pickedImage!.path);
      notifyListeners();
  }
}