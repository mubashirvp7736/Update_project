import 'package:contracterApp/controller/add_provider.dart';
import 'package:contracterApp/controller/edit_provider.dart';
import 'package:contracterApp/controller/login_Page.dart';
import 'package:contracterApp/controller/profile_provider.dart';
import 'package:contracterApp/controller/worker_provider.dart';
import 'package:contracterApp/controller/search_provider.dart';
import 'package:contracterApp/controller/tab_view.dart';
import 'package:contracterApp/controller/home_provider.dart';
import 'package:contracterApp/model/profile_model/profile_model.dart';
import 'package:contracterApp/model/worker_model/worker_model.dart';
import 'package:contracterApp/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

// ignore: constant_identifier_names
const save_key='';
 Future <void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
   if (!Hive.isAdapterRegistered(JobworkersAdapter().typeId)) {
     Hive.registerAdapter(JobworkersAdapter());
  }
if (!Hive.isAdapterRegistered(ProfileModelAdapter().typeId)){
  Hive.registerAdapter(ProfileModelAdapter());
}
  runApp(const Myhome());
}

class Myhome extends StatelessWidget {
  const Myhome({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Workerdetail>(create: (context) => Workerdetail()),
        ChangeNotifierProvider<Tabviewdetail>(create: (context) => Tabviewdetail()),
        ChangeNotifierProvider<WorkerProvider>(create: (context)=>WorkerProvider()),
        ChangeNotifierProvider<Addworkers>(create: (context) => Addworkers(),),
        ChangeNotifierProvider(create:(context) => SearchProvider(),),
        ChangeNotifierProvider(create:(context) => ProfileProvider(),),
        ChangeNotifierProvider(create: (context) => Editprovider(),),
        ChangeNotifierProvider(create: (context) => LoginPage(),)
      ],
      child: const MaterialApp(
        home: Splash(),
        debugShowCheckedModeBanner:false,
      ),
    );
    }
   }
