
import 'package:get/get.dart';
import 'package:newsapp/screens/application/binding/home_page_binding.dart';
import 'package:newsapp/screens/presentation/home_page.dart';
import 'package:newsapp/screens/presentation/news_details_page.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.defaultRoute;

  static final routes = [
    GetPage(
        name: Routes.defaultRoute,
        binding: HomePageBinding(),
        page: () => const HomePage()),
    GetPage(name: Routes.newsSummary, page: () => const NewsDetails()),
  ];
}
