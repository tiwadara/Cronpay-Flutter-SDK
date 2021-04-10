import 'package:cron_pay/src/payment/models/card_meta.dart';

class PaymentMethod {
    String description;
    String id;
    String logo;
    CardMeta meta;
    String name;
    int sort;

    PaymentMethod({this.description, this.id, this.logo, this.meta, this.name, this.sort});

    factory PaymentMethod.fromJson(Map<String, dynamic> json) {
        return PaymentMethod(
            description: json['description'], 
            id: json['id'], 
            logo: json['logo'], 
            meta: json['meta'] != null ? CardMeta.fromJson(json['meta']) : null, 
            name: json['name'],
            sort: json['sort'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['description'] = this.description;
        data['id'] = this.id;
        data['logo'] = this.logo;
        data['name'] = this.name;
        data['sort'] = this.sort;
        if (this.meta != null) {
            data['meta'] = this.meta.toJson();
        }
        return data;
    }
}