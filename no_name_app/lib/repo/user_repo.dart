import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';

class UserRepository {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> setUser(UserModel userModel) async {
    await userCollection.doc(userModel.id).set(userModel.toMap()).onError(
        (error, stackTrace) =>
            throw FirebaseException(plugin: 'error add new user'));
  }

  static Future<UserModel?> getUserByEmail({required String email}) async {
    QuerySnapshot querySnapshot = await userCollection
        .where('email', isEqualTo: email)
        .get()
        .onError((error, stackTrace) =>
            throw FirebaseException(plugin: 'error get user by id'));
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          querySnapshot.docs[0].data() as Map<String, dynamic>;
      UserModel userModel = UserModel.fromMap(data);
      return userModel;
    }
  }

  static Future<List<String>?> getGroups({required String uid}) async {
    List<String> res = [];
    print('---- LOADING GROUPS OF USER ' + uid);
    final myIdGroups = await userCollection.doc(uid).collection('groups').get();
    if (myIdGroups.docs.isNotEmpty) {
      for (int i = 0; i < myIdGroups.docs.length; i++) {
        res.add(myIdGroups.docs[i].id.toString());
      }
      return res;
    }
  }

  static Future<void> updateUser(
      {required String uid, required Map<String, dynamic> arguments}) async {
    await userCollection.doc(uid).update(arguments);
  }

  static Future<void> onCreateGroup(
      {required String uid, required GroupModel groupModel}) async {
    await userCollection
        .doc(uid)
        .collection('groups')
        .doc(groupModel.id)
        .set(groupModel.toMap());
  }

  static Future<void> leaveGroup(
      {required String uid, required String gid}) async {
    await userCollection.doc(uid).collection('groups').doc(gid).delete();
    print('--- USER ' + uid + ' HAS LEFT GROUP ' + gid);
  }

  static Future<void> deleteGroup(
      {required String uid, required String gid}) async {
    await userCollection.doc(uid).collection('groups').doc(gid).delete();
    print('---- DELETED GROUP ' + gid + '');
  }

  static Future<String> getAvatarUserById({required String id}) async {
    final userData = await userCollection.doc(id).get();
    return userData.get('avatar');
  }
}
