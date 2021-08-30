import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:note_app/constant.dart';
import 'package:note_app/models/noteModel.dart';
import 'package:note_app/viewModel/noteViewModel.dart';

class DetailsNote extends StatelessWidget {
  const DetailsNote({Key? key, this.editeDetails}) : super(key: key);
  final editeDetails;
  @override
  Widget build(BuildContext context) {
    print(editeDetails.id.toInt());
    return GetBuilder<NoteViewModel>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                controller.deleteNote(editeDetails.id);
                Fluttertoast.showToast(
                    msg: "Note successfully deleted",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity:
                        ToastGravity.BOTTOM // Also possible "TOP" and "CENTER"

                    );
                Get.back();
              },
              icon: Icon(
                Icons.delete,
                color: blackColor,
              ),
            ),
          ],
          title: Text(
            'Edit Note',
            style: TextStyle(color: blackColor),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: blackColor,
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: whiteColor,
        ),
        body: Form(
          key: controller.globalKey,
          child: Column(
            children: [
              TextFormField(
                onSaved: (val) {
                  editeDetails.title = val;
                },
                style: TextStyle(
                  fontSize: 20,
                ),
                initialValue: editeDetails.title.toString(),
                maxLines: 5,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // hintText: editeDetails.title.toString(),
                ),
              ),
              TextFormField(
                onSaved: (val) {
                  editeDetails.content = val;
                },
                style: TextStyle(
                  fontSize: 20,
                ),
                initialValue: editeDetails.content.toString(),
                maxLines: 5,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // hintText: editeDetails.title.toString(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.globalKey.currentState!.save();
            if (controller.globalKey.currentState!.validate()) {
              controller.editNote(NoteModel(
                  id: editeDetails.id,
                  title: editeDetails!.title.toString(),
                  content: editeDetails!.content.toString()));
              Fluttertoast.showToast(
                  msg: "Note successfully edited",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity:
                      ToastGravity.BOTTOM // Also possible "TOP" and "CENTER"

                  );
              Get.back();
            }
          },
          child: Icon(
            Icons.edit,
          ),
        ),
      ),
    );
  }
}
