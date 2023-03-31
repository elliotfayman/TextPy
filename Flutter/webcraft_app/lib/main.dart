import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextPy',
    home: FirstPage(),
  ));
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

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
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.blueGrey,
              BlendMode.modulate,
            ),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(-0.5, -0.12),
              child: Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 23,
                  // fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.05),
              child: Text(
                'TextPy',
                style: TextStyle(
                  fontFamily: 'West End Knights',
                  fontSize: 90,
                  // fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        child: Align(
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
                backgroundColor: Colors.green,
                onPressed: () {
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

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Home screen
      backgroundColor: Colors.black,
      appBar: AppBar(
        //Widget
        title: Text(
          'Messages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.black45,
      ),

      body: Center(),
    );
  }
}
