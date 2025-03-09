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
      body: Column(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecentContact("test","https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png","abc",true,context)
              ],

            ),
          )
        ]
      ),

      
    );
  }

  Widget _buildRecentContact(String name, String url, String note, bool isOnline, BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Stack(
            children: [
              // Avatar 
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(url),
              ),
              
              // Bong bóng chat
              if(note.isNotEmpty)
              Positioned(
                top: 0,
                left: 10,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPassword()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text(note, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ) ,
                ),
              ),

              if(isOnline)
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2)
                  ),
                )
              )

            ],
          ),
          const SizedBox(height: 5,),
          Text(name)

        ],
      ),
    );
  }
  
}