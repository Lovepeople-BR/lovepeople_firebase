import 'package:flutter/material.dart';
import 'package:lovepeople_firebase/model/room_chat.dart';
import 'package:lovepeople_firebase/pages/chat.dart';
import 'package:lovepeople_firebase/repository/room_repository.dart';
import 'package:lovepeople_firebase/widgets/dialog_create_room.dart';

class HomePage extends StatefulWidget {
  static Map route = {
    routeName: (context) => HomePage(),
  };
  static String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RoomRepository _repository;
  List<RoomChat> rooms = [];
  @override
  void initState() {
    _repository = RoomRepository();
    _loadRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 4,
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ChatPage.routeName,
                  arguments: rooms[index],
                );
              },
              title: Text(rooms[index].name),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialogCreateRoom();
        },
      ),
    );
  }

  void _loadRooms() {
    _repository.listenRooms((value) {
      setState(() {
        rooms = value;
      });
    });
  }

  void _showDialogCreateRoom() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return DialogCreateRoom(
          onCreate: (name) {
            if (!rooms.contains(name)) {
              _repository.creteRoom(name);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sala já existe!')),
              );
            }
          },
        );
      },
    );
  }
}
