// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends INetworkModel<User> with EquatableMixin {
  User({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.avatar_url,
    this.email,
    this.full_name,
  });

  /// Get user from json
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int? userId;
  final int? id;
  final String? title;
  final String? body;
  final String? avatar_url;
  final String? email;
  final String? full_name;

  /*
   işleyiş sırasından bakarsan 1. factory contructure çalışır  _$UserFromJson(json) tetiklenir ,
   sonrasında bu fonksiyon aldığı parametreleri user clasının constucterına atar,
   sonrasında this.user ıd gibi olan constucterlar class içerisinde bulunan final int?userid
   ye atamayı yapar .
  */
  @override
  List<Object?> get props =>
      [userId, id, title, body, avatar_url, email, full_name];

  /// User model to map object
  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  User fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  User copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
    String? avatar_url,
    String? email,
    String? full_name,
  }) {
    return User(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      avatar_url: avatar_url ?? this.avatar_url,
      email: email ?? this.email,
      full_name: full_name ?? this.full_name,
    );
  }
}


// {
//     "userId": 1,
//     "id": 1,
//     "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//     "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
//   }
