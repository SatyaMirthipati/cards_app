class User {
  String? id;
  bool? isSuperUser;
  String? name;
  String? mobile;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? v;

  User({
    this.id,
    this.isSuperUser,
    this.name,
    this.mobile,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["_id"],
    isSuperUser: json["isSuperUser"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    password: json["password"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "isSuperUser": isSuperUser,
    "name": name,
    "mobile": mobile,
    "email": email,
    "password": password,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}