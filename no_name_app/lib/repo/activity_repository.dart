import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:no_name_app/models/activity_model.dart';
import 'package:no_name_app/models/user_model.dart';

class ActivityRepository {
  static TypeOfActivity convertStringToTypeOfActivity(String a) {
    if (a.contains('CommentOnExpense')) {
      return TypeOfActivity.CommentOnExpense;
    }
    if (a.contains('DeleteGroup')) {
      return TypeOfActivity.DeleteGroup;
    }
    if (a.contains('LeaveGroup')) {
      return TypeOfActivity.LeaveGroup;
    }
    if (a.contains('AddNewFriend')) {
      return TypeOfActivity.AddNewFriend;
    }
    if (a.contains('AddIntoGroup')) {
      return TypeOfActivity.AddIntoGroup;
    }
    if (a.contains('UpdateNote')) {
      return TypeOfActivity.UpdateNote;
    }

    return TypeOfActivity.CreateNewGroup;
  }

  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<String> generateIdOfActivity({
    required UserModel actor,
  }) async {
    return userCollection.doc(actor.id).collection('activities').doc().id;
  }

  static Future<void> addAnActivity(
      {required UserModel actor, required ActivityModel activityModel}) async {
    final activityCollection =
        userCollection.doc(actor.id).collection('activities');
    activityCollection.doc(activityModel.id).set(activityModel.toMap());
  }

  static Future<List<ActivityModel>> getActivities({
    required UserModel actor,
  }) async {
    final activityData = await userCollection
        .doc(actor.id)
        .collection('activities')
        .orderBy('time', descending: true)
        .get();
    List<ActivityModel> res = [];
    for (int i = 0; i < activityData.docs.length; i++) {
      final anActivityData = activityData.docs[i];
    // print(anActivityData.data()['zone'],);
      final activity = ActivityModel(
          id: anActivityData.data()['id'],
          actor: UserModel.fromMap(anActivityData.data()['actor']),
          timeCreate: anActivityData.data()['time'].toDate(),
          type: convertStringToTypeOfActivity(anActivityData.data()['type']),
          useCase: anActivityData.data()['case'],
          zone: anActivityData.data()['zone']);
          // print('---' + activity.toMap().toString());
      // final activity = ActivityModel.fromMap(anActivityData);
      res.add(activity);
    }

    return res;
  }
}
