import 'package:chat_app/domain/entities/conversation_entity.dart';
import 'package:intl/intl.dart';

class ConversationModel extends ConversationEntity{
  ConversationModel({required super.id, required super.members, required super.participantId, required super.lastMessage, required super.lastMessageTime});
  
  factory ConversationModel.fromJson(Map<String, dynamic> json){
    if (!json.containsKey('members') || json['members'] is! List) {
      throw Exception('Invalid JSON: "members" key is missing or not a list');
    }

    List<dynamic> members = json['members'];
    if (members.length < 2) {
      throw Exception('Members array does not have enough elements');
    }

    String participantId = members[1];
    String formattedLastMessageTime = '';
    if (json['lastMessageTime'] != null) {
      final dateTime = DateTime.parse(json['lastMessageTime']);
      formattedLastMessageTime = DateFormat('HH:mm').format(dateTime);
    }
    return ConversationModel(
      id: json['_id'], 
      members: (json['members'] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      participantId: participantId, 
      lastMessage: json['lastMessageContent'], 
      lastMessageTime: formattedLastMessageTime
    );

  }
}