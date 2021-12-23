import 'package:crud_getx/app/controller/TodoController.dart';
import 'package:crud_getx/app/provider/firestoredb.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Home extends GetView<TodoController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            GetX<TodoController>(
                init: Get.put<TodoController>(TodoController()),
                builder: (TodoController todoController) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: todoController.todos.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(todoController.todos[0].content);
                            print(todoController.todos[index].content);
                            final _todoModel = todoController.todos[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _todoModel.content,
                                        style: TextStyle(
                                          fontSize:
                                          Get.textTheme.headline6!.fontSize,
                                          decoration: _todoModel.isDone
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    Checkbox(
                                        value: _todoModel.isDone,
                                        onChanged: (status) {
                                          FirestoreDb.updateStatus(
                                            status!,
                                            _todoModel.documentId,
                                          );
                                        }),
                                    // IconButton(
                                    //     onPressed: () {
                                    //       FirestoreDb.deleteTodo(
                                    //           _todoModel.documentId!);
                                    //     },
                                    //     icon: const Icon(
                                    //       Icons.delete,
                                    //       color: Colors.redAccent,
                                    //     )),
                                  ],
                                ),
                              ),
                            );
                          }));
                }),
          ],
        ),
      ),
    );
  }
}
