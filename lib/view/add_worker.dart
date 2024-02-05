
import 'package:contracterApp/controller/add_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddWorker extends StatelessWidget {
  const AddWorker({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body:Consumer<Addworkers>(builder: (context, value, child) => 
         Form(  
          key:value.formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
             const SizedBox(height: 5,),
                  GestureDetector(
                    onTap: () =>
                        Provider.of<Addworkers>(context, listen: false)
                            .pickImage(ImageSource.gallery),
                    child: CircleAvatar(
                      backgroundColor: Colors.orange[200],
                      // ignore: sort_child_properties_last
                      child: Provider.of<Addworkers>(context).pickedImage ==
                              null
                          ?const Icon(Icons.add_a_photo)
                          : ClipOval(
                              child: Image.file(
                                Provider.of<Addworkers>(context).pickedImage!,
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                      radius: 60,
                    ),
                  ),
                const  SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z\s]'))
                    ],
                    controller:value.nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Name",
                      hintText: "Enter your Name",
                      prefixIcon:const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller:value.numberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Phone",
                      hintText: "Enter your phone number",
                      prefixText: "+91",
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller:value.ageController ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Age",
                      hintText: "Enter your Age",
                      prefixIcon: const Icon(Icons.calendar_month_outlined),
                    ),
                    maxLength: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Age is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
                  DropdownButtonFormField<String>(
                    value: Provider.of<Addworkers>(context).selectedJob,
                    items: ['CementWork', 'BuildingWork', 'SocialWork', 'Painting']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      Provider.of<Addworkers>(context, listen: false)
                          .selectJobCategory(newValue!);
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
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: (){
                      if ( value. formKey.currentState!.validate()) {
                    Provider.of<Addworkers>(context,listen: false).onAddWorkertOnClick(context);
                      }
                    },
                    child: const Text("Add"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }}

  
