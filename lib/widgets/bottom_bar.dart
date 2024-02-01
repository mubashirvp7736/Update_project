
import 'package:contracterApp/controller/worker_provider.dart';
import 'package:contracterApp/view/add_worker.dart';
import 'package:contracterApp/view/search.dart';
import 'package:contracterApp/view/show_profile.dart';
import 'package:contracterApp/view/home_list.dart';
import 'package:contracterApp/view/settings.dart';
import 'package:contracterApp/view/categorie_tab.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen ({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
     int indexnum = 0;

  List widGets = [
  const   ListWorkers(),
      const AddWorker(),
       TabPage(),
       Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer:const ScreenDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title:const Text('HomePage',style: TextStyle(color:Color(0xFFF6EDE3) ),),
          actions: [
            IconButton(onPressed: (){
           Navigator.push(context,MaterialPageRoute(builder:(context) =>const  Searchworker()));  
            }, icon:const Icon(Icons.search)),
            IconButton(
              onPressed: () {
             Provider.of<WorkerProvider>(context,listen: false).showPopupMenu(context);
              },
              icon:const Icon(Icons.more_vert_outlined),
            ),
            
          ],
          backgroundColor: const Color.fromARGB(255, 69, 107, 59),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          buttonBackgroundColor: const Color(0xFF8ec9bc),
          color:const Color.fromARGB(255, 69, 107, 59),
          items:const [
           Icon(Icons.home),
            Icon(Icons.add_circle,size: 40,),
            Icon(Icons.table_rows_sharp),  
            Icon(Icons.settings,), 
          ],
          backgroundColor:Colors.white,
          // currentIndex: indexnum,
          onTap: (int index) {
            setState(() {
              indexnum = index;
            });
          
          },
        ),
        body: widGets.elementAt(indexnum),
      ),
    );
  }
}