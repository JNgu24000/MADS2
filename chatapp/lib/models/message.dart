class Message {
  final String id;
  final String message;
  final String time;
  final bool isRead;

  Message(
      {required this.id,
      required this.message,
      required this.time,
      required this.isRead});

  Message.fromJson(String id, Map<String, dynamic> json)
      : this(
            id: id,
            message: json["message"],
            time: json["time"],
            isRead: json["isRead"]);

  Map<String, dynamic?> toJson() {
    return {"message": message, "time": time, "isRead": isRead};
  }
}
