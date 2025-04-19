import 'package:chat_app/data/data_sources/contact_remote_data_source.dart';
import 'package:chat_app/domain/entities/contact_entity.dart';
import 'package:chat_app/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl extends ContactRepository{
  final ContactRemoteDataSource remoteDataSource;

  ContactRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addContact({required String email}) async{
    await remoteDataSource.addContact(email: email);
  }

  @override
  Future<List<ContactEntity>> fetchContacts() async{
    return await remoteDataSource.fetchContacts();
  }

}