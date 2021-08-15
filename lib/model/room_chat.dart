class RoomChat {
  String name;
  RoomChat({this.name = ''});

  RoomChat.fromJson(Map json):name = json['name'];

  Map toJson() {
    return {
      'name': name,
    };
  }
}
