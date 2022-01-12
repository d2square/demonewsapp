import 'package:NewsApp/screens/application/binding/home_page_binding.dart';
import 'package:NewsApp/screens/presentation/home_page.dart';
import 'package:NewsApp/screens/presentation/news_details_page.dart';
import 'package:get/get.dart';

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
