
import 'package:crud_getx/app/model/TodoModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/constants/constants.dart';
import 'app/controller/authcontroller.dart';
import 'app/provider/firestoredb.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseApp.initializeApp();

  runApp(const MyApp());


}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseInitialization.then((value){
      Get.put(AuthController());
    });
    // FirebaseAuth.instance;
    auth=FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Center(child: const CircularProgressIndicator()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController contentTextEditorController=TextEditingController();

  @override
  Widget build(BuildContext context) {
print(contentTextEditorController.text);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
         children: [
           TextField(
             controller: contentTextEditorController,
           ),
           const SizedBox(
             height: 30,
           ),
           ElevatedButton(
               onPressed: () async {
                 final todoModel=TodoModel(
                     content: contentTextEditorController.text.trim(),
                     isDone: false,
                 );
                 await FirestoreDb.addTodo(todoModel);
                 contentTextEditorController.clear();
               },
               child:  const Text("Add Todo"),
           )
         ],
        ),
      ),

    );
  }
}
