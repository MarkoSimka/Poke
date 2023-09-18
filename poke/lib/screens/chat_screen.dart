import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:poke/home.dart';
import 'package:poke/models/chat_message.dart';
import 'package:poke/models/group.dart';
import 'package:poke/models/send_menu_items.dart';
import 'package:poke/widgets/chat_bubble.dart';
import 'package:poke/widgets/chat_details_appbar.dart';

enum MessageType {
  Sender,
  Reciever,
}

class ChatPage extends StatefulWidget {
  final Group group;
  final String? groupId;
  const ChatPage({super.key, required this.group, required this.groupId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? _address = "";
  // Moch data
  // List<ChatMessage> chatMessage = [
  //   ChatMessage(message: "Hi John", type: MessageType.Reciever),
  //   ChatMessage(message: "Hope you are doing good", type: MessageType.Reciever),
  //   ChatMessage(
  //       message: "Hello Jane, I'm good what about you?",
  //       type: MessageType.Sender),
  //   ChatMessage(
  //       message: "I'm fine, working from home", type: MessageType.Reciever),
  //   ChatMessage(message: "Oh! Nice. Same here", type: MessageType.Sender),
  // ];

  List<SendMenuItems> sendMenuItems = [
    SendMenuItems(
        text: "Photos & Videos", icons: Icons.image, color: Colors.amber),
    SendMenuItems(
        text: "Send location",
        icons: Icons.location_on_sharp,
        color: Colors.amber)
  ];

  Future<void> _sendLocation() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    CollectionReference messages =
        FirebaseFirestore.instance.collection('messages');
    await _getCurrentLocation();
    await messages
        .add({
          'message': _address,
          'timestamp': Timestamp.fromDate(DateTime.now()),
          'userId': uid,
          'groupId': widget.groupId,
        })
        .then((value) => {
          messageController.text = "",
          Navigator.pop(context)
        })
        .catchError((error) => print("Failed to add group: $error"));
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("Permissions denied");
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      await requestLocationPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Fetch the address
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Extract the address
      Placemark place = placemarks[0];
      setState(() {
        _address = "${place.street}, ${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
      setState(() {
        _address = 'Could not fetch address';
      });
    }
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            color: const Color(0xff737373),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    itemCount: sendMenuItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: _sendLocation,
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: sendMenuItems[index].color.shade50,
                              ),
                              height: 50,
                              width: 50,
                              child: Icon(
                                sendMenuItems[index].icons,
                                size: 20,
                                color: sendMenuItems[index].color.shade400,
                              ),
                            ),
                            title: Text(sendMenuItems[index].text),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  final messageController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    CollectionReference messages =
        FirebaseFirestore.instance.collection('messages');
    print("Sending messages");
    await messages
        .add({
          'message': messageController.text,
          'timestamp': Timestamp.fromDate(DateTime.now()),
          'userId': uid,
          'groupId': widget.groupId,
        })
        .then((value) => messageController.text = "")
        .catchError((error) => print("Failed to add group: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetails(group: widget.group),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("messages")
            .where('groupId', isEqualTo: widget.groupId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color.fromRGBO(94, 109, 177, 1), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Stack(
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No messages, say hi!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, bottom: 10),
                      height: 80,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showModal();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 21,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  hintText: "Type message...",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade500),
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.only(right: 30, bottom: 50),
                      child: FloatingActionButton(
                        onPressed: _sendMessage,
                        backgroundColor: const Color.fromRGBO(242, 100, 25, 1),
                        elevation: 0,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color.fromRGBO(94, 109, 177, 1), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Stack(
                children: <Widget>[
                  const CircularProgressIndicator(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, bottom: 10),
                      height: 80,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showModal();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 21,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  hintText: "Type message...",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade500),
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.only(right: 30, bottom: 50),
                      child: FloatingActionButton(
                        onPressed: _sendMessage,
                        backgroundColor: const Color.fromRGBO(242, 100, 25, 1),
                        elevation: 0,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            var messages = snapshot.data?.docs.toList();
            messages?.sort((a, b) {
              return a['timestamp'].compareTo(b['timestamp']);
            });
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color.fromRGBO(94, 109, 177, 1), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: ListView.builder(
                      itemCount: messages?.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        var message = messages?[index];
                        var data = message?.data() as Map<String, dynamic>;
                        var chatMessage = ChatMessage.fromFirestore(data);
                        final User? user = auth.currentUser;
                        final uid = user?.uid;
                        if (chatMessage.userId == uid) {
                          chatMessage.type = MessageType.Sender;
                        } else {
                          chatMessage.type = MessageType.Reciever;
                        }

                        return ChatBubble(
                          chatMessage: chatMessage,
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, bottom: 10),
                      height: 80,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showModal();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 21,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  hintText: "Type message...",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade500),
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.only(right: 30, bottom: 50),
                      child: FloatingActionButton(
                        onPressed: _sendMessage,
                        backgroundColor: const Color.fromRGBO(242, 100, 25, 1),
                        elevation: 0,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
