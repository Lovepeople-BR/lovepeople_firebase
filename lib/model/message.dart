class Message {
  int id;
  String email;
  String userName;
  String urlAvatar;
  String text;
  String time;

  Message({
    this.id = 0,
    this.email = '',
    this.userName = '',
    this.urlAvatar = '',
    this.text = '',
    this.time = '',
  });

  Message.fromJson(Map json)
      : id = json['id'] ?? 0,
        email = json['email'],
        userName = json['userName'],
        urlAvatar = json['urlAvatar'],
        text = json['text'],
        time = json['time'];

  DateTime getDateTime() {
    return DateTime.parse(time);
  }

  Map toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'urlAvatar': urlAvatar,
      'text': text,
      'time': time,
    };
  }
}
