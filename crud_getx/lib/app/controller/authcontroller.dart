import 'package:crud_getx/app/constants/constants.dart';
import 'package:crud_getx/app/constants/todo_list.dart';
import 'package:crud_getx/app/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';

class AuthController extends GetxController{
  static AuthController instance=Get.find();
  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSinInAccount;

dynamic user1;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    firebaseUser=Rx<User?>(auth.currentUser);
    googleSinInAccount=Rx<GoogleSignInAccount?>(googleSign.currentUser);
    
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    
    googleSinInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSinInAccount,_setInitialScreenGoogle);

  }

  _setInitialScreen(User? user){
    if(user==null){
      Get.offAll(()=>const Register());
    }
    else{
      print('user'); print(user);
user1=user;
      Get.offAll(()=>const TodoList());
      // Get.offAll(()=>const MyHomePage(title: "home"));
    }
  }

  _setInitialScreenGoogle (GoogleSignInAccount? googleSignInAccount){
    print(
      googleSignInAccount,
    );
    if(googleSinInAccount==null){
      Get.offAll(()=>const Register());
    }
    else{
      Get.offAll(()=>const TodoList());
      // Get.offAll(()=>const MyHomePage(title: "home"));

    }
  }

  void signInWithGoogle() async{
    try{
      GoogleSignInAccount? googleSignInAccount=await googleSign.signIn();

      if(googleSinInAccount!=null){
       GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount!.authentication;

        AuthCredential credential=GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
        .signInWithCredential(credential)
        .catchError((onError)=>print(onError));
      }
    }
    catch(e){
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  void register(String email,password) async{
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }
    catch(firebaseAuthException){}

  }

  void login(String email,password) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(firebaseAuthException){
      print(firebaseAuthException);
    }

}

void signOut() async{
    await auth.signOut();
}

}