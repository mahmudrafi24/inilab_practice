import 'package:get/get.dart';
import 'package:inilab_practice/services/models/repository.dart';

class RepositoryDetailsController extends GetxController {
  final Rx<Repository?> _repository = Rx<Repository?>(null);

  Repository? get repository => _repository.value;

  @override
  void onInit() {
    super.onInit();
    // Get repository data passed from previous screen
    if (Get.arguments != null && Get.arguments is Repository) {
      _repository.value = Get.arguments as Repository;
    }
  }

  void setRepository(Repository repo) {
    _repository.value = repo;
  }
}
