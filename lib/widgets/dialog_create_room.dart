import 'package:flutter/material.dart';

class DialogCreateRoom extends StatefulWidget {
  final ValueChanged<String>? onCreate;
  const DialogCreateRoom({Key? key, this.onCreate}) : super(key: key);

  @override
  _DialogCreateRoomState createState() => _DialogCreateRoomState();
}

class _DialogCreateRoomState extends State<DialogCreateRoom> {

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Criar nova sala'),
                TextField(
                  controller: _controller,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.onCreate?.call(_controller.text);
                        Navigator.pop(context);
                      },
                      child: Text('Criar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
