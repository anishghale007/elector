import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'About Us',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Image.asset(
                  'assets/images/elector_dark.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                ' Sed vel fermentum sapien. Vestibulum tristique, ipsum vel'
                ' imperdiet laoreet, metus leo tincidunt sem, vitae fringilla'
                ' lectus massa egestas purus. Phasellus convallis metus '
                'ac elit vehicula rhoncus. Sed non erat quis ligula tempor'
                ' aliquet vel quis sapien. Orci varius natoque penatibus et magnis'
                ' dis parturient montes, nascetur ridiculus mus. Donec vel odio efficitur,'
                ' venenatis nunc eu, mattis dolor. Vivamus id ligula ac ipsum dignissim dapibus.'
                ' In erat risus, fringilla vehicula tellus ac, elementum pulvinar massa.'
                ' Cras ac arcu ultrices, convallis ipsum in, convallis orci.'
                ' Aenean ullamcorper nibh tincidunt diam eleifend fermentum. Maecenas vulputate'
                ' lorem eu elit luctus suscipit. Proin eu lorem nec diam tincidunt auctor. Nullam congue '
                'vehicula iaculis. Nulla nec purus eget libero sodales consequat ac in est.',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
