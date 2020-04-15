class Gasto {
  int id;
  String title;
  String value;
  int idDate;

  Gasto({
    this.id,
    this.title,
    this.value,
    this.idDate,
  });

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    // json['id'] = id;
    json['title'] = title;
    json['value'] = value;
    json['idDate'] = idDate;

    return json;
  }

  Gasto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
    idDate = json['idDate'];
  }
}
