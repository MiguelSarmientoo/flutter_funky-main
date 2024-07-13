import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../widgets/chat_message.dart';
import '../widgets/chat_box_footer.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [];
  TextEditingController _controller = TextEditingController();
  final String userId = '2'; // Este debería ser dinámico basado en el usuario logueado
  ScrollController _scrollController = ScrollController(); // Controlador de scroll

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Liberar el controlador de scroll
    super.dispose();
  }

  Future<void> _fetchMessages() async {
    final url = Uri.parse('https://6aef-190-232-119-12.ngrok-free.app/api/messages');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          messages = data.map((item) {
            return {
              'id': item['id'] ?? '',
              'text': item['content'] ?? '',
              'time': item['created_at'] != null ? DateFormat('HH:mm').format(DateTime.parse(item['created_at'])) : '',
              'user_id': item['user_id']?.toString() ?? '',
              'created_at': item['created_at'] ?? '',
            };
          }).toList();
          messages.sort((a, b) => DateTime.parse(b['created_at']).compareTo(DateTime.parse(a['created_at'])));
        });
      } else {
        print('Error al obtener mensajes: ${response.statusCode}');
      }
    } catch (error) {
      print('Error en la solicitud HTTP: $error');
    }
  }

  Future<void> _sendMessage(String text) async {
    final url = Uri.parse('https://6aef-190-232-119-12.ngrok-free.app/api/guardarMensaje');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'content': text,
          'userId': userId,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        setState(() {
          messages.insert(
            0,
            {
              'id': responseData['id'] ?? '',
              'text': text,
              'time': DateFormat('HH:mm').format(DateTime.now()),
              'user_id': userId,
              'created_at': responseData['created_at'] ?? '',
            },
          );
        });

        // Scroll para mostrar el nuevo mensaje
        _scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        print('Error al enviar el mensaje: ${response.statusCode}');
      }
    } catch (error) {
      print('Error en la solicitud HTTP: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 205, 205, 205),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 114, 68, 166),
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/logo_funcy_scale.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Funcy IA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Asignar el controlador de scroll
              reverse: true, // Para mostrar los mensajes desde el más reciente hasta el más antiguo
              itemCount: messages.length,
              itemBuilder: (context, index) {
                // Verificar si los campos son nulos antes de acceder a ellos
                final text = messages[index]['text'] ?? '';
                final time = messages[index]['time'] ?? '';
                final user_id = messages[index]['user_id'] ?? '';
                
                // Determinar el tipo de usuario para mostrar el mensaje
                final userType = user_id == userId ? 1 : 2;
                
                return ChatMessage(
                  message: text,
                  time: time,
                  userId: user_id,
                  userType: userType,
                );
              },
            ),
          ),
          ChatBoxFooter(
            textEditingController: _controller,
            onSendMessage: (text) {
              _sendMessage(text);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
