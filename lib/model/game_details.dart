import 'user.dart';

class GameDetails {
  String? id;
  DateTime? title;
  List<String>? usersIds;
  String? createdAt;
  String? updatedAt;
  int? v;
  List<Show>? shows;
  List<User>? users;
  List<TotalCount>? totalCount;

  GameDetails({
    this.id,
    this.title,
    this.usersIds,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.shows,
    this.users,
    this.totalCount,
  });

  factory GameDetails.fromMap(Map<String, dynamic> json) => GameDetails(
    id: json["_id"],
    title: json["title"] == null ? null : DateTime.parse(json["title"]),
    usersIds: json["usersIds"] == null ? [] : List<String>.from(json["usersIds"]!.map((x) => x)),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
    shows: json["shows"] == null ? [] : List<Show>.from(json["shows"]!.map((x) => Show.fromMap(x))),
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromMap(x))),
    totalCount: json["totalCount"] == null ? [] : List<TotalCount>.from(json["totalCount"]!.map((x) => TotalCount.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "title": "${title!.year.toString().padLeft(4, '0')}-${title!.month.toString().padLeft(2, '0')}-${title!.day.toString().padLeft(2, '0')}",
    "usersIds": usersIds == null ? [] : List<dynamic>.from(usersIds!.map((x) => x)),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "shows": shows == null ? [] : List<dynamic>.from(shows!.map((x) => x.toMap())),
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toMap())),
    "totalCount": totalCount == null ? [] : List<dynamic>.from(totalCount!.map((x) => x.toMap())),
  };
}

class Show {
  List<Point>? points;
  String? id;
  String? createdAt;
  String? updatedAt;

  Show({
    this.points,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Show.fromMap(Map<String, dynamic> json) => Show(
    points: json["points"] == null ? [] : List<Point>.from(json["points"]!.map((x) => Point.fromMap(x))),
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toMap() => {
    "points": points == null ? [] : List<dynamic>.from(points!.map((x) => x.toMap())),
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class Point {
  String? userId;
  int? score;
  bool? isWinner;
  String? id;
  User? user;

  Point({
    this.userId,
    this.score,
    this.isWinner,
    this.id,
    this.user,
  });

  factory Point.fromMap(Map<String, dynamic> json) => Point(
    userId: json["userId"],
    score: json["score"],
    isWinner: json["isWinner"],
    id: json["_id"],
    user: json["user"] == null ? null : User.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "score": score,
    "isWinner": isWinner,
    "_id": id,
    "user": user?.toMap(),
  };
}

class TotalCount {
  String? userId;
  int? total;
  bool? isWinner;
  String? id;
  String? createdAt;
  String? updatedAt;
  User? user;

  TotalCount({
    this.userId,
    this.total,
    this.isWinner,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory TotalCount.fromMap(Map<String, dynamic> json) => TotalCount(
    userId: json["userId"],
    total: json["total"],
    isWinner: json["isWinner"],
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    user: json["user"] == null ? null : User.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "total": total,
    "isWinner": isWinner,
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "user": user?.toMap(),
  };
}
