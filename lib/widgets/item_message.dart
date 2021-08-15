import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return Row(
      children: [
        if (!isMine)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    item.urlAvatar,
                    width: 50,
                    height: 50,
                  ),
                ),
                Text(_getName()),
              ],
            ),
          ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: isMine ? width : 10.0,
              right: !isMine ? width : 10.0,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(40),
                  color: isMine ? Theme.of(context).primaryColor : Colors.white,
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
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _getTime(),
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isMine)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    item.urlAvatar,
                    width: 50,
                    height: 50,
                  ),
                ),
                Text(item.userName.split(' ').first),
              ],
            ),
          ),
      ],
    );
  }

  String _getName() {
    try {
      return item.userName.split(' ').first;
    } catch (E) {
      return '';
    }
  }

  String _getTime() {
    DateTime time = item.getDateTime();
    return DateFormat('dd-MM-yyyy hh:mm').format(time);
  }
}
