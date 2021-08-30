import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_app/constant.dart';
import 'package:note_app/view/screens/detailsNote.dart';
import 'package:note_app/view/screens/noteScreen.dart';
import 'package:note_app/viewModel/noteViewModel.dart';

class HomeScreen extends GetWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteViewModel>(
      init: NoteViewModel(),
      builder: (controller) => Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            title: TextFormField(
              controller: controller.textVal,
              onChanged: (val) {
                controller.searchList(val);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: blackColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.list,
                  color: blackColor,
                ),
              ),
            ],
            backgroundColor: whiteColor,
          ),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: controller.getNotes(),
              builder: (ctr, snapshot) {
                if (controller.list != null) {
                  if (controller.textVal!.text.toString().isNotEmpty) {
                    print(controller.list[32].title.toString());
                    return Center(
                      child: Text('seee'),
                    );
                  }
                  return new StaggeredGridView.countBuilder(
                    padding: EdgeInsets.all(15.0),
                    crossAxisCount: 4,
                    itemCount: controller.list.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => DetailsNote(
                                editeDetails: controller.list[index],
                              ));
                        },
                        child: new Container(
                          color: cardColor,
                          padding: EdgeInsets.all(15.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.list[index].title.toString(),
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                controller.list[index].content.toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(2, index.isEven ? 3 : 2),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => NoteScreen());
            },
            child: Icon(
              Icons.add,
            ),
          )),
    );
  }
}
