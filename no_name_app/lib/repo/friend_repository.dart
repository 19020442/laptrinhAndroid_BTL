import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/group_repository.dart';

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
      res.add(UserModel(
          email: friendData.docs[i]['email'],
          id: friendData.docs[i]['id'],
          name: friendData.docs[i]['name'],
          avatarImage: friendData.docs[i]['avatar']));
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

  static Future<void> updateStatus(
      {required String userId,
      required String friendId,
      String? gid,
      required bool isOnGroup,
      required dynamic data}) async {
    final rootPath = userCollection
        .doc(userId)
        .collection('friends')
        .doc(friendId)
        .collection('status');
    if (isOnGroup) {
      rootPath.doc(gid).set({'amount': data['amount']});
    } else {
      rootPath.doc(friendId).set({'amount': data['amount']});
    }
  }

  static Future<dynamic> getYourStatusOnFriend(
      {required String userId, required String friendId}) async {
    Map<String, dynamic> res = {'details': [], 'total': 0.0};
    final rootPath = userCollection
        .doc(userId)
        .collection('friends')
        .doc(friendId)
        .collection('status');
    final data = await rootPath.get();
    for (int i = 0; i < data.docs.length; i++) {
      final groupData =
          await GroupRepository.getGroupbyId(idGroup: data.docs[i].id);

      final aData = {
        'zone': groupData.toMap(),
        'amount': data.docs[i].data()['amount']
      };
      res['details'].add(aData);
      res['total'] += aData['amount'];
    }
    return res;
  }
}
