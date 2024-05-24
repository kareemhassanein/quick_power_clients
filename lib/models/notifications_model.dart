class NotificationModel {
  final bool success;
  final String? message;
  final List<NotificationData>? data;
  final int? code;

  NotificationModel({
    required this.success,
    this.message,
     this.data,
     this.code,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataList = json['data'];
    List<NotificationData> notifications =
    dataList.map((data) => NotificationData.fromJson(data)).toList();

    return NotificationModel(
      success: json['success'],
      message: json['message'],
      data: notifications,
      code: json['code'],
    );
  }
}

class NotificationData {
  final String id;
  final String title;
  final String body;
  final NotificationDataDetails data;
  final int seen;
  final DateTime createdAt;

  NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.seen,
    required this.createdAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      data: NotificationDataDetails.fromJson(json['data']),
      seen: json['seen'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class NotificationDataDetails {
  final int id;
  final String notifyType;

  NotificationDataDetails({
    required this.id,
    required this.notifyType,
  });

  factory NotificationDataDetails.fromJson(Map<String, dynamic> json) {
    return NotificationDataDetails(
      id: json['id'],
      notifyType: json['notify_type'],
    );
  }
}