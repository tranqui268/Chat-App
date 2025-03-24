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
            child: _MenuItem('assets/icons/settings.png', 'Setting'),
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
}

