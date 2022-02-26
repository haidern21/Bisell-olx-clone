import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:bisell_olx_clone/Models/message_model.dart';
import 'package:bisell_olx_clone/Widgets/chat_bubble_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/chat_provider.dart';

class ConversationScreen extends StatefulWidget {
  final String receiverUserId;

  const ConversationScreen({Key? key, required this.receiverUserId})
      : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  String userName = '';
  String profileUrl =
      'https://e7.pngegg.com/pngimages/647/460/png-clipart-computer-icons-open-person-family-icon-black-silhouette-black.png';
  bool isCurrentUserMessage = false;
  bool isSendingMessage = false;
  TextEditingController messageController = TextEditingController();
  final MessageModel messageModel = MessageModel();
  var focusNode=FocusNode();
  getReceiverData() async {
    DocumentSnapshot value = await FirebaseFirestore.instance
        .collection(kUsers)
        .doc(widget.receiverUserId)
        .get();
    String tempUserName = value.get(kUserName);
    String tempProfileUrl = value.get(kProfilePicUrl) ??
        'https://e7.pngegg.com/pngimages/647/460/png-clipart-computer-icons-open-person-family-icon-black-silhouette-black.png';
    setState(() {
      userName = tempUserName;
      profileUrl = tempProfileUrl;
    });
  }

  @override
  void initState() {
    getReceiverData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider = Provider.of(context);
    chatProvider.getTwoUserChats(
        FirebaseAuth.instance.currentUser!.uid.toString(),
        widget.receiverUserId);
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  profileUrl,
                  fit: BoxFit.cover,
                )),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
          child: Column(
            children: [
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ChatBubbleWidget(
                          text: chatProvider.messages[index].message!,
                          dateTime:
                              chatProvider.messages[index].dateTime.toString(),
                          isYourMessage: chatProvider.messages[index].sentBy ==
                                  FirebaseAuth.instance.currentUser!.uid
                                      .toString()
                              ? true
                              : false,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                      itemCount: chatProvider.messages.length)),
              // Expanded(
              //   child: StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('chats')
              //         .where('sent_by',
              //             isEqualTo:
              //                 FirebaseAuth.instance.currentUser!.uid.toString(),)
              //         // .where('sent_to',
              //         //     isEqualTo:
              //         //         FirebaseAuth.instance.currentUser!.uid.toString())
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (snapshot.data == null) {
              //         return Container();
              //       }
              //       return ListView(
              //         children: snapshot.data!.docs.map((snapshot) {
              //           // isCurrentUserMessage = snapshot.get('sent_by') ==
              //           //         FirebaseAuth.instance.currentUser!.uid.toString()
              //           //     ? true
              //           //     : false;
              //           // return ChatBubbleWidget(
              //           //   isYourMessage: isCurrentUserMessage,
              //           //   dateTime: (snapshot.get('dateTime') as Timestamp)
              //           //       .toDate()
              //           //       .toString(),
              //           //   text: snapshot.get('message'),
              //           // );
              //           return Center(child: Text(snapshot.get('message')));
              //         }).toList(),
              //       );
              //     },
              //   ),
              // ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    focusNode: focusNode,
                    controller: messageController,
                    decoration: InputDecoration(
                        hintText: 'Enter message',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            )),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        suffixIcon: InkWell(
                            onTap: () async {
                              try {
                                if (FirebaseAuth.instance.currentUser != null &&
                                    messageController.text.isNotEmpty) {
                                  setState(() {
                                    isSendingMessage = true;
                                  });
                                  messageModel.message = messageController.text;
                                  messageModel.sentBy = FirebaseAuth
                                      .instance.currentUser!.uid
                                      .toString();
                                  messageModel.sentTo = widget.receiverUserId;
                                  messageModel.dateTime = DateTime.now();
                                  await FirebaseFirestore.instance
                                      .collection('chats')
                                      .add(messageModel.asMap());
                                  messageController.clear();
                                  await FirebaseFirestore.instance
                                      .collection(kUsers)
                                      .doc(FirebaseAuth.instance.currentUser!.uid
                                          .toString())
                                      .collection('contacts')
                                      .doc(widget.receiverUserId)
                                      .set({
                                    'userId': widget.receiverUserId,
                                  });
                                  await FirebaseFirestore.instance
                                      .collection(kUsers)
                                      .doc(widget.receiverUserId)
                                      .collection('contacts')
                                      .doc(FirebaseAuth.instance.currentUser!.uid
                                          .toString())
                                      .set({
                                    'userId': FirebaseAuth
                                        .instance.currentUser!.uid
                                        .toString(),
                                  });
                                  //     .add({
                                  //   'received_by': widget.receiverUserId,
                                  //   'sent_by': FirebaseAuth
                                  //       .instance.currentUser!.uid
                                  //       .toString(),
                                  //   'message': messageController.text,
                                  //   'dateTime': DateTime.now(),
                                  //   'sent_to':widget.receiverUserId,
                                  // });
                                  setState(() {
                                    isSendingMessage = false;
                                  });
                                }
                              } on FirebaseException catch (e) {
                                if (kDebugMode) {
                                  print(
                                      'THE MESSAGE NOT SENT BECAUSE  ${e.message}');
                                  print(
                                      'THE MESSAGE NOT SENT BECAUSE  ${e.message}');
                                  print(
                                      'THE MESSAGE NOT SENT BECAUSE  ${e.message}');
                                }
                              }
                            },
                            child: isSendingMessage == false
                                ? const Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                  )
                                : const SizedBox(
                                    height: 30,
                                    child: CircularProgressIndicator()))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
