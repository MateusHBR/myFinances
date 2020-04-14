class Date {
  int id;
  String month;
  String year;
  double salary;

  Date({
    this.id,
    this.month,
    this.salary,
  });

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['id'] = id;
    json['month'] = month;
    json['year'] = year;
    json['salary'] = salary;
  }

  Date.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    month = json['month'];
    year = json['year'];
    salary = json['salary'];
  }
}
