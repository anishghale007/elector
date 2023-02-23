import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {

  final IconData icon;
  final String title;
  final dynamic onPress;

  ProfileListTile({
    required this.icon,
    required this.title,
    required this.onPress,
});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: title == 'Log Out' ? kMainThemeColor : Color(0xFFADADAD),
          width: title == 'Log Out' ? 1.7 : 0.8,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: title == 'Log Out' ? kMainThemeColor : Colors.black,
          size: 25,
        ),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 17,
              color: title == 'Log Out' ? kMainThemeColor : Colors.black,
              fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_sharp,
          color: title == 'Log Out' ? kMainThemeColor : Color(0xFFADADAD),
          size: 25,
        ),
        tileColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 12, left: 20, right: 20),
        onTap: onPress,
      ),
    );
  }
}
