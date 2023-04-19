import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The entry point of the application.
/// It runs the [MaterialApp] widget with the [HomeScreen] as the default screen.
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
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
      backgroundColor: Colors.black,

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://img.freepik.com/free-photo/beautiful-rendering-colorful-circles_53876-97645.jpg?size=626&ext=jpg&ga=GA1.2.602118684.1677986394&semt=ais'),
            // Fitting the image to cover the whole area
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              //Adding blue-grey color to the image
              Colors.blueGrey,
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
              alignment: Alignment(-0.6, -0.12),
              child: Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 23,
                  fontStyle: FontStyle.italic,
                  //Setting the text color
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              //Aligning the text widget
              alignment: Alignment(0.0, 0.05),
              child: Text(
                'T e x t P y',
                style: TextStyle(
                  fontFamily: 'West End Knights',
                  fontSize: 70,
                  //Setting the text color
                  color: Colors.white,
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
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Setting the background color
                backgroundColor: Colors.green,
                onPressed: () {
                  //Navigating to the second page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondPage()),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

/// A second page widget that displays a list of users and a floating action button that navigates to the chat page.
class SecondPage extends StatelessWidget {
  /// Creates a second page widget with the given [key].
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Home screen
      backgroundColor: Colors.black,
      // App bar widget
      appBar: AppBar(
        //Widget
        title: Text(
          // Setting the app bar title
          'Messages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        //Setting the background color of the app bar
        backgroundColor: Colors.black45,
      ),
      //Adding a custom scroll view
      body: CustomScrollView(
        slivers: [
          //Adding a sliver to the custom scroll view
          SliverToBoxAdapter(
            //Stories widget
            child: Stories(),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Text('users ',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 15,
                  ));
            }),
          ),
        ],
      ),

      floatingActionButton: SizedBox(
        child: Align(
          alignment: Alignment(0.1, 1),
          child: FittedBox(
            child: FloatingActionButton.extended(
                label: Text(
                  "Next Page",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

/// A widget that displays a list of stories.
class Stories extends StatelessWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
//Stories
      elevation: 0,
      color: Colors.grey[800],
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stories',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Text('users ',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 15,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
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
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(8),

              /// The list of messages to be displayed in the chat.
              elements: messages,

              /// The grouping method for the messages (in this case, by year).
              groupBy: (message) => DateTime(2023),

              /// The builder for the group headers (in this case, an empty SizedBox).
              groupHeaderBuilder: (Message message) => SizedBox(),

              /// The builder for the individual messages (in this case, an empty Container).
              itemBuilder: (context, Message message) => Container(),
            ),
          ),

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
