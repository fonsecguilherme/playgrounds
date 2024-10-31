import 'dart:convert';

class GithubUser {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
  final String url;

  GithubUser({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
  });

  factory GithubUser.fromJson(String str) =>
      GithubUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GithubUser.fromMap(Map<String, dynamic> json) => GithubUser(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "avatar_url": avatarUrl,
        "gravatar_id": gravatarId,
        "url": url,
      };
}
