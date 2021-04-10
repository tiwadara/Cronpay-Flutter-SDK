import 'package:cron_pay/src/transactions/models/Chronology.dart';

class CreatedOn {
  Chronology chronology;
  int dayOfMonth;
  String dayOfWeek;
  int dayOfYear;
  int hour;
  int minute;
  String month;
  int monthValue;
  int nano;
  int second;
  int year;

  CreatedOn(
      {this.chronology,
      this.dayOfMonth,
      this.dayOfWeek,
      this.dayOfYear,
      this.hour,
      this.minute,
      this.month,
      this.monthValue,
      this.nano,
      this.second,
      this.year});

  factory CreatedOn.fromJson(Map<String, dynamic> json) {
    return CreatedOn(
      chronology: json['chronology'] != null
          ? Chronology.fromJson(json['chronology'])
          : null,
      dayOfMonth: json['dayOfMonth'],
      dayOfWeek: json['dayOfWeek'],
      dayOfYear: json['dayOfYear'],
      hour: json['hour'],
      minute: json['minute'],
      month: json['month'],
      monthValue: json['monthValue'],
      nano: json['nano'],
      second: json['second'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayOfMonth'] = this.dayOfMonth;
    data['dayOfWeek'] = this.dayOfWeek;
    data['dayOfYear'] = this.dayOfYear;
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    data['month'] = this.month;
    data['monthValue'] = this.monthValue;
    data['nano'] = this.nano;
    data['second'] = this.second;
    data['year'] = this.year;
    if (this.chronology != null) {
      data['chronology'] = this.chronology.toJson();
    }
    return data;
  }
}
