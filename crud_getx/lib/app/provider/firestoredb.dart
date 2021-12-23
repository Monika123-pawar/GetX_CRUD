import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_getx/app/constants/constants.dart';
import 'package:crud_getx/app/model/TodoModel.dart';

class FirestoreDb{
  static addTodo(TodoModel todoModel) async{
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todo')
        .add({
      'content':todoModel.content,
      'createdon':Timestamp.now(),
      'isDone':false,
    });
  }

  static Stream<List<TodoModel>> todoStream(){
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .snapshots()
        .map((QuerySnapshot query) {
          List<TodoModel> todos=[];
          for(var todo in query.docs){
            final todoModel=TodoModel.fromDocumentSnapshot(documentSnapshot: todo);
            todos.add(todoModel);
          }
          return todos;
    });
  }

  static updateStatus(bool isDone,documentId){
    firebaseFirestore
    .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(documentId)
        .update({
      "isDone":isDone,
    });
  }

  static deleteTodo(String documentId){
    firebaseFirestore
    .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(documentId)
        .delete();
  }
}