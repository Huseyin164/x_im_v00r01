// Project service path
// ignore_for_file: public_member_api_docs

enum ProductServicePath {
  userV1('api/v1/users'),
  posts('posts'),
  usersV2('v2/users'),
  login('api/v1/auth'),
  secure('secure');

  const ProductServicePath(this.value);
  final String value;

  /// [withQuery] is add query to path
  ///
  /// Example: users/123
  String withQuery(String value) {
    return '${this.value}/$value';
  }
}
