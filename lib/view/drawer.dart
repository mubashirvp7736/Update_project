
import 'dart:io';
import 'package:contracterApp/controller/profile_provider.dart';
import 'package:contracterApp/model/profile_model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:contracterApp/view/show_drawe.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final ImagePicker _imagePicker = ImagePicker();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ADD Account"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        child: const Icon(Icons.add_a_photo),
                        radius: 50,
                        backgroundImage:_image != null
                            ? FileImage(_image!)
                            : const AssetImage('assets/splashscreen.png.png') as ImageProvider,
                      ),
                      onTap: () {
                        _showImageSourceDialog();
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Your Name",
                        labelText: "Name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Value is empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      maxLength: 2,
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Age",
                        hintText: "Your Age",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Value is empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 10,
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        prefixText: "+91 ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Phone Number",
                        hintText: "Your Phone Number",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Value is empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _onAddStudentButtonClicked();
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ScreenDrawer()),
                          );
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("SUBMIT"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _onAddStudentButtonClicked() async {
    final addProfil=Provider.of<ProfileProvider>(context,listen: false);
    final _name = _nameController.text.trim();
    final _age = _numberController.text.trim();
    final _number = _ageController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _number.isEmpty) {
      return;
    }
    final _student = ProfileModel(name: _name, number: _number, age: _age, image: _image!.path);
    addProfil.addProfile(_student);
    Navigator.of(context).pop();
  }

  void _showImageSourceDialog() {
    showDialog(
       context: context,
      builder: (context) => AlertDialog(
         title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             TextButton(
               onPressed: () =>  _pickImage(ImageSource.gallery),
               child: const Text("Gallery"),
             ),
             TextButton(
               onPressed: () =>  _pickImage(ImageSource.camera) (),
               child: const Text("camera"),
             ),
           ],
         ),
       ),
   );
  }

  _pickImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(source: source);
     if (image != null) {
       setState(() {
         _image = File(image.path);
       });
     }
     Navigator.pop(context);
  }
  }

