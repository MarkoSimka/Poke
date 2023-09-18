class Group {
  final String name;
  final String description;
  final bool status;
  final List<String> userIds;
  late String image;

  Group(
      {required this.name,
      required this.description,
      required this.status,
      required this.userIds});

  factory Group.fromFirestore(Map<String, dynamic> data) {
    print(data['userIds']);
    return Group(
        name: data['name'],
        description: data['description'],
        status: data['status'],
        userIds: List<String>.from(data['userIds']));
  }
}
