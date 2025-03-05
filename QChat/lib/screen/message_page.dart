import 'package:chat_app/constant.dart';
import 'package:chat_app/screen/forgot_password_page.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget{
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("messeger", style: TextStyle(
          color: Colors.white
        ),),
        toolbarHeight: 70,
        backgroundColor: Constants.primaryColor,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> ForgotPassword() ));
            }, 
            icon: Image.asset('assets/icons/edit.png', width: 30, height: 30,) 
            )
        ],
      ),
      body: Container(),

      
    );
  }
  
}