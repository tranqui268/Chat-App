import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isMenuExpanded = false;
  bool _isTyping = false;
  final TextEditingController _messageController = TextEditingController();
  
  @override
  void initState() {
    super.initState();

    _messageController.addListener(() {
      setState(() {
        _isTyping = _messageController.text.isNotEmpty;
      });
      
    });
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
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png"),
            ),
            SizedBox(width: 10,),
            Text(
              'Danny',
              style: TextStyle(fontSize: 16),
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
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildReceivedMessage(context, 'Test test'),
                _builSendMessage(context, 'Test test')
              ],
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
            onPressed: (){
              if (_isTyping) {
                _messageController.clear();
              }
            }
             
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

