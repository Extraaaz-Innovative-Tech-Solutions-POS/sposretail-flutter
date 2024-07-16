class User {
  int? id;
  String? name;
  var phone;
  var state;
  String? email;
  String? role;

  User({this.id, this.name, this.phone, this.state, this.email, this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    state = json['state'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['state'] = this.state;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}