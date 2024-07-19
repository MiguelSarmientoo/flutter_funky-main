import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final String time;
  final String userId; // Agregar userId aquí
  final int userType;

  const ChatMessage({
    Key? key,
    required this.message,
    required this.time,
    required this.userId, // Añadir userId como parámetro
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color messageTextColor = userType == 2 ? Colors.white : Colors.black;
    Color timeTextColor =
        userType == 2 ? Color.fromARGB(255, 203, 203, 203) : Color.fromARGB(255, 119, 119, 119);

    String avatarImage = userType == 2 ? 'assets/user_img.jpg' : 'assets/logo_funcy_scale.png';
    return Column(
      crossAxisAlignment: userType == 2 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        userType == 2 ? Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'You',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 6.0),
                          CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.asset(
                                avatarImage,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  :
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.asset(
                                avatarImage,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        SizedBox(width: 6.0),
                        Text(
                          'Funcy',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
        Align(
          alignment: userType == 2 ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(
              top: userType == 2 ? 4.0 : 0.0,
              bottom: 4.0,
              left: userType == 2 ? 80.0 : 50.0,
              right: userType == 2 ? 50.0 : 80.0,
            ),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: userType == 2 ? Color(0xFF3D4A7A) : Color(0xFFF2F7FB),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(fontSize: 16.0, color: messageTextColor),
                ),
                SizedBox(height: 5.0),
                Text(
                  time,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 12.0, color: timeTextColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
