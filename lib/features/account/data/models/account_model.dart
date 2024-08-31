import 'package:movie_app/features/account/domain/entities/account.dart';

class AccountModel extends Account {
  AccountModel({
    required super.id,
    required super.iso_639_1,
    required super.iso_3166_1,
    required super.name,
    required super.include_adult,
    required super.username,
    required super.avatar});

  AccountModel.fromJson(Map<String, dynamic> json):
      super(
        id: json['id'],
        iso_639_1: json['iso_639_1'],
        iso_3166_1: json['iso_3166_1'],
        name: json['name'],
        include_adult: json['include_adult'],
        username: json['username'],
        avatar: json['avatar']
      );
}