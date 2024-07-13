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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            userType == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          userType == 2 ? _buildAvatar() : Container(), // Mostrar avatar solo para userType 2
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          userType == 1 ? _buildAvatar() : Container(), // Mostrar avatar solo para userType 1
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 16,
      child: Text(
        userId,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
