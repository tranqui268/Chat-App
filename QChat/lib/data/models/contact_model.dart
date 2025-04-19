import 'package:chat_app/domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity{
  ContactModel({
    required super.id, 
    required super.name, 
    required super.avatar,
    required super.email
  });

  factory ContactModel.fromJson(Map<String, dynamic> json){
    final contactIdData = json['contactId'] as Map<String, dynamic>?;
    return ContactModel(
      id: contactIdData != null ? contactIdData['_id']?.toString() ?? '' : '', 
      name: contactIdData != null ? contactIdData['name']?.toString() ?? '' : '', 
      avatar: contactIdData != null ? contactIdData['avatar']?.toString() ?? '' : '',
      email: contactIdData != null ? contactIdData['email'].toString() ?? '' : '',
    );
  }
  
}