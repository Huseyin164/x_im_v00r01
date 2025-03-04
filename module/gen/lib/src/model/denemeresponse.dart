import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'denemeresponse.g.dart';

@JsonSerializable()
class DenemeResponseModel extends INetworkModel<DenemeResponseModel>
    with EquatableMixin {
  DenemeResponseModel({
    this.content,
    this.pageable,
    this.totalPages,
    this.totalElements,
    this.last,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  factory DenemeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DenemeResponseModelFromJson(json);

  final List<Content>? content;
  final Pageable? pageable;
  final int? totalPages;
  final int? totalElements;
  final bool? last;
  final int? size;
  final int? number;
  final Sort? sort;
  final int? numberOfElements;
  final bool? first;
  final bool? empty;

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$DenemeResponseModelToJson(this);

  @override
  List<Object?> get props => [
        content,
        pageable,
        totalPages,
        totalElements,
        last,
        size,
        sort,
        number,
        numberOfElements,
        first,
        empty,
      ];

  @override
  DenemeResponseModel fromJson(Map<String, dynamic> json) {
    return _$DenemeResponseModelFromJson(json);
  }
}

@JsonSerializable()
class Content {
  Content({this.id, this.username, this.email, this.image, this.fullName});

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  String? id;
  String? username;
  String? email;
  String? image;
  String? fullName;

  /// Connect the generated [_$ContentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class Pageable {
  Pageable({
    this.pageNumber,
    this.pageSize,
    this.sort,
    this.offset,
    this.paged,
    this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) =>
      _$PageableFromJson(json);
  int? pageNumber;
  int? pageSize;
  Sort? sort;
  int? offset;
  bool? paged;
  bool? unpaged;

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PageableToJson(this);
}

@JsonSerializable()
class Sort {
  Sort({this.empty, this.sorted, this.unsorted});

  factory Sort.fromJson(Map<String, dynamic> json) => _$SortFromJson(json);

  bool? empty;
  bool? sorted;
  bool? unsorted;

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SortToJson(this);
}
