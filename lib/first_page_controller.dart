import 'package:get/get.dart';

class FirstPageController extends GetxController {
  List<String> _homeData = ['我的', '别人的', '测试一下'];
  int selectedIndex = -1;

  void changeSelectedIndex(int index) {
    if (selectedIndex == index)
      selectedIndex = -1;
    else {
      selectedIndex = index;
    }
    update();
  }

  bool compareIndex(int index) {
    bool result = selectedIndex == index;
    update();
    return result;
  }

  List<String> getHomeData() {
    return _homeData;
  }
}
