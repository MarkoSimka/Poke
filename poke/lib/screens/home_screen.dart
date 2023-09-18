import 'package:flutter/material.dart';
import 'package:poke/models/group.dart';
import 'package:poke/widgets/group_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Moch data
  final List<Group> _groups = [
    Group(name: "Grupa 1", description: "Description 1", status: true),
    Group(name: "Grupa 2", description: "Description 2", status: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('groups').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData || snapshot.data!.docs.isNotEmpty) {
              var documents = snapshot.data?.docs;

              return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color.fromRGBO(94, 109, 177, 1), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListView.builder(
                      itemCount: documents?.length,
                      itemBuilder: (context, index) {
                        var document = documents?[index];
                        var data = document?.data() as Map<String, dynamic>;
                        var group = Group.fromFirestore(data);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GroupWidget(group: group),
                          ],
                        );
                      }),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text("No data");
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
