class Message {
  String email;
  String userName;
  String urlAvatar;
  String text;

  Message({
    this.email = '',
    this.userName = '',
    this.urlAvatar = '',
    this.text = '',
  });

  Message.fromJson(Map json)
      : email = json['email'],
        userName = json['userName'],
        urlAvatar = json['urlAvatar'],
        text = json['text'];

  Map toJson() {
    return {
      'email': email,
      'userName': userName,
      'urlAvatar': urlAvatar,
      'text': text,
    };
  }
}
