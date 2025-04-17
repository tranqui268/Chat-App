import 'dart:convert';

import 'package:chat_app/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class ConversationRemoteDataSource{
  final String baseUrl = 'http://10.0.2.2:5000/api';
  final _storage = FlutterSecureStorage();

  Future<List<ConversationModel>> fetchConversation() async{
    String token = await _storage.read(key: 'token') ?? '';
    final response = await http.get(
      Uri.parse('$baseUrl/chat/'),
      headers: {
        'Authorization': 'Bearer $token'
      }
      
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['chats'];
      return data.map((json) => ConversationModel.fromJson(json)).toList();     
    }else{
      throw Exception('Failed to fetch conversation');
    }
  }
}