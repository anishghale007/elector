import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'FAQ',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.asset(
                  'assets/images/FAQ.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(vertical: 10),
            backgroundColor: Colors.grey[100],
            title: Text(
              'How to properly vote in elector',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              ListTile(
                title: Text(
                    'At the beginning of the voting process, you are shown a set of instructions. Please follow the'
                    'instructions and vote wisely. You will need to enter your PIN and verify your vote with your fingerprint.'
                    'If you have forgotten your PIN then contact the Election Commission office.'),
              ),
            ],
          ),
          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(vertical: 10),
            title: Text(
              'Can we vote more than once?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.grey[100],
            children: [
              ListTile(
                title: Text(
                    'NO. The application strictly follows the rule of one vote per person. It also restricts the '
                    'user from voting more than once.'),
              ),
            ],
          ),
          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(vertical: 10),
            title: Text(
              'How do I contact support',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.grey[100],
            children: [
              ListTile(
                title: Text(
                    'You can contact the Election Commission office for support. The hotline number is 1234566789'),
              ),
            ],
          ),
          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(vertical: 10),
            title: Text(
              'How do I check to see the vote list?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.grey[100],
            children: [
              ListTile(
                title: Text(
                    'You can contact the Election Commission office for support. The hotline number is 1234566789'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
