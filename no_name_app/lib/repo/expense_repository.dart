import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:no_name_app/models/comment_model.dart';
import 'package:no_name_app/models/expense_model.dart';
import 'package:no_name_app/models/user_model.dart';

class ExpenseRepository {
  static CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> setExpenseOnGroupCollection(
      {required String groupId, required ExpenseModel expenseModel}) async {
    await groupCollection
        .doc(groupId)
        .collection('expenses')
        .doc(expenseModel.id)
        .set(expenseModel.toMap());
  }

  static Future<void> setPayerAndOwnerOfExpense(
      {required String groupId,
      required expenseId,
      required List<dynamic> payersData,
      required List<dynamic> ownersData}) async {
    for (int i = 0; i < payersData.length; i++) {
      DocumentReference payerData = groupCollection
          .doc(groupId)
          .collection('expenses')
          .doc(expenseId)
          .collection('payers')
          .doc(payersData[i]['user'].id);
      // payerData.collection('owners').
      payerData.set({
        'name': payersData[i]['user'].name,
        'amount': payersData[i]['amount']
      });
      for (int j = 0; j < payersData[i]['owner'].length; j++) {
        payerData
            .collection('owners')
            .doc(payersData[i]['owner'][j]['user'].id)
            .set({
          'amount': payersData[i]['owner'][j]['amount'],
          'name': payersData[i]['owner'][j]['user'].name
        });
      }
    }
    for (int i = 0; i < payersData.length; i++) {
      DocumentReference ownerData = groupCollection
          .doc(groupId)
          .collection('expenses')
          .doc(expenseId)
          .collection('owners')
          .doc(ownersData[i]['user'].id);
      // payerData.collection('owners').
      ownerData.set({
        'name': ownersData[i]['user'].name,
        'amount': ownersData[i]['amount']
      });
      for (int j = 0; j < ownersData[i]['payer'].length; j++) {
        ownerData
            .collection('payers')
            .doc(ownersData[i]['payer'][j]['user'].id)
            .set({
          'amount': ownersData[i]['payer'][j]['amount'],
          'name': ownersData[i]['payer'][j]['user'].name
        });
      }
    }
  }

  static Future<String> getIdOfExpenseInGroup({required String groupId}) async {
    return groupCollection.doc(groupId).collection('expense').doc().id;
  }

  static Future<List<ExpenseModel>> getExpenses(
      {required String groupId}) async {
    List<ExpenseModel> res = [];
    await groupCollection
        .doc(groupId)
        .collection('expenses')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        final data = value.docs[i].data();
        final expense = ExpenseModel(
            id: data['Id'],
            name: data['Name'],
            dateCreate: data['Datetime'].toDate(),
            value: data['Value'],
            members: []);
        res.add(expense);
      }
    });
    return res;
  }

  static Future<void> setMemberExpense(
      {required String gid,
      required ExpenseModel expenseModel,
      required List<UserModel> members}) async {
    for (int i = 0; i < members.length; i++) {
      await groupCollection
          .doc(gid)
          .collection('expenses')
          .doc(expenseModel.id)
          .collection('members')
          .doc(members[i].id)
          .set({'Id': members[i].id, 'Name': members[i].name, 'Status': []});
    }
  }

  static Future<void> deleteExpense(
      {required String gid, required ExpenseModel expenseModel}) async {
    await groupCollection
        .doc(gid)
        .collection('expenses')
        .doc(expenseModel.id)
        .delete();
    print('---- EXPENSE ' + expenseModel.id + ' DELETED');
  }

  static Future<double> getYourStatusOnExpense(
      {required String groupId,
      required ExpenseModel currentExpense,
      required String userId}) async {
    final ownerData = await groupCollection
        .doc(groupId)
        .collection('expenses')
        .doc(currentExpense.id)
        .collection('owners')
        .get();
    final payerData = await groupCollection
        .doc(groupId)
        .collection('expenses')
        .doc(currentExpense.id)
        .collection('payers')
        .get();

    if (!ownerData.docs.any((element) => element.id != userId)) {
      final data = await groupCollection
          .doc(groupId)
          .collection('expenses')
          .doc(currentExpense.id)
          .collection('owners')
          .doc(userId)
          .get();
      return -data.data()!['amount'];
    }

    if (!payerData.docs.any((element) => element.id != userId)) {
      final data = await groupCollection
          .doc(groupId)
          .collection('expenses')
          .doc(currentExpense.id)
          .collection('payers')
          .doc(userId)
          .get();
      return data.data()!['amount'];
    }
    return 0;
  }

  static Future<String> generateIdComment({
    required String groupId,
    required ExpenseModel currentExpense,
  }) async {
    return groupCollection
        .doc(groupId)
        .collection('expenses')
        .doc(currentExpense.id)
        .collection('comments')
        .doc()
        .id;
  }

  static Future<void> addComment(
      {required String groupId,
      required ExpenseModel currentExpense,
      required CommentModel commentModel}) async {
    groupCollection
        .doc(groupId)
        .collection('expenses')
        .doc(currentExpense.id)
        .collection('comments')
        .doc(commentModel.id)
        .set(commentModel.toMap());
  }

  static Future<List<CommentModel>> getComments(
      {required String groupId, required ExpenseModel currentExpense}) async {
    final commentsData = await groupCollection
        .doc(groupId)
        .collection('expenses')
        .doc(currentExpense.id)
        .collection('comments')
        .orderBy('date')
        .get();
    List<CommentModel> res = [];
    for (int i = 0; i < commentsData.docs.length; i++) {
      final commentData = CommentModel(
          id: commentsData.docs[i].id,
          content: commentsData.docs[i].data()['content'],
          dateTime: commentsData.docs[i].data()['date'].toDate(),
          senderName: commentsData.docs[i].data()['sender']);
      res.add(commentData);
    }
    return res;
  }

  static Future<List<String>> getStatusOfExpense(
      {required String groupId, required ExpenseModel currentExpense}) async {
    List<String> status = [];

    final expenseCollection = groupCollection
        .doc(groupId)
        .collection('expenses')
        .doc(currentExpense.id);
    final payerData = await expenseCollection.collection('payers').get();
    final ownerData = await expenseCollection.collection('owners').get();
    for (int i = 0; i < payerData.docs.length; i++) {
      final aPayerData = payerData.docs[i];
      status.add(
          aPayerData['name'] + " đang dư " + aPayerData['amount'].toString());
      // print(aPayerData.data());
    }
    for (int i = 0; i < ownerData.docs.length; i++) {
      final aOwnerData = ownerData.docs[i];
      status.add(
          aOwnerData['name'] + " đang mượn " + aOwnerData['amount'].toString());
      // print(aPayerData.data());
    }
    return (status);
  }
}
