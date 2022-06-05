import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  final controller = CarouselController();
  int activeIndex = 0;
  int selectedIndex = 0;
  num priceSelected = 0;
  index(index) {
    activeIndex = index;
    update();
  }

  price(price) {
    priceSelected = price;
    update();
  }

  indexSelected(index) {
    selectedIndex = index;
    update();
  }
}
