
import 'package:get/get.dart';
import 'package:newsapp/screens/application/controller/home_page_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}
