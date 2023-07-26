import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void createUser(emailController, passwordController) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController,
      password: passwordController,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

void storeData(emailController, passwordController, nameController) async {
  final userid = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance.collection("Users").doc(userid).set(
    {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "name": nameController.text.trim(),
    },
  );
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<void> copyDocuments(String userid, String ordernumber) async {
  final sourceSnapshot =
      await firestore.collection("Users").doc(userid).collection("Cart").get();

  for (final document in sourceSnapshot.docs) {
    await firestore
        .collection("Users")
        .doc(userid)
        .collection("Orders")
        .doc(ordernumber)
        .collection(ordernumber)
        .add(
          document.data(),
        );
  }
}

Future<void> copyDocumentstoAdmin(String userid, String ordernumber) async {
  final sourceSnapshot =
      await firestore.collection("Users").doc(userid).collection("Cart").get();

  for (final document in sourceSnapshot.docs) {
    await firestore
        .collection("Admin")
        .doc("sales")
        .collection("Orders")
        .doc(ordernumber)
        .collection(ordernumber)
        .add(
          document.data(),
        );
  }
}
