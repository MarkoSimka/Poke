class Group {
  final String name;
  final String description;
  final bool status;
  late String image;

  Group({required this.name, required this.description, required this.status});

  factory Group.fromFirestore(Map<String, dynamic> data) {
    return Group(
      name: data['name'],
      description: data['description'],
      status: data['status']
    );
  }
}
