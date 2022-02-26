import 'package:bisell_olx_clone/Provider/chat_provider.dart';
import 'package:bisell_olx_clone/Screens/Authentication_Screens/signup_screen_without_skip.dart';
import 'package:bisell_olx_clone/Screens/conversation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({Key? key}) : super(key: key);

  @override
  _AllChatsScreenState createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {}
    ChatProvider chatProvider = Provider.of(context);
    chatProvider.getAllChatUsers();
    return FirebaseAuth.instance.currentUser != null
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Chats Screen'),
            ),
            // body:  Center(
            //   child: Image.asset("assets/images/empty_inbox.png"),
            // ),
            body: chatProvider.allChatUsers.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConversationScreen(
                                          receiverUserId: chatProvider
                                              .allChatUsers[index].uid!
                                              .toString(),
                                        )));
                          },
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        child: chatProvider.allChatUsers[index]
                                                    .profileUrl !=
                                                null
                                            ? Image.network(
                                                chatProvider.allChatUsers[index]
                                                    .profileUrl!,
                                                fit: BoxFit.cover,
                                              )
                                            : const Center(
                                                child: Icon(
                                                Icons.person,
                                                size: 40,
                                              )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        chatProvider
                                            .allChatUsers[index].userName!,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                    itemCount: chatProvider.allChatUsers.length)
                : Center(
                    child: Image.asset("assets/images/empty_inbox.png"),
                  ),
          )
        : const SignupScreenWithoutSkip();
  }
}
