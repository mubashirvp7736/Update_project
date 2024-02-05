
import 'package:contracterApp/controller/login_Page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
  Provider.of<LoginPage>(context,listen: false).gotoScreen(context);
  Provider.of<LoginPage>(context,listen: false). checkuserlogin(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF7C8363),
      body:Center(
        child: Image(image:AssetImage('assets/splashscreen.png.png'),height: 350,width:360,),
      ) ,
    );
  }

}