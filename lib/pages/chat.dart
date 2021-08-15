import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lovepeople_firebase/model/message.dart';
import 'package:lovepeople_firebase/model/room_chat.dart';
import 'package:lovepeople_firebase/repository/auth_repository.dart';
import 'package:lovepeople_firebase/repository/chat_repository.dart';
import 'package:lovepeople_firebase/widgets/item_message.dart';

class ChatPage extends StatefulWidget {
  static Map route = {
    routeName: (context) => ChatPage(
          room: ModalRoute.of(context)?.settings.arguments as RoomChat?,
        ),
  };
  static String routeName = '/chat';

  final RoomChat? room;
  const ChatPage({Key? key, this.room}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatRepository _chatRepository;
  TextEditingController _controller = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  User? user;
  List<Message> messages = [];

  @override
  void initState() {
    _initRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.room?.name ?? ''),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ItemMessage(
                  item: messages[index],
                  isMine: messages[index].email == user?.email,
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Campo Obrigatorio';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.send),
                    ),
                    onPressed: () async {
                      if (user != null &&
                          formKey.currentState?.validate() == true) {
                        await _chatRepository.addMessage(
                          Message(
                            email: user!.email ?? '',
                            userName: user!.displayName ?? '',
                            urlAvatar: user!.photoURL ?? '',
                            text: _controller.text,
                          ),
                        );
                        _controller.text = '';
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _initRepository() async {
    user = await AuthRepository().getUserSign();
    _chatRepository = ChatRepository()
      ..initChat(
        widget.room!.name.replaceAll(' ', ''),
      );
    _chatRepository.listenMessages((messages) {
      setState(() {
        this.messages = messages.reversed.toList();
      });
    });
  }
}
