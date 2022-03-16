import 'package:bloc/bloc.dart';
import 'package:chat_app/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/component.dart';
import '../screens/chat_screen.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialStates());
  static ChatCubit get(context) => BlocProvider.of(context);
  String? currentUser;

  final _fireStore = FirebaseFirestore.instance;
  void getCurrentUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        currentUser = user.email;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMessage({required textMessage}) async {
    await _fireStore.collection("message").add({
      "text": textMessage,
      "sender": currentUser,
      "dateTime": DateTime.now().toString(),
    }).then((value) {
      emit(SendMessagedSuccessesStates());
    }).catchError((onError) {
      emit(SendMessagedErrorStates());
    });
  }

  List<Widget> messagesBubble = [];
  void getMessagesStream() {
    _fireStore
        .collection("message")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      messagesBubble = [];
      for (var message in event.docs.reversed) {
        final messageText = message["text"];
        final messageSender = message["sender"];
        final messageBubble = messageBubbleItem(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender);
        messagesBubble.add(messageBubble);
      }
      emit(GetMessagedSuccessesStates());
    });
  }
}
