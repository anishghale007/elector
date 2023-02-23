import 'package:elector/constants/constants.dart';
import 'package:elector/widgets/currentLeadership_card.dart';
import 'package:flutter/material.dart';

class LeadershipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Current Leadership',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'House of Representatives',
                style: kSubHeadingTextStyle,
              ),
              SizedBox(height: 40),
              CurrentLeadershipCard(
                image:
                    'https://st.depositphotos.com/1224365/2408/i/600/depositphotos_24084437-stock-photo-portrait-of-a-normal-boy.jpg',
                name: 'Anish Ghale',
                post: 'Speaker',
              ),
              CurrentLeadershipCard(
                image:
                    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                name: 'Anish Ghale',
                post: 'Deputy Speaker',
              ),
              CurrentLeadershipCard(
                image:
                    'https://thumbs.dreamstime.com/b/smart-person-eyewear-man-official-clothes-stands-against-white-background-studio-165962936.jpg',
                name: 'Rabi Lammichane',
                post: 'Leader of the House',
              ),
              CurrentLeadershipCard(
                image:
                    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                name: 'Anish Ghale',
                post: 'Leader of the Opposition',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
