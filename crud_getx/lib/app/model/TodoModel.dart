import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel{
  late String documentId;
  late String content;
  late Timestamp createdOn;
  late bool isDone;

  TodoModel({
    required this.content,
    required this.isDone,
});

  TodoModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    documentId=documentSnapshot.id;
    content=documentSnapshot["content"];
    createdOn=documentSnapshot["createdOn"];
    isDone=documentSnapshot["isDone"];
  }

}