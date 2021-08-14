import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Read extends StatefulWidget {
  const Read({Key? key}) : super(key: key);

  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  final database = FirebaseDatabase.instance.reference();
  List<int> increments = [];

  @override
  void initState() {
    final increment = database.child('increment');
    // increment.once().then((snapshot) {
    //   final data = Map.from(snapshot.value);
    //   data.forEach((key, value) {
    //     setState(() {
    //       increments.add(value['valor']);
    //     });
    //   });
    // });

    increment.onValue.listen((event) {
      increments = [];
      final data = Map.from(event.snapshot.value);
      data.forEach((key, value) {
        setState(() {
          increments.add(value['valor']);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: increments.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(increments[index].toString()),
            );
          }),
    );
  }
}
