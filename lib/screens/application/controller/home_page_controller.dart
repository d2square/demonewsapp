import 'dart:convert';

import 'package:NewsApp/screens/domain/home_model.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final client = Dio();
  List<Articles> headLineList = [];
  bool loading = false;
  bool noConnection = false;

  String errorMsg = '';

  @override
  void onInit() {
    super.onInit();
    getHeadlines();
  }

  updateLoading(bool value) {
    loading = value;
    update();
  }

  /*fetch headlines api*/
  Future<void> getHeadlines() async {
    headLineList.clear();

    updateLoading(true);
    bool netConnection = await checkInternetConnectivity();
    print(netConnection);
    if (netConnection == false) {
      noConnection = true;
      updateLoading(false);
    } else {
      noConnection=false;
      try {
        final response = await client
            .get(base_url + "country=$country&apiKey=$api_keyForNews");
        if (response.statusCode == 200) {
          updateLoading(false);
          NewsHeadLineModel newsList =
              NewsHeadLineModel.fromJson(response.data);
          headLineList.addAll(newsList.articles);
          return headLineList;
        } else {
          updateLoading(false);
          errorMsg = response.data.toString();
          print('${response.statusCode} : ${response.data.toString()}');
          throw response.statusCode;
        }
      } catch (error) {
        updateLoading(false);
        errorMsg = error.toString();
        print(error);
      }
    }
    update();
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return false;
    }
  }
}
