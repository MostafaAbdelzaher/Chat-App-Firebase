import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Builder(builder: (context) {
        ChatCubit.get(context).getCurrentUser();
        ChatCubit.get(context).getMessagesStream();
        return BlocConsumer<ChatCubit, ChatStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = ChatCubit.get(context);
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: null,
                  actions: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pop(context);
                        }),
                  ],
                  title: const Text('⚡️Chat'),
                  backgroundColor: Colors.lightBlueAccent,
                ),
                body: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          reverse: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          children: cubit.messagesBubble,
                        ),
                      ),
                      Container(
                        decoration: kMessageContainerDecoration,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: textController,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (value) {},
                                decoration: kMessageTextFieldDecoration,
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                cubit
                                    .sendMessage(
                                        textMessage: textController.text)
                                    .then((value) {});
                                textController.clear();
                              },
                              child: const Text(
                                'Send',
                                style: kSendButtonTextStyle,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
