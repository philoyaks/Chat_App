class Message {
  String senderId;
  String time;

  String content;
  int type;
  String timeStamp;

  Message({this.senderId, this.time, this.content, this.type, this.timeStamp});

  Message.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    time = json['time'];
    content = json['content'];
    type = json['type'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['time'] = this.time;
    data['content'] = this.content;
    data['type'] = this.type;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}
