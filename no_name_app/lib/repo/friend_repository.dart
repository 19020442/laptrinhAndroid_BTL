import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:no_name_app/models/user_model.dart';

class FriendRepository {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addFriend(
      {required UserModel user, required UserModel newFriend}) async {
    userCollection
        .doc(user.id)
        .collection('friends')
        .doc(newFriend.id)
        .set(newFriend.toMap());
    userCollection
        .doc(newFriend.id)
        .collection('friends')
        .doc(user.id)
        .set(user.toMap());
  }

  static Future<List<UserModel>> getFriends({required String userId}) async {
    List<UserModel> res = [];
    final friendData =
        await userCollection.doc(userId).collection('friends').get();
    for (int i = 0; i < friendData.docs.length; i++) {
      print(friendData.docs[i]['email']);
      res.add(
        UserModel(
          email: friendData.docs[i]['email'],
          id: friendData.docs[i]['id'],
          name: friendData.docs[i]['name'],
          avatarImage: friendData.docs[i]['avatar'])
          );
          
    }
    return res;
  }

  static Future<bool> alreadyIsFriend(
      {required String userId, required String friendId}) async {
    final friendData =
        await userCollection.doc(userId).collection('friends').get();
    int index = friendData.docs.indexWhere((element) => element.id == friendId);

    if (index == -1) return true;
    return false;
  }
}
