class Page {
  int size;
  int totalElements;
  int totalPages;
  int number;

  Page({
      this.size, 
      this.totalElements, 
      this.totalPages, 
      this.number});

  Page.fromJson(dynamic json) {
    size = json["size"];
    totalElements = json["totalElements"];
    totalPages = json["totalPages"];
    number = json["number"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["size"] = size;
    map["totalElements"] = totalElements;
    map["totalPages"] = totalPages;
    map["number"] = number;
    return map;
  }

}