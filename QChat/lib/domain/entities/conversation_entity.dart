class ConversationEntity{
  final String id;
  final List<String> members;
  final String participantId;
  final String lastMessage;
  final String lastMessageTime;

  ConversationEntity({required this.id,required this.members, required this.participantId, required this.lastMessage, required this.lastMessageTime});

  

}