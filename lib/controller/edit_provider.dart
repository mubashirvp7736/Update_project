// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


// class Editprovider with ChangeNotifier{
// //  File? selectimage;
// //    String? selectedJobCategory;
// //     void editcontroller(){
// //      (String? newValue) {
// //     selectedJobCategory = newValue;
// //       notifyListeners();
   
// //     };
   
// //    }

//    String? selectedJobCategory;
//     void editcontroller(){
//      (String? newValue) {
//     selectedJobCategory = newValue;
//       notifyListeners();
//                   };
//    }
  
// }
//   //     fromgallery() async {
//   //   final returnedimage =
//   //       await ImagePicker().pickImage(source: ImageSource.gallery);

    
//   //     selectimage = File(returnedimage!.path);
//   //   notifyListeners();
//   // }

//   // fromcam() async {
//   //   final returnedimage =
//   //       await ImagePicker().pickImage(source: ImageSource.camera);
  
//   //     selectimage = File(returnedimage!.path);
//   //   notifyListeners();
//   // }
//     File? picked;

//   // pickImageFromGallery() async {
//   //   final pickedImage =
//   //       await ImagePicker().pickImage(source: ImageSource.gallery);
   
//   //       selectedImage = File(pickedImage!.path);
//   //     notifyListeners();
//   //   //}
//   // }

//   // // Method to take a photo using the camera
//   //  takePhoto() async {
//   //   final pickedImage =
//   //       await ImagePicker().pickImage(source: ImageSource.camera);
//   //   // if (pickedImage != null) {
    
//   //       selectedImage = File(pickedImage!.path);
//   //       notifyListeners();
//   //    // }
//   // }
//     updateImage(ImageSource source) async {
//     var img = await ImagePicker().pickImage(source: source);
//     picked = File(img!.path);
//   //  notifyListeners();
//   }

  
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Editprovider with ChangeNotifier{

   String? selectedJobCategory;
  //  void editcontroller(String? newValue){
  //    (String? newValue) {
  //   selectedJobCategory = newValue;
  //     notifyListeners();
  //                 };

  //  }
  // String? selectedJobCategory;

  void updateJobCategory(String? newValue) {
    selectedJobCategory = newValue;
    notifyListeners();
  }
     File? selectedImage; // Variable to store the selected image

    pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    
        selectedImage = File(pickedImage!.path);
      notifyListeners();
    //}
  }
}