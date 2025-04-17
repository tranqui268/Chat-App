import 'dart:convert';

import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MessageRemoteDataSource {
  final String baseUrl = 'http://10.0.2.2:5000/api';
  final _storage = FlutterSecureStorage();

  Future<List<MessageEntity>> fetMessages(String conservationId) async{
    String token = await _storage.read(key: 'token') ?? '';
    final response = await http.get(
      Uri.parse('$baseUrl/message/$conservationId'),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['messages'];
      return data.map((json) => MessageModel.fromJson(json)).toList();
    }else{
      throw Exception("Failed to fetch Messages");
    }
  }
}