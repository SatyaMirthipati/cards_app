import 'game_details.dart';
import 'user.dart';

class Game {
  String? status;
  List<TotalCount>? totalCount;
  String? id;
  DateTime? title;
  List<String>? usersIds;
  String? createdAt;
  String? updatedAt;
  int? v;
  List<Show>? shows;

  Game({
    this.status,
    this.totalCount,
    this.id,
    this.title,
    this.usersIds,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.shows,
  });

  factory Game.fromMap(Map<String, dynamic> json) => Game(
    status: json["status"],
    totalCount: json["totalCount"] == null ? [] : List<TotalCount>.from(json["totalCount"]!.map((x) => TotalCount.fromMap(x))),
    id: json["_id"],
    title: json["title"] == null ? null : DateTime.parse(json["title"]),
    usersIds: json["usersIds"] == null ? [] : List<String>.from(json["usersIds"]!.map((x) => x)),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
    shows: json["shows"] == null ? [] : List<Show>.from(json["shows"]!.map((x) => Show.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "totalCount": totalCount == null ? [] : List<dynamic>.from(totalCount!.map((x) => x.toMap())),
    "_id": id,
    "title": "${title!.year.toString().padLeft(4, '0')}-${title!.month.toString().padLeft(2, '0')}-${title!.day.toString().padLeft(2, '0')}",
    "usersIds": usersIds == null ? [] : List<dynamic>.from(usersIds!.map((x) => x)),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "shows": shows == null ? [] : List<dynamic>.from(shows!.map((x) => x.toMap())),
  };
}
