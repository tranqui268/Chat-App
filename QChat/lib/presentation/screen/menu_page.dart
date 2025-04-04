import 'package:chat_app/presentation/screen/weather_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu', style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25
        ),
      ),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: (){

            },
            child: _MenuItemInfo('https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png', 'Tran Qui'),
          ),
          GestureDetector(
            onTap: (){

            },
            child: _MenuItem('assets/icons/settings.png', 'Setting'),
          ),
           Container(
            height: 1.0,
            color: Colors.black,
            width: double.infinity,

          ),
          GestureDetector(
            onTap: (){

            },
            child: _MenuItem('assets/icons/store.png', 'Marketplace'),
          ),
          GestureDetector(
            onTap: (){

            },
            child: _MenuItem('assets/icons/messenger.png', 'Message waiting'),
          ),
          GestureDetector(
            onTap: (){

            },
            child: _MenuItem('assets/icons/storage-box.png', 'Storage'),
          ),
          const Padding(
            padding: EdgeInsets.all(5),
            child: Text('More', style: TextStyle(fontSize: 18),),
          ),
          GestureDetector(
            onTap: (){

            },
            child: _MenuItem('assets/icons/friends.png', 'Friend Request'),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => WeatherPage()));

            },
            child: _MenuItem('assets/icons/cloudy.png', 'Weather'),
          )
          
        ],

      ),
    );
  }

  Widget _MenuItem(String url, String itemName){
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Image.asset(url, width: 50, height: 50,),
          const SizedBox(width: 50,),
          Text(itemName, textAlign: TextAlign.center, style: const TextStyle(
            fontSize: 20
          ),
        )
        ]
      ),
    );
  }

  Widget _MenuItemInfo(String url, String name){
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(url),
      ),
      title: Text(name, textAlign: TextAlign.left, style: const TextStyle(color: Colors.black, fontSize:20 ),),
      subtitle: const Text('Change personal page', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 16),),

    );
  }
}

