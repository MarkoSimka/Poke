import 'package:flutter/material.dart';
import 'package:poke/models/group.dart';
import 'package:poke/widgets/group_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Group> _groups = [
    Group(name: "Grupa 1", description: "Description", status: true),
    Group(name: "Grupa 1", description: "Description", status: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView.builder(
              itemCount: _groups.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GroupWidget(group: _groups[index]),
                  ],
                );
              })),
    );
  }
}
