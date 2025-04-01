import 'package:chat_app/constant.dart';
import 'package:chat_app/presentation/screen/chat_page.dart';
import 'package:chat_app/presentation/screen/forgot_password_page.dart';
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
          const SizedBox(height: 20,),
          Container(
            height: 100,
            padding: const EdgeInsets.all(5),
            child: ListView(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              children: [
                _buildMyInfo(context, "https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png", ""),
                _buildRecentContact("test","https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png","hôm nay vui quá hhhhhhhhhhh",true,context),
                _buildRecentContact("test","https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png","hôm nay vui quá hhhhhhhhhhh",true,context),
                _buildRecentContact("test","https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png","hôm nay vui quá hhhhhhhhhhh",true,context),
                _buildRecentContact("test","https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png","hôm nay vui quá hhhhhhhhhhh",true,context),
              ],

            ),
          ),

          Expanded(
            child: Container(
              child: ListView(
                children: [
                 GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ChatPage()));
                  },
                  child:  _buildMessageTitle('Peter', 'abcccc', "https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png", '08:30',false),
                 )

                ]
              ),
            )
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
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              // Avatar 
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(url),
              ),
              
              // Bong bóng chat
              if(note.isNotEmpty)
              Positioned(
                top: -20,
                left: 0,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPassword()));
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 70),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text(
                      note, 
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines:  2,
                    ),
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

  Widget _buildMyInfo(BuildContext context, String url, String note){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // Avatar 
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(url),
              ),
              
              // Bong bóng chat
              Positioned(
                top: -20,
                left: 0,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPassword()));
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 70),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text(
                      note.isEmpty ? 'Chia sẽ suy nghĩ' : note, 
                      style: const TextStyle(color: Colors.white, fontSize: 12, ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ) ,
                ),
              ),             
            ],
          ),
          const SizedBox(height: 5,),
          const Text('Ghi chú của....')

        ],
      ),
    );
  }
  
  Widget _buildMessageTitle(String name, String message, String url, String time, bool isOnline){
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: 
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(url),  
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
              ),

              if(!isOnline)
              Positioned(
                bottom: 5,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  width: 25,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(time, style: const TextStyle(color: Colors.green),),
                )
              )
            ],
          ),

      title: Text(
        name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(color: Colors.grey),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        time,
        style: const TextStyle(color: Colors.grey),
      ),

    );
  }
}