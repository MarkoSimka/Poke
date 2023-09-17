import 'package:flutter/material.dart';
import 'package:poke/models/group.dart';

class GroupWidget extends StatefulWidget {
  const GroupWidget({super.key, required this.group});
  final Group group;

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.group.name),
          ],
        )
      ),
    );
  }
}
