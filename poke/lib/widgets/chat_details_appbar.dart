import 'package:flutter/material.dart';
import 'package:poke/models/group.dart';

class ChatDetails extends StatefulWidget implements PreferredSizeWidget {
  final Group group;
  const ChatDetails({super.key, required this.group});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
  
  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _ChatDetailsState extends State<ChatDetails> {
  @override
  Widget build(BuildContext context) {
    const IconData person = IconData(0xe491, fontFamily: 'MaterialIcons',);
    String status = "Offline";
    if(widget.group.status){
      status = "Online";
    }

    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              const Icon(person),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.group.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      status,
                      style: TextStyle(color: widget.group.status ? Colors.green : Colors.red , fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert,
                color: Colors.grey.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
