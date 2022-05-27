import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/user_repo.dart';

class GroupRepository {
  static CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  static Future<String> getIdGroup() async {
    return groupCollection.doc().id;
  }

  static Future<GroupModel> getGroupbyId({required String idGroup}) async {
    final groupData = await groupCollection.doc(idGroup).get();
    return GroupModel(
        id: groupData['Id'],
        imageGroup: groupData['Image'],
        nameGroup: groupData['Name'],
        typeGroup: groupData['Type'],
        members: []);
  }

  static Future<void> setGroup(GroupModel groupModel) async {
    await groupCollection.doc(groupModel.id).set(groupModel.toMap()).onError(
        (error, stackTrace) =>
            throw FirebaseException(plugin: 'error add new group'));
  }

  static Future<void> updateGroup(
      {required String gid, required Map<String, dynamic> arguments}) async {
    await groupCollection.doc(gid).update(arguments);
  }

  static Future<List<UserModel>> getMemebers({required String groupId}) async {
    List<UserModel> res = [];
    await groupCollection
        .doc(groupId)
        .collection('members')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        final data = value.docs[i].data();
        final member =
            UserModel(id: data['id'], name: data['name'], email: data['email']);
        res.add(member);
      }
    });
    return res;
  }

  static Future<void> addMember(
      {required GroupModel group,
      required List<UserModel> listMemberAdd}) async {
    for (int i = 0; i < listMemberAdd.length; i++) {
      await groupCollection
          .doc(group.id)
          .collection('members')
          .doc(listMemberAdd[i].id)
          .set(listMemberAdd[i].toMap())
          .whenComplete(() {
        UserRepository.onCreateGroup(
            uid: listMemberAdd[i].id!, groupModel: group);
      });
    }
  }

  static Future<void> leaveGroup(
      {required String uid, required String gid}) async {
    await groupCollection.doc(gid).collection('members').doc(uid).delete();
    await UserRepository.userCollection
        .doc(uid)
        .collection('groups')
        .doc(gid)
        .delete();
    print('--- USER ' + uid + ' HAS LEFT GROUP ' + gid);
  }

  static Future<void> removeGroup({required String gid}) async {
    await groupCollection.doc(gid).delete();
    print('---- DELETED GROUP ' + gid + '');
  }

  static Future<void> setStatusGroup(
      {required String groupId,
      required List<dynamic> data,
      required bool isPayer}) async {
    for (int i = 0; i < data.length; i++) {
      final path = groupCollection
          .doc(groupId)
          .collection('state')
          .doc(data[i]['user'].id);
      path.get().then((value) {
        if (value.data() != null) {
          if (isPayer) {
            path.update(
                {'amount': data[i]['amount'] + value.data()!['amount']});
          } else {
            path.update(
                {'amount': value.data()!['amount'] - data[i]['amount']});
          }
        } else {
          if (isPayer) {
            path.set(
                {'name': data[i]['user'].name, 'amount': data[i]['amount']});
          } else {
            path.set(
                {'name': data[i]['user'].name, 'amount': -data[i]['amount']});
          }
        }
      });

      final collect = isPayer ? "owner" : "payer";
      for (int j = 0; j < data[i][collect].length; j++) {
        final path1 =
            path.collection(collect).doc(data[i][collect][j]['user'].id);
        path1.get().then((value) {
          if (value.data() == null) {
            if (isPayer) {
              path1.set({
                'name': data[i][collect][j]['user'].name,
                'amount': data[i][collect][j]['amount']
              });
            } else {
              path1.set({
                'name': data[i][collect][j]['user'].name,
                'amount': -data[i][collect][j]['amount']
              });
            }
          } else {
            if (isPayer) {
              path1.update(
                  {'amount': data[i]['amount'] + value.data()!['amount']});
            } else {
              path1.update(
                  {'amount': value.data()!['amount'] - data[i]['amount']});
            }
          }
        });
      }
    }
  }

  static Future<List<Map<String, dynamic>>> getStatusGroupByUserId(
      {required String groupId, required String userId}) async {
    final path = groupCollection.doc(groupId).collection('state').doc(userId);
    List<Map<String, dynamic>> status = [];
    if (path.collection('owner') != null) {
      final ownerData = await path.collection('owner').get();

      for (int i = 0; i < ownerData.docs.length; i++) {
        status.add({
          'id': ownerData.docs[i].id,
          'name': ownerData.docs[i]['name'],
          'amount': ownerData.docs[i]['amount']
        });
      }
    }
    if (path.collection('payer') != null) {
      final payerData = await path.collection('payer').get();
      for (int i = 0; i < payerData.docs.length; i++) {
        status.add({
          'id': payerData.docs[i].id,
          'name': payerData.docs[i]['name'],
          'amount': payerData.docs[i]['amount']
        });
      }
    }

    List<Map<String, dynamic>> statusFinal = [];
    for (int i = 0; i < status.length; i++) {
      for (int j = i + 1; j < status.length; j++) {
        if (status[i]['id'] == status[j]['id']) {
          status[i]['amount'] += status[j]['amount'];
          status.removeAt(j);
          j--;
        }
      }
      statusFinal.add(status[i]);
    }

    return statusFinal;
  }
}
