import 'package:flutter/material.dart';
import 'package:trackhub/widget/maincolor.dart';

class Cardbox extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  tileColor: Maincolor.PrimaryColor,
                  title: Text('5 Mei 2022 09:45',style: TextStyle(color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),

                Container(margin: EdgeInsets.only(bottom: 5),height: 1.4,color: Maincolor.PrimaryColor),
                Text('LIN 4',style: TextStyle(color: Maincolor.PrimaryColor)),
                Text('Azzam Karim++++++',style: TextStyle(color: Maincolor.PrimaryColor)),

                SizedBox(height: 10)

              ],
            ));
  }
}