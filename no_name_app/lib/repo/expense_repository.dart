import 'package:cloud_firestore/cloud_firestore.dart';
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
        'name' : payersData[i]['user'].name,
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
        'name' : ownersData[i]['user'].name,
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
}
