import 'package:chat_app/domain/use_cases/add_contact_use_case.dart';
import 'package:chat_app/domain/use_cases/check_or_create_conversation_use_case.dart';
import 'package:chat_app/domain/use_cases/fetch_contact_use_case.dart';
import 'package:chat_app/presentation/bloc/contact/contact_bloc_event.dart';
import 'package:chat_app/presentation/bloc/contact/contact_bloc_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState>{
  final FetchContactUseCase fetchContactUseCase;
  final AddContactUseCase addContactUseCase;
  final CheckOrCreateConversationUseCase checkOrCreateConversationUseCase;

  ContactsBloc({required this.fetchContactUseCase, required this.addContactUseCase, required this.checkOrCreateConversationUseCase}):
  super(ContactsInitial()){
    on<FetchContacts>(_onFetchContacts);
    on<AddContact>(_onAddContact);
    on<CheckOrCreateConversation>(_onCheckOrCreateConversation);
  }

  Future<void> _onFetchContacts(FetchContacts event, Emitter<ContactsState> emit) async{
    emit(ContactsLoading());
    try {
      final contacts = await fetchContactUseCase();
      emit(ContactsLoaded(contacts)); 
    } catch (e) {
      print(e);
      emit(ContactsError('Fail to fetch contacts')); 
    }
  }

  Future<void> _onAddContact(AddContact event, Emitter<ContactsState> emit) async{
    emit(ContactsLoading());
    try {
      await addContactUseCase(email: event.email);
      emit(ContactsAdded()); 
      add(FetchContacts());
    } catch (e) {
      print(e);
      emit(ContactsError('Fail to fetch contacts')); 
    }
  }

  Future<void> _onCheckOrCreateConversation(CheckOrCreateConversation event, Emitter<ContactsState> emit) async{
    try {
      emit(ContactsLoading());
      final conversationId = await checkOrCreateConversationUseCase(contactId: event.contactId);
      emit(ConversationReady(conversationId: conversationId, contactName: event.contactName));
    } catch (e) {
      print(e);
      emit(ContactsError("Faild to start conversation"));
    }

  }
  
}

