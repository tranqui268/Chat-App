import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';


class SignUp extends StatelessWidget{
  const SignUp({super.key});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
       elevation: 2.0,
       title: const Text("Sign In", style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        )
       ),
       shadowColor: Colors.green,
       flexibleSpace: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
             colors: [Constants.primaryColor, Colors.greenAccent],
                begin: Alignment.topLeft,
              end: Alignment.topRight
          )         
        ),
       ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        alignment: Alignment.center,
        child: Column(        
          children: [
            _EmailInput(),
            const SizedBox(height: 20,),
            _NameInput()

          ],
        ),
      ),

   );
  }
   
}

class _EmailInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Email Address',
        border: OutlineInputBorder()
      ),
    );
  }
  
}

class _NameInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Fullname',
        border: OutlineInputBorder()
      ),
    );
  }
  
}