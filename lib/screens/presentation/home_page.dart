import 'package:NewsApp/screens/application/controller/home_page_controller.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "HEADLINE",
          style: TextStyle(
              fontSize: 29, fontFamily: 'assets/fonts/RobotoSlab-Bold.ttf'),
        ),
      ),
      body: GetBuilder<HomePageController>(builder: (controller) {
        return SafeArea(
          child: controller.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : controller.noConnection == true
                  ? Container(
                      height: double.infinity,
                      child: Image.asset(
                        'assets/images/no_internet.gif',
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          /// Categories
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.headLineList.length,
                              itemBuilder: (context, index) {
                                return NewsCard(
                                  imageAssetUrl:
                                      controller.headLineList[index].urlToImage,
                                  categoryName:
                                      controller.headLineList[index].title,
                                );
                              }),
                        ],
                      ),
                    ),
        );
      }),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  NewsCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(18.0),
        child: Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.3,
                // ignore this, cos I am giving height to the container
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageAssetUrl ??
                            "https://1080motion.com/wp-content/uploads/2018/06/NoImageFound.jpg.png"))),
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(categoryName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily:
                                'assets/fonts/RobotoSlab-Regular.ttf'))))
          ],
        ),
      ),
    );
  }
}
