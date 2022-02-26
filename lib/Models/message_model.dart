class MessageModel{
  String? message;
  DateTime? dateTime;
  String? sentTo;
  String? sentBy;
  MessageModel({
    this.message,
    this.dateTime,
    this.sentBy,
    this.sentTo,
});
  Map<String, dynamic> asMap() {
    return {
      'message':message,
      'dateTime':dateTime,
      'sent_to':sentTo,
      'sent_by':sentBy,
    };
  }
}