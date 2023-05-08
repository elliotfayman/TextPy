import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter_sms/flutter_sms.dart';

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

final TextEditingController _messageController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
bool _formSubmitted = false;

bool isValidPhoneNumber(String value) {
  if (value.isEmpty) {
    return false;
  }
  return RegExp(r'^\+\d{11}$').hasMatch(value);
}

/// A second page widget that displays a list of users and a floating action button that navigates to the chat page.
class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
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
                  onPressed: () => errorChecker(
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

  Future<void> errorChecker(
      BuildContext context, String message, String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      setState(() {
        _formSubmitted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a phone number'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!isValidPhoneNumber(phoneNumber)) {
      setState(() {
        _formSubmitted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid phone number'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (message.isEmpty) {
      setState(() {
        _formSubmitted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a message'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('SMS sent successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      List<String> conversation = await _sendSMS(message, [phoneNumber]);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatPage(conversation: conversation)),
      );
    }
  }
}

/// A page that displays a chat interface.
Future<List<String>> _sendSMS(String message, List<String> recipients) async {
  print("Sending message: $message");
  print("Recipients: $recipients");
  String _result = await sendSMS(message: message, recipients: recipients)
      .catchError((onError) {
    print(onError);
  });
  print("Result: $_result");
  return recipients.map((recipient) => "$message\n You").toList();
}

class ChatPage extends StatelessWidget {
  final List<String> conversation;

  const ChatPage({Key? key, required this.conversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: conversation.length,
        itemBuilder: (BuildContext context, int index) {
          String message = conversation[index];
          List<String> splitMessage = message.split('\n');

          if (splitMessage.length == 2) {
            // The message contains both sent and received messages
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    splitMessage[0], // Sent message
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    splitMessage[1], // Received message
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            );
          } else {
            // The message only contains a received message
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Text(
                message,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.start,
              ),
            );
          }
        },
      ),
    );
  }
}
