import 'package:get/get.dart';
// import 'package:no_name_app/screens/add_expense_screen.dart';
import 'package:no_name_app/screens/friend/add_friend_screen.dart';
import 'package:no_name_app/screens/friend/friend_detail_screen.dart';
// import 'package:no_name_app/screens/add_member_screen.dart';
// import 'package:no_name_app/screens/choose_who_paid_screen.dart';
import 'package:no_name_app/screens/group/add_expense_screen.dart';
import 'package:no_name_app/screens/group/add_member_screen.dart';
import 'package:no_name_app/screens/group/choose_who_paid_screen.dart';
import 'package:no_name_app/screens/group/create_new_group_screen.dart';
import 'package:no_name_app/screens/group/expense/expense_detail_screen.dart';
// import 'package:no_name_app/screens/friend_detail_screen.dart';
import 'package:no_name_app/screens/group/group_setting_screen.dart';
import 'package:no_name_app/screens/group/option_split_screen.dart';
import 'package:no_name_app/screens/group/record_payment_screen.dart';
import 'package:no_name_app/screens/group/select_category_screen.dart';
import 'package:no_name_app/screens/group/selt_up_screen.dart';
import 'package:no_name_app/screens/authentication/login_screen.dart';
import 'package:no_name_app/screens/home_screen.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/screens/group/my_group_screen.dart';
// import 'package:no_name_app/screens/option_split_screen.dart';
import 'package:no_name_app/screens/account/passcode_screen.dart';
// import 'package:no_name_app/screens/record_payment_screen.dart';
import 'package:no_name_app/screens/register_screen.dart';
// import 'package:no_name_app/screens/select_category_screen.dart';

class Pages {
  static final pages = [
    GetPage(name: Routes.LOGIN_SCREEN, page: () => const AuthScreen()),
    GetPage(name: Routes.HOME_SCREEN, page: () => const HomeScreen()),
    GetPage(
        name: Routes.CREATE_NEW_GROUP,
        page: () => const CreateNewGroupScreen()),
    GetPage(name: Routes.MY_GROUP_SCREEN, page: () => const MyGroupScreen()),
    GetPage(
        name: Routes.ADD_EXPENSE_SCREEN, page: () => const AddExpenseScreen()),
    GetPage(
        name: Routes.ADD_FRIEND_SCREEN, page: () => const AddFriendScreen()),
    GetPage(
        name: Routes.ADD_MEMBER_OF_GROUPS, page: () => const AddMemberScreen()),
    GetPage(
        name: Routes.CHOOSE_WHO_PAID, page: () => const ChooseWhoPaidScreen()),
    GetPage(
        name: Routes.CHOOSE_OPTION_SPLIT,
        page: () => const SplitOptionScreen()),
    GetPage(name: Routes.GROUP_SETTING, page: () => const GroupSettingScreen()),
    GetPage(name: Routes.SETTLE_UP_SCREEN, page: () => const SettleUpScreen()),
    GetPage(
        name: Routes.RECORD_PAYMENT_SCREEN,
        page: () => const RecordPaymentScreen()),
    GetPage(name: Routes.PASSCODE_SCREEN, page: () => const PassCodeScreen()),
    GetPage(
        name: Routes.EXPENSE_SCREEN, page: () => const ExpenseDetailScreen()),
    GetPage(
        name: Routes.FRIEND_DETAIL_SCREEN,
        page: () => const FriendDetailScreen()),
    GetPage(
        name: Routes.CHOOSE_CATEGORY_SCREEN,
        page: () => const SelectCategoryScreen())
  ];
}
