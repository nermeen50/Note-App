import 'package:get/get.dart';
import 'package:note_app/viewModel/noteViewModel.dart';

class BinddingHelper extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NoteViewModel());
  }
}
