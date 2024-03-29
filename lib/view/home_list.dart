
import 'dart:io';
import 'package:contracterApp/controller/worker_provider.dart';
import 'package:contracterApp/controller/home_provider.dart';
import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:contracterApp/view/worker_details.dart';
import 'package:contracterApp/view/edit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ListWorkers extends StatefulWidget {
  final String? selectedJobCategory;
  const ListWorkers({super.key, this.selectedJobCategory});
  @override
  // ignore: library_private_types_in_public_api
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<ListWorkers> {
  String ? image;
  @override
  void initState() {
    super.initState(); 
    Provider.of<WorkerProvider>(context,listen: false).getAllWorker();
    
  }

  @override
  Widget build(BuildContext context) {
    final prProvider=Provider.of<WorkerProvider>(context,);
    return  Scaffold(
          body: prProvider.workersList.isEmpty?Lottie.asset('assets/Animation - 1706691966220.json'):
          buildStudentList(),
       backgroundColor: Colors.white,
        );

  }
  
Widget buildStudentCard(Jobworkers data, int index) {
  return GestureDetector(
    onTap: () {
       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return WorkerDetails(name: data.name, number: data.number, age:data. age, jobcategories:data. jobcategories,image: data.image!,);
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
                        return EditScreen(name: data.name, number:data. number, age:data.age, jobCategories:data. jobcategories, index: index, image:data.image!,);
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
   Widget buildStudentList() {
    return Consumer2<WorkerProvider,Workerdetail>(
      builder: (context, dbvalue, mirror, child)  {
        mirror.filteredworkerList = List.from(mirror.workersList); 
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = dbvalue.workersList[index];
            return buildStudentCard(data, index);
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount:dbvalue.workersList.length,
        );
      },
    );
  }
}