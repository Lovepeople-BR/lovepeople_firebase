import 'package:flutter/material.dart';
import 'package:lovepeople_firebase/model/message.dart';

class ItemMessage extends StatelessWidget {
  final Message item;
  final bool isMine;
  const ItemMessage({Key? key, required this.item, this.isMine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = (size.width / 4);
    return Container(
      margin: EdgeInsets.only(
        left: isMine ? width : 20.0,
        right: !isMine ? width : 20.0,
        bottom: 20,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(40),
        color: isMine ? Theme.of(context).primaryColor : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            item.text,
            style: TextStyle(
              color: isMine ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
