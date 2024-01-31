
import 'dart:io';
import 'package:contracterApp/controller/worker_provider.dart';
import 'package:contracterApp/controller/home_provider.dart';
import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:contracterApp/view/details.dart';
import 'package:contracterApp/view/edit.dart';
import 'package:contracterApp/view/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Painting extends StatefulWidget {
  final String? selectedJobCategory;
  const Painting({super.key, this.selectedJobCategory});
  @override
  // ignore: library_private_types_in_public_api
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<Painting> {
  String ? image;
  @override
  void initState() {
    super.initState(); 
    Provider.of<WorkerProvider>(context,listen: false). getAllStud();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          title: const Text('PaintWorkers'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              
         Navigator.push(context,MaterialPageRoute(builder:(context) =>  const Searchworker()));  
            }, icon: const Icon(Icons.search,color: Colors.white,))
          ],
  ),
    body: buildStudentList(),
  ));}
   
 
Widget buildStudentCard(Jobworkers data, int index) {
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
                              Provider.of<WorkerProvider>(context,listen: false).deletestud(index);
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
    return 
     Consumer<WorkerProvider>(
  builder: (context, dbvalue, child) {
    final filteredWorkerList = dbvalue.workersList
        .where((worker) => worker.jobcategories.contains('Painting'))
        .toList();
    
    Provider.of<Workerdetail>(context).filteredworkerList = List.from(filteredWorkerList);

    return ListView.separated(
      itemBuilder: (ctx, index) {
        final data = filteredWorkerList[index];
        return buildStudentCard(data, index); // Assuming you have a function called buildWorkerCard to build each worker card.
      },
      separatorBuilder: (ctx, index) {
        return const Divider();
      },
      itemCount: filteredWorkerList.length,
    );
  },
);

  }
}
