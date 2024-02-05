
import 'package:contracterApp/controller/login_Page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLogin extends StatelessWidget {
   UserLogin({super.key});
   final _username=TextEditingController();
   final _password=TextEditingController();
 final _form=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:const Color.fromARGB(255, 224, 235, 188),
       appBar: AppBar(
        title: const Text('User Login'),
        backgroundColor:const Color.fromARGB(255, 78, 80, 72)),
       body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
         child: Column(
           children:[ 
            SizedBox(
              height: MediaQuery.of(context).size.height*0.4,
            //  color: Color.fromARGB(255, 140, 148, 112),
             child: const Image(image: AssetImage('assets/user-removebg-preview.png')),
            ),
            
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: MediaQuery.of(context).size.height*0.43,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 90, 97, 68),
                  borderRadius: BorderRadius.circular(50)
                ),
                //  Color:Color.fromARGB(255, 224, 235, 188),
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                       TextFormField(
                        controller:_username ,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: 
                          OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white,
                          ),
                     borderRadius: BorderRadius.circular(60),), 
                       focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30)
                      ),
                    
                     hintText: 'UserName',),
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                     
                     const SizedBox(height: 16,),
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                     controller: _password,
                      style: const TextStyle(color: Colors.white),
                     decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30)
                      ),
                     hintText: 'Passwod'),
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      } else {
                        return null;
                      }
                    },
                  ),

                     
                      const SizedBox(height: 17,),
                     
                 ElevatedButton(
                     style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: (){
                    if(_form.currentState!.validate()){
                    Provider.of<LoginPage>(context,listen: false).checkLogin(context,_username,_password);
                     }else{
                        }
                        null;
                  //  checkLogin(conteyxt,_username,_password);
                     },
                  child:const Text('SUBMIT',style: TextStyle(color: Colors.black),)
                      )
                    ],
                  ),
                ),
              ),
            ),
              ]  ),
       )
        );
  }
}