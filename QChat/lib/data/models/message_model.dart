import 'package:chat_app/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity{
  MessageModel({
    required super.id, 
    required super.senderId, 
    required super.conservationId, 
    required super.text, 
    required super.createdAt
  });

  factory MessageModel.fromJson(Map<String, dynamic> json){
    return MessageModel(
      id: json['_id'], 
      senderId: json['senderId'],
      conservationId: json['chatId'], 
      text: json['text'], 
      createdAt: json['createdAt']
    );
  }
  
}