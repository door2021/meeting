import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';

class FirebaseService {
  Future<DocumentSnapshot> signUp(data, pass) async {
    var doc;

    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: data['email'].toString().trim(), password: pass.trim())
        .then((user) async {
      data.addAll({
        'uid': user.user!.uid,
      });

      await postDocumentWithId(user.user!.uid, "users", data);
      doc = await fetchLoginUser(user);
    });

    return doc;
  }

  Future<DocumentSnapshot> signIn(email, password) async {
    var doc;

    await firebaseAuth
        .signInWithEmailAndPassword(
            email: email.toString().trim(),
            password: password.toString().trim())
        .then((user) async {
      doc = await fetchLoginUser(user);
    });

    return doc;
  }

  Future<DocumentSnapshot> fetchLoginUser(user) async {
    return await fireStore.collection('users').doc(user.user.uid).get();
  }

  Future postDocumentWithId(uid, collection, data) async {
    var msg = {};

    await fireStore.collection(collection).doc(uid).set(data).then((value) {
      msg.addAll({'success': true});
    }).catchError((e) {
      msg.addAll({'success': false});
    });

    return msg;
    ;
  }

  Future postDocument(collection, data) async {
    var msg = {};
    await fireStore.collection(collection).doc().set(data).then((value) {
      msg.addAll({'success': true});
    }).catchError((e) {
      msg.addAll({'success': false});
    });

    return msg;
  }

  Future<DocumentSnapshot> fetchDocumentById(collection, uid) async {
    return await fireStore.collection(collection).doc(uid).get();
  }

  Future<DocumentSnapshot> fetchDocument(collection) async {
    return await fireStore.collection(collection).doc().get();
  }

  Future<QuerySnapshot> fetchDocuments(collection) async {
    if(collection == 'users'){
      return await fireStore.collection(collection).orderBy('rating', descending: true).get();
    }else{
      return await fireStore.collection(collection).get(); 
    }
  }

  Future updateDocument(collection, uid, data) async {
    var msg = {};

    await fireStore.collection(collection).doc(uid).update(data).then((value) {
      msg.addAll({'success': true});
    }).catchError((e) {
      print(e);
      msg.addAll({'success': false});
    });

    return msg;
  }

  Future updateDocumentById(collection, uid, data) async {
    var msg = {};

    await fireStore
        .collection(collection)
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) async {
      await fireStore
          .collection(collection)
          .doc(value.docs.first.id)
          .update(data)
          .then((value) {
        msg.addAll({'success': true});
      }).catchError((e) {
        msg.addAll({'success': false});
      });
    }).catchError((e) {
      msg.addAll({'success': false});
    });

    return msg;
  }

  Future<String> postStorage(dir, data) async {
    var msg;
    var ref = storage.ref().child("/${dir}/${data['id']}/${data['fileName']}");

    await ref.putFile(data['file']);
    msg = await ref.getDownloadURL();
    return msg;
  }

  Future signOut() async {
    var msg = {};
    await firebaseAuth.signOut().then((value) async {
      msg.addAll({'success': true});
    }).catchError((e) {
      msg.addAll({'success': false});
    });
    return msg;
  }
}
