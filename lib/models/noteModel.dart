import 'package:note_app/constant.dart';

class NoteModel {
  int? id;
  String? title, content;
  NoteModel({this.id, required this.title, required this.content});
  NoteModel.formJson(Map<dynamic, dynamic> json) {
    id = json[columID];
    title = json[columTitle];
    content = json[columcontent];
  }
  toJson() {
    return {
      columID: id,
      columTitle: title,
      columcontent: content,
    };
  }
}
