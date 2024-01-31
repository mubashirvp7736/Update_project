import 'dart:io';
import 'package:contracterApp/controller/edit_provider.dart';
import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:contracterApp/controller/worker_provider.dart';
import 'package:contracterApp/view/home_list.dart';

class EditScreen extends StatefulWidget {
  final String name;
  final String number;
  final String age;
  final String jobCategories;
  final String image;
  final int index;

  EditScreen({
    Key? key,
    required this.name,
    required this.number,
    required this.age,
    required this.jobCategories,
    required this.index,
    required this.image,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController editName = TextEditingController();
  final TextEditingController editNumber = TextEditingController();
  final TextEditingController editAge = TextEditingController();
  String? selectedJobCategory;
  //String? age;
  File? selectedimage;
 String ?image;
  @override
  void initState() {
    super.initState();
    editName.text = widget.name;
    editNumber.text = widget.number;
    editAge.text = widget.age;
    selectedJobCategory = widget.jobCategories;
    image = widget.image != '' ? widget.image : null;
  
   // age = widget.age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Worker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                   CircleAvatar( backgroundImage: image != null
                      ? FileImage(File(image!))
                  : const AssetImage('assets/user.png',) as ImageProvider,maxRadius: 60,
                    ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z\s]'))
                  ],
                  controller: editName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Name",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: editNumber,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Number",
                    prefixIcon: const Icon(Icons.calendar_month),
                  ),
                ),
                const SizedBox(height: 10),
              TextFormField(
                    controller: editAge,
                    decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Icons.calendar_month, color: Colors.blue),
                        border: OutlineInputBorder(),
                        hintText: 'AGE'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "value is empty";
                      } else {
                        return null;
                      }
                    },
                    
                  ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedJobCategory,
                  items: ['CementWork', 'BuildingWork', 'SocialWork', 'Painting']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                   Provider.of<Editprovider>(context).editcontroller();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "Job Categories",
                    hintText: "Select your job category",
                    prefixIcon: const Icon(Icons.work),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a job category';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    updateStudent(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ListWorkers(),
                    ));
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateStudent(BuildContext context) async {
    final editprovider = Provider.of<WorkerProvider>(context, listen: false);
    final name = editName.text;
    final number = editNumber.text;
    final eage = editAge.text;
    final jobCategoryValue = selectedJobCategory;
     final images=image;
     
    final updatedStudent = Jobworkers(
      index: widget.index,
      name: name,
      number: number,
      age: eage, 
      jobcategories: jobCategoryValue ?? '', 
      image:images,
    );

    await editprovider.editTrip(widget.index, updatedStudent);
  }
}
