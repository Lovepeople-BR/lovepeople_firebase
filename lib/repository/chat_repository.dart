import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lovepeople_firebase/model/message.dart';

class ChatRepository {
  DatabaseReference? reference;

  void initChat(String roomName) {
    final database = FirebaseDatabase.instance.reference();
    reference = database.child('chat_$roomName');
  }

  void listenMessages(ValueChanged<List<Message>> listen) {
    reference?.onValue.listen((event) {
      if(event.snapshot.value == null){
        return;
      }
      List<Message> messages = [];
      final data = Map.from(event.snapshot.value);
      data.forEach((key, value) {
        messages.add(Message.fromJson(value));
      });
      listen(messages);
    });
  }

  Future<void>? addMessage(Message message) {
    return reference?.push().set(message.toJson());
  }
}
