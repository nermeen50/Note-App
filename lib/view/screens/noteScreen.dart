import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:note_app/constant.dart';
import 'package:note_app/models/noteModel.dart';
import 'package:note_app/viewModel/noteViewModel.dart';

class NoteScreen extends GetWidget {
  NoteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteViewModel>(
      builder: (controller) => Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          title: Text(
            ' Add New Note',
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: controller.globalKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (val) {
                    controller.titleValue = val;
                  },
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                ),
                TextFormField(
                  onSaved: (val) {
                    controller.contentValue = val;
                  },
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  maxLines: 5,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Content',
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.globalKey.currentState!.save();
            if (controller.globalKey.currentState!.validate()) {
              controller.addNote(
                NoteModel(
                  title: controller.titleValue,
                  content: controller.contentValue,
                ),
              );
              Fluttertoast.showToast(
                  msg: "Note successfully added",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity:
                      ToastGravity.BOTTOM // Also possible "TOP" and "CENTER"

                  );
              Get.back();
            }
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
