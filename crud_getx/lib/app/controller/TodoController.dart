import 'dart:core';

import 'package:crud_getx/app/model/TodoModel.dart';
import 'package:crud_getx/app/provider/firestoredb.dart';
import 'package:get/get.dart';

class TodoController extends GetxController{
  Rx<List<TodoModel>> todoList= Rx<List<TodoModel>>([]);
  List<TodoModel> get todos=>todoList.value;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    todoList.bindStream(FirestoreDb.todoStream());
  }
}