import 'package:chat_app/domain/use_cases/fetch_contact_use_case.dart';
import 'package:chat_app/presentation/bloc/contact/contact_bloc_bloc.dart';
import 'package:chat_app/presentation/bloc/contact/contact_bloc_event.dart';
import 'package:chat_app/presentation/screen/contact_page.dart';
import 'package:chat_app/presentation/screen/menu_page.dart';
import 'package:chat_app/presentation/screen/message_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int myIndex = 0;
  List<Widget> widgetList =[
    const MessagePage(),
    Text('AL'),
    const ContactPage(),
    const MenuPage(),
    
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: widgetList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        onTap: (index){
          setState(() {
            myIndex = index;
          });
          if (index == 2) {
            BlocProvider.of<ContactsBloc>(context).add(FetchContacts());
          }
        },
        currentIndex: myIndex,
        items: [
        BottomNavigationBarItem(
          icon: ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            child: Image.asset('assets/icons/speech-bubble.png', width: 25, height: 25,),
          ),
          activeIcon: ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),
            child: Image.asset('assets/icons/speech-bubble.png', width: 25, height: 25),
          ),
          label: 'Chat',
          backgroundColor: Colors.indigo
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/chat-gpt.png', width: 25, height: 25,),
          label: 'Meta Al',
          backgroundColor: Colors.indigo
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/contact-book.png', width: 25, height: 25,),
          label: 'Friends',
          backgroundColor: Colors.indigo
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/menu-bar.png', width: 25, height: 25,),
          label: 'Menu',
          backgroundColor: Colors.indigo
        )
      ]),


    );
  }
  
}