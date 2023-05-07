import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twilio_flutter/twilio_flutter.dart';

final String baseUrl = 'http://127.0.0.1:5000';

/// The entry point of the application.
/// It runs the [MaterialApp] widget with the [HomeScreen] as the default screen.
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
    title: 'TextPy',
    home: HomeScreen(),
  ));
}

/// The home screen widget.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen] instance.
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//Home screen

      backgroundColor: Color(0xff000001),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://img.freepik.com/free-photo/beautiful-rendering-colorful-circles_53876-97645.jpg?size=626&ext=jpg&ga=GA1.2.602118684.1677986394&semt=ais'),
            // Fitting the image to cover the whole area
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              //Adding blue-grey color to the image
              Color(0xff427542),
              //Modulating the color blend mode
              BlendMode.modulate,
            ),
          ),
        ),

        //Stack widget for overlaying widgets
        child: Stack(
          children: [
            Align(
              //Aligning the text widget
              alignment: Alignment(-0.4, -0.1),
              child: Text(
                'Welcome to',
                style: TextStyle(
                  fontFamily: "Italiana",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  //Settinsg the text color
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              //Aligning the text widget
              alignment: Alignment(0.0, 0.04),
              child: Text(
                'TextPy',
                style: TextStyle(
                  fontFamily: 'West End Knights',
                  fontSize: 68,
                  //Setting the text color
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              //Aligning the text widget
              alignment: Alignment(0.0, 0.18),
              child: Text(
                'A new way to send messages',
                style: TextStyle(
                  fontSize: 15,
                  //Setting the text color
                  color: Colors.grey,
                ),
              ),
            ),
            Align(
              //Aligning the text widget
              alignment: Alignment.bottomCenter,
              child: Text(
                'From '
                'Webcraft',
                style: TextStyle(
                  fontSize: 15,
                  //Setting the text color
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),

      //Adding a floating action button
      floatingActionButton: SizedBox(
        child: Align(
          //Aligning the floating action button
          alignment: Alignment(0.1, 0.4),
          child: FittedBox(
            child: FloatingActionButton.extended(
                label: Text(
                  "Click to Start",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                //Setting the background color
                backgroundColor: Colors.green,
                onPressed: () {
                  //Navigating to the second page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

/// A second page widget that displays a list of users and a floating action button that navigates to the chat page.
class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _formSubmitted = false;

  bool isValidPhoneNumber(String value) {
    if (value.isEmpty) {
      return false;
    }
    return RegExp(r'^\+\d{10}$').hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                    hintText: '+1234567890',
                    errorText: _formSubmitted && _phoneController.text.isEmpty
                        ? 'Please enter a phone number'
                        : _formSubmitted &&
                                !isValidPhoneNumber(_phoneController.text)
                            ? 'Please enter a valid phone number'
                            : null,
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    hintText: 'Hello, world!',
                    errorText: _formSubmitted && _messageController.text.isEmpty
                        ? 'Please enter a message'
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => send_SMS(
                      context, _messageController.text, _phoneController.text),
                  child: const Text('Send Message'),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

/// A message class that stores the text, date, and whether the message was sent by the user or not.
class Message {
  final String text;
  final DateTime date;
  final bool isSentbyMe;

  const Message({
    required this.text,
    required this.date,
    required this.isSentbyMe,
  });
}

/// A page that displays a chat interface.
class ChatPage extends StatelessWidget {
  /// The list of messages in the chat.
  List<Message> messages = [
    Message(
      text: 'Yes sure!',
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isSentbyMe: false,
    ),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//Home screen
      backgroundColor: Colors.black,
      body: Column(
        children: [
          /// The input field for typing a new message.
          Container(
              color: Colors.grey.shade300,
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Type your message here...',
                ),
              ))
        ],
      ),
    );
  }
}
