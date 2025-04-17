abstract class ChatEvent{}

class LoadMessagesEvent extends ChatEvent{
  final String conservationId;
  LoadMessagesEvent(this.conservationId);
}

class SendMessageEvent extends ChatEvent{
  final String conservationId;
  final String text;
  SendMessageEvent(this.conservationId,this.text);
}

class ReceiveMessageEvent extends ChatEvent{
  final Map<String, dynamic> message;
  ReceiveMessageEvent(this.message);
}