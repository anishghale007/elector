import 'package:flutter/material.dart';

class ProvincialCard extends StatelessWidget {
  String image;
  String provinceName;
  VoidCallback onPress;

  ProvincialCard({
    required this.image,
    required this.provinceName,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.17,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Text(
                  provinceName,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 30,
                color: Colors.grey,
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
