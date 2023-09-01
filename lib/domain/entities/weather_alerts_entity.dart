class WeatherAlertsEntity {
  String? senderName;
  String? event;
  int? start;
  int? end;
  String? description;
  List<String>? tags;

  WeatherAlertsEntity({senderName, event, start, end, description, tags});

  WeatherAlertsEntity.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    event = json['event'];
    start = json['start'];
    end = json['end'];
    description = json['description'];
    if (json['tags'] != null) {
      tags = <String>[];
      json['tags'].forEach((v) {
        tags!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_name'] = senderName;
    data['event'] = event;
    data['start'] = start;
    data['end'] = end;
    data['description'] = description;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v).toList();
    }
    return data;
  }
}
