import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    required this.color,
    required this.text,
    required this.onPress,
    Key? key,
  }) : super(key: key);
  final Color color;
  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      onPress();
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      text,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget messageBubbleItem({
  String? sender,
  String? text,
  required bool isMe,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              '$sender',
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 40,
              width: 170,
              child: Material(
                color: isMe ? Colors.lightBlueAccent : Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: isMe ? const Radius.circular(25) : Radius.zero,
                    bottomLeft: const Radius.circular(25),
                    bottomRight: const Radius.circular(25),
                    topRight: !isMe ? const Radius.circular(25) : Radius.zero),
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Center(
                    child: Text(
                      '$text',
                      style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );

// StreamBuilder<QuerySnapshot>(
//   stream: _fireStore.collection('message').snapshots(),
//   builder: (context, snapshot) {
//     List<Text> messagesWidgets = [];
//     if (!snapshot.hasData) {
//       return const CircularProgressIndicator();
//     }
//     {
//       final messages = snapshot.data!.docs;
//       for (var message in messages) {
//         final messageSender = message["sender"];
//         final messageText = message['text'];
//         final messageWidgets =
//             Text('$messageText from $messageSender');
//         messagesWidgets.add(messageWidgets);
//       }
//     }
//     return Column(
//       children: messagesWidgets,
//     );
//   },
// ),
