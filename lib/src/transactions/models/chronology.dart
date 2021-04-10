class Chronology {
    String calendarType;
    String id;

    Chronology({this.calendarType, this.id});

    factory Chronology.fromJson(Map<String, dynamic> json) {
        return Chronology(
            calendarType: json['calendarType'], 
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['calendarType'] = this.calendarType;
        data['id'] = this.id;
        return data;
    }
}