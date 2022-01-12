import 'package:NewsApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({Key key}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: data[1],
              child: Image.network(
                data[1],
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                child: const Icon(Icons.arrow_back),
                backgroundColor: Colors.black12,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(data[0],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'assets/fonts/RobotoSlab-Regular.ttf')),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(data[2],
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                fontFamily:
                                    'assets/fonts/RobotoSlab-Regular.ttf')),
                        Spacer(),
                        Text(data[4],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                fontFamily:
                                    'assets/fonts/RobotoSlab-Regular.ttf')),
                      ],
                    ),
                    Text(data[3],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            fontFamily: 'assets/fonts/RobotoSlab-Regular.ttf')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
