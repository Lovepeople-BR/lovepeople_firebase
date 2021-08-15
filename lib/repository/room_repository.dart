import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lovepeople_firebase/model/room_chat.dart';

class RoomRepository {
  late DatabaseReference reference;

  RoomRepository() {
    final database = FirebaseDatabase.instance.reference();
    reference = database.child('groups');
  }

  Future<List<RoomChat>> getRooms() async {
    final snapshot = await reference.once();
    if (snapshot.value == null) return [];
    final data = Map.from(snapshot.value);
    List<RoomChat> groups = [];
    data.forEach((key, value) {
      groups.add(RoomChat.fromJson(value));
    });
    return groups;
  }

  void listenRooms(ValueChanged<List<RoomChat>> listen) async {
    reference.onValue.listen((event) {
      if (event.snapshot.value == null) {
        return;
      }
      List<RoomChat> groups = [];
      final data = Map.from(event.snapshot.value);
      data.forEach((key, value) {
        groups.add(RoomChat.fromJson(value));
      });
      listen(groups);
    });
  }

  Future<void> creteRoom(String roomName) async {
    return reference.push().set(RoomChat(name: roomName).toJson());
  }
}
