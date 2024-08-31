class Account {
  int id;
  String iso_639_1;
  String iso_3166_1;
  String name;
  bool include_adult;
  String username;
  Map<String, dynamic> avatar;

  Account({
    required this.id,
    required this.iso_639_1,
    required this.iso_3166_1,
    required this.name,
    required this.include_adult,
    required this.username,
    required this.avatar
  });
}

