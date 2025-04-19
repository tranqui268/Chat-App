import 'package:chat_app/presentation/bloc/contact/contact_bloc_bloc.dart';
import 'package:chat_app/presentation/bloc/contact/contact_bloc_event.dart';
import 'package:chat_app/presentation/bloc/contact/contact_bloc_state.dart';
import 'package:chat_app/presentation/screen/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactsBloc>(context).add(FetchContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: BlocListener<ContactsBloc, ContactsState>(
        listener: (context, state) {
          if (state is ConversationReady) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatPage(
                        conservationId: state.conversationId,
                        mate: state.contactName)));
          }
        },
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ContactsLoaded) {
              return ListView.builder(
                  itemCount: state.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = state.contacts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(contact.avatar),
                      ),
                      title: Text(contact.name),
                      onTap: () {
                        BlocProvider.of<ContactsBloc>(context).add(
                            CheckOrCreateConversation(
                                contact.id, contact.name));
                      },
                    );
                  });
            } else if (state is ContactsError) {
              return Center(
                child: Text(state.message),
              );
            }
            return const Center(
              child: Text('No contacts found'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final emailController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add contact"),
              content: TextField(
                controller: emailController,
                decoration:
                    const InputDecoration(hintText: 'Enter contact email'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      final email = emailController.text.trim();
                      if (email.isNotEmpty) {
                        BlocProvider.of<ContactsBloc>(context)
                            .add(AddContact(email));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'))
              ],
            ));
  }
}
