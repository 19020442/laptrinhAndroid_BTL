import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<void> updateUser(
      {required String uid, required Map<String, dynamic> arguments}) async {
    await userCollection.doc(uid).update(arguments);
  }
}
