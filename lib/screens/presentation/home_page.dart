import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/routes/app_pages.dart';
import 'package:newsapp/screens/application/controller/home_page_controller.dart';
import 'package:newsapp/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
        title: const Text(
          "HEADLINE",
          style: TextStyle(
              fontSize: 29, fontFamily: 'assets/fonts/RobotoSlab-Bold.ttf'),
        ),
      ),
      body: GetBuilder<HomePageController>(builder: (controller) {
        return SafeArea(
          child: controller.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.noConnection == true
                  ? SizedBox(
                      height: double.infinity,
                      child: Image.asset(
                        'assets/images/no_internet.gif',
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.headLineList!.length,
                              itemBuilder: (context, index) {
                                return NewsCard(
                                  imageAssetUrl: controller
                                      .headLineList![index].urlToImage,
                                  categoryName:
                                      controller.headLineList![index].title,
                                  cnnValue: controller
                                      .headLineList![index].source!.name,
                                  date: convertDateTimeDisplay(controller
                                      .headLineList![index].publishedAt!),
                                  description: controller
                                      .headLineList![index].description,
                                );
                              }),
                        ],
                      ),
                    ),
        );
      }),
    );
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormat = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormat.parse(date);
    final String formatted = displayFormat.format(displayDate);
    return formatted;
  }
}

class NewsCard extends StatelessWidget {
  final String? imageAssetUrl, categoryName, cnnValue, date, description;

  NewsCard(
      {this.imageAssetUrl,
      this.categoryName,
      this.cnnValue,
      this.date,
      this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.newsSummary, arguments: [
          categoryName,
          imageAssetUrl,
          cnnValue,
          description,
          date
        ]);
      },
      child: Container(
        margin: const EdgeInsets.all(18.0),
        child: Stack(
          children: <Widget>[
            Hero(
              tag: imageAssetUrl!,
              child: Container(
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
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(categoryName!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  fontFamily:
                                      'assets/fonts/RobotoSlab-Regular.ttf')),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(cnnValue!,
                                  style: const TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      fontFamily:
                                          'assets/fonts/RobotoSlab-Regular.ttf')),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(date!,
                                  style: const TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      fontFamily:
                                          'assets/fonts/RobotoSlab-Regular.ttf')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
