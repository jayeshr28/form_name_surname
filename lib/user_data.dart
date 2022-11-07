class Data {
  String host, topic, userID, password;
  int port;

  Data(
      {required this.host,
      required this.port,
      required this.topic,
      required this.userID,
      required this.password});

  Data.fromJson(Map<String, dynamic> json)
      : host = json['host'],
        port = json['port'],
        topic = json['topic'],
        userID = json['userID'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'host': host,
        'port': port,
        'topic': topic,
        'userID': userID,
        'password': password
      };
}
