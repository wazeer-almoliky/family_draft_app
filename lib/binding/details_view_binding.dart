import 'package:get/get.dart';
import 'package:family/controller/details_view_controller.dart';
class DetailsViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsViewController());
  }
  
}