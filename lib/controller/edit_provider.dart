import 'package:flutter/material.dart';


class Editprovider with ChangeNotifier{

   String? selectedJobCategory;
    void editcontroller(){
     (String? newValue) {
    selectedJobCategory = newValue;
      notifyListeners();
                  };
   }
  
}