import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:newsapp/screens/domain/home_model.dart';
import 'package:newsapp/utils/constants.dart';

class HomePageController extends GetxController {
  final client = Dio();
  List<Articles>? headLineList = [];
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
  getHeadlines() async {
    headLineList!.clear();

    updateLoading(true);
    bool netConnection = await checkInternetConnectivity();

    if (netConnection == false) {
      noConnection = true;
      updateLoading(false);
    } else {
      noConnection = false;
      try {
        final response = await client
            .get(base_url + "country=$country&apiKey=$api_keyForNews");
        if (response.statusCode == 200) {
          updateLoading(false);
          NewsHeadLineModel newsList =
              NewsHeadLineModel.fromJson(response.data);
          headLineList!.addAll(newsList.articles!);
        } else {
          updateLoading(false);
          errorMsg = response.data.toString();
          throw response.statusCode!;
        }
      } catch (error) {
        updateLoading(false);
        errorMsg = error.toString();
      }
    }
    update();
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
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
