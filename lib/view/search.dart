import 'dart:io';

import 'package:contracterApp/controller/worker_provider.dart';
import 'package:contracterApp/controller/search_provider.dart';
import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:contracterApp/view/worker_details.dart';
import 'package:contracterApp/view/edit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Searchworker extends StatelessWidget {
  const Searchworker({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: true);

    return Scaffold(
      
      appBar: AppBar(title: const Text('searchbar'),),
      body: Container(
        decoration: const BoxDecoration(
          
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: TextFormField(
                onChanged: (value) => searchProvider.filter(value, context),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 16, 105, 140),
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: const Icon(
                    Icons.search_sharp,
                    color: Color.fromARGB(255, 16, 105, 140),
                  ),
                  hintText: "Find Appointment...",
                  hintStyle: const TextStyle(
                    color: Color(0xFF636262),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: searchProvider.searchedPatient.isEmpty
                  ? Center(
                      child:
                          Lottie.asset("assets/Animation - 1704185716916.json"),
                    )
                  : ListView.builder(
                      itemCount: searchProvider.searchedPatient.length,
                      itemBuilder: (context, index) {
                        final data = searchProvider.searchedPatient[index];
                        return buildStudentCard(data, index,context);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildStudentCard(Jobworkers data, int index,context) {
  return GestureDetector(
    onTap: () {
       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Details(name: data.name, number: data.number, age:data. age, jobcategories:data. jobcategories,image: data.image!,);
      },));
    },
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        color: const Color.fromARGB(255, 241, 227, 227),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 30,
                backgroundColor: Colors.black,
                backgroundImage: FileImage(File(data.image!)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('Name: ${data.name}',style:const TextStyle(fontStyle: FontStyle.italic) ,),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MOB: ${data.number}'),
                          Text('Age: ${data.age}'),
                          Text( 'Job:${data.jobcategories}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () { 
                      showModalBottomSheet(context: context, builder: (context) {
                        return EditScreen(name: data.name, number:data. number, age:data.age, jobCategories:data. jobcategories, index: index, image:data.image!, );
                      },);
                    },
                    icon: const Icon(Icons.edit),
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(context: context,
                       builder:(context) {
                         return AlertDialog(
                          title: const Text('Are you sure want to delete'),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child:const Text('close')),
                            TextButton(onPressed: (){
                             Provider.of<WorkerProvider>(context,listen: false).deleteWorker(index);
                              Navigator.pop(context);
                            }, child: const Text('Delete'))
                          ],
                         );
                       },);
                     },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                     ),
                   ],
                 ),
               ],
             ),
          ),
        ),
      ),
    );
  }
}