import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:no_name_app/models/user_model.dart';

class FriendRepository {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addFriend(
      {required String userId, required UserModel newFriend}) async {
    userCollection
        .doc(userId)
        .collection('friends')
        .doc(newFriend.id)
        .set(newFriend.toMap());
  }

  static Future<List<UserModel>> getFriends({required String userId}) async {
    List<UserModel> res = [];
    final friendData =
        await userCollection.doc(userId).collection('friends').get();
    for (int i = 0; i < friendData.docs.length; i++) {
      res.add(UserModel(
          email: friendData.docs[i]['email'],
          id: friendData.docs[i]['id'],
          name: friendData.docs[i]['name']));
    }
    return res;
  }
}
