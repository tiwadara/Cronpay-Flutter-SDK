class EventDate {
  int scheduleId;
  String runDate;

  EventDate({
      this.scheduleId, 
      this.runDate});

  EventDate.fromJson(dynamic json) {
    scheduleId = json["scheduleId"];
    runDate = json["runDate"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["scheduleId"] = scheduleId;
    map["runDate"] = runDate;
    return map;
  }

}