import 'package:flutter/material.dart';

class DialogCreateRoom extends StatefulWidget {
  final ValueChanged<String>? onCreate;
  const DialogCreateRoom({Key? key, this.onCreate}) : super(key: key);

  @override
  _DialogCreateRoomState createState() => _DialogCreateRoomState();
}

class _DialogCreateRoomState extends State<DialogCreateRoom> {
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
                TextField(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Criar'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
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
