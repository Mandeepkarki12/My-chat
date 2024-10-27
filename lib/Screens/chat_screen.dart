import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/Services/Auth/auth_service.dart';
import 'package:my_chat/Services/Chat/chat_services.dart';
import 'package:my_chat/Widgets/chat_bubble.dart';
import 'package:my_chat/Widgets/my_textfield.dart';

class ChatScreen extends StatefulWidget {
  final String recieverEmail;
  final String recieverId;
  ChatScreen(
      {super.key, required this.recieverEmail, required this.recieverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth services
  final ChatServices _chatServices = ChatServices();

  final AuthService _authService = AuthService();

  // for text field focus
  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up
        // then the amount of time remaining space will be calulated
        // then scroll down
        Future.delayed(
          const Duration(microseconds: 500),
          () => scrollDown(),
        );
      }
    });
    // wait for the listview to be build , then scrol down
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  // method to send message
  void sendMessage() async {
    // if there is something inside the textfields
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
          widget.recieverId, _messageController.text);
      // clear the controller
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.recieverEmail, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
      ),
      body: Column(
        children: [
          // Display all messages
          Expanded(
            child: _buildMessageList(),
          ),
          // user input
          _buildMessageInput()
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatServices.getMessages(widget.recieverId, senderId),
        builder: (context, snapshot) {
          // errors
          if (snapshot.hasError) {
            return Text('Error');
          }

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }

          // return list view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    // align message to the right if the sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
        ],
      ),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: Row(
        children: [
          Expanded(
              child: MyTextfield(
            hintText: 'Type a message . . .',
            obscureText: false,
            controller: _messageController,
            focusNode: myFocusNode,
          )),
          // send button
          Container(
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  sendMessage();
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
