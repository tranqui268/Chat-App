import 'package:chat_app/constant.dart';
import 'package:chat_app/presentation/bloc/message/message_bloc_bloc.dart';
import 'package:chat_app/presentation/bloc/message/message_bloc_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../bloc/message/message_bloc_state.dart';


class ChatPage extends StatefulWidget {
  final String conservationId;
  final String mate;
  const ChatPage({super.key, required this.conservationId, required this.mate});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isMenuExpanded = false;
  bool _isTyping = false;
  final TextEditingController _messageController = TextEditingController();
  final _storage = FlutterSecureStorage();
  String userId = '';
  
  @override
  void initState() {
    super.initState();
    print(widget.conservationId);
    BlocProvider.of<ChatBloc>(context).add(LoadMessagesEvent(widget.conservationId));
    fetchUserId();

    _messageController.addListener(() {
      setState(() {
        _isTyping = _messageController.text.isNotEmpty;
      });
      
    });
  }

  fetchUserId() async{
    userId = await _storage.read(key: "userId") ?? '';
    setState(() {
      userId = userId;
    });
  }

  void _sendMessage(){
    final content = _messageController.text.trim();
    if (content.isNotEmpty) {
      BlocProvider.of<ChatBloc>(context).add(
        SendMessageEvent(widget.conservationId, content)
      );
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage("https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png"),
            ),
            const SizedBox(width: 10,),
            Text(
              '${widget.mate}',
              style:const TextStyle(fontSize: 16),
            )
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child : BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state){
                if (state is ChatLoadingState) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is ChatLoadedState){
                  return  ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index){
                      final message = state.messages[index];
                      final isSendMessage = message.senderId == userId;
                      if (isSendMessage) {
                        return _builSendMessage(context, message.text);                        
                      }else{
                        return _buildReceivedMessage(context, message.text);
                      }
                    },
                  );

                }else if (state is ChatErrorState){
                  return Center(child: Text(state.message),);
                }
                return const Center(child: Text("No message found"),);
              },
            )
           
          ),
          _buildExpandableMenu(),
          _buildInputMessage(),
          
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String message){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          message
        ),
      ),
    );
  }

  Widget _builSendMessage(BuildContext context, String message){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          message
        ),
      ),
    );
  }

  Widget _buildInputMessage(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          _isTyping ?
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.arrow_back, color: Constants.primaryColor,)
          ) :
          Row(
            children: [
              IconButton(
              icon: Icon(
                _isMenuExpanded ? Icons.close : Icons.add,
                color: Constants.primaryColor,
              ),
              onPressed: (){
                setState(() {
                  _isMenuExpanded = !_isMenuExpanded;
                });
              },            
              ),
              IconButton(
                icon: const Icon(
                  Icons.camera_alt, 
                  color: Constants.primaryColor,
                ),
                onPressed: (){},
              ),
              IconButton(
                icon: const Icon(
                  Icons.image, 
                  color: Constants.primaryColor,
                ),
                onPressed: (){},
              ),
              IconButton(
                icon: const Icon(
                  Icons.mic, 
                  color: Constants.primaryColor,
                ),
                onPressed: (){},
              ),
            ],
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0)
                      ),
                    )
                  ),
                  IconButton(
                    icon: Icon(
                      _isTyping ? Icons.search :  Icons.emoji_emotions_outlined,
                      color: Constants.primaryColor,
                    ),
                    onPressed: (){}
                    )

                ],
              ),
            )
          ),

          IconButton(
            icon: Icon(
              _isTyping ? Icons.send : Icons.thumb_up,
              color: Constants.primaryColor,
            ),
            onPressed: _sendMessage
             
          )

        ],
      ),
    );
  }

  Widget _buildExpandableMenu(){
    return Align(
      alignment: Alignment.centerLeft,
      child : AnimatedContainer(
      width: _isMenuExpanded ? MediaQuery.of(context).size.width / 2 : 0,
      duration: const Duration(microseconds: 300),
      height: _isMenuExpanded ?  150 : 0,
      curve: Curves.easeInOut,
      color: Colors.grey[200],
      child: _isMenuExpanded ?
        SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.image, color: Constants.primaryColor,),
                title: const Text('Image'),
                onTap: (){},
              ),
              ListTile(
                leading: const Icon(Icons.attach_file, color: Constants.primaryColor,),
                title: const Text('Flie'),
                onTap: (){},
              ),
              ListTile(
                leading: const Icon(Icons.location_on, color: Constants.primaryColor,),
                title: const Text('Position'),
                onTap: (){},
              ),
            ]
          ),

        )
        : null

    )

    );
  }
}

