import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_app/helper/databaseHelper.dart';
import 'package:note_app/models/noteModel.dart';

class NoteViewModel extends GetxController {
  String? titleValue, contentValue;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  GlobalKey<FormState> get globalKey => _globalKey;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  List<NoteModel> _list = [];
  List<NoteModel> get list => _list;
  List<NoteModel> _searchResult = [];
  List<NoteModel> get searchResult => _searchResult;
  TextEditingController? textVal = TextEditingController();
  NoteModel? noteModel;
  addNote(noteModel) async {
    await DatabaseHelper.databaseHelper.insert(noteModel);

    update();
  }

  Future<List<NoteModel>> getNotes() async {
    _loading.value = true;
    var db = DatabaseHelper.databaseHelper;
    _list = (await db.readAllNotes())!;
    _loading.value = false;
    update();
    return _list;
  }

  editNote(noteModel) async {
    var db = DatabaseHelper.databaseHelper;
    await db.updateUser(noteModel);
    update();
  }

  deleteNote(int index) async {
    var db = DatabaseHelper.databaseHelper;
    await db.deleteUser(index);

    update();
  }

  searchList(String text) {
    _list.forEach((element) {
      if (element.title!.contains(text) || element.content!.contains(text)) {
        _searchResult.add(element);
      }
      update();
    });
  }

  NoteViewModel() {
    getNotes();
  }
}
