// ignore: unused_element
class AppUser {
  final int id;
  final String name;
  final String nickName;
  final String email;
  final List<int> group_ids;

  AppUser({
    required this.id,
    required this.name,
    required this.nickName,
    required this.email,
    required this.group_ids,
  });

  // Convert the Product object to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nickName': nickName,
      'email': email,
      'group_ids': group_ids
    };
  }
}
