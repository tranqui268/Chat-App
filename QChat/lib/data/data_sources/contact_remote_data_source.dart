import 'dart:convert';

import 'package:chat_app/data/models/contact_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class ContactRemoteDataSource{
  final String baseUrl = "http://10.0.2.2:5000/api";
  final _storage = FlutterSecureStorage();

  Future<List<ContactModel>> fetchContacts() async{
    String token = await _storage.read(key: 'token') ?? '';
    final response = await http.get(
      Uri.parse('$baseUrl/contact/'),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      print("data: $data");
      return data.map((json) => ContactModel.fromJson(json)).toList();
    } else{
      throw Exception('Failed to fetch contacts');
    }
  }

  addContact({required String email}) async{
    String token = await _storage.read(key: 'token') ?? '';
    final response = await http.post(
      Uri.parse('$baseUrl/contact/'),
      body: jsonEncode({'email': email}),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode != 201) {
      throw Exception("Fail to add contact");
    }

  }
}