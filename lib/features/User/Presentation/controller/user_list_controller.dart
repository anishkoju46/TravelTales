import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/widgets/edit_profile_screen.dart';
import 'package:traveltales/utility/list_controller.dart';

// class UserListController extends Notifier<List<UserModel>> {
//   final storage = GetStorage();

//   @override
//   List<UserModel> build() => loadUser();

//   final userKey = "userkey";

//   List<UserModel> loadUser() {
//     final users = storage.read(userKey);
//     if (users != null) {
//       return userModelFromJson(users);
//     }
//     return [];
//   }

//   storeUsers() {
//     storage.write(userKey, userModelToJson(state));
//   }

//   addUser(UserModel user) {
//     state = [...state..add(user)];
//     storeUsers();
//   }

//   updateUser(int index, {required UserModel user}) {
//     state = [...state..[index] = user];
//     storeUsers();
//   }

//   removeUser(int index) {
//     state = [...state..removeAt(index)];
//     storeUsers();
//   }

//   handleSubmit(UserModel user) {
//     final index = state.indexWhere((element) => element.id == user.id);
//     if (index == -1) {
//       addUser(user);
//     } else {
//       updateUser(index, user: user);
//     }
//   }

//   void showUserForm(BuildContext context, {UserModel? user}) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditProfileScreen(userModel: user!),
//       ),
//     );
//   }

//   // storeUserList() {
//   //   final userList = ref.read(loginNotifierProvider.notifier).userModel;
//   //   state = [...state..addAll(userList)];
//   //   storeUsers();
//   // }
// }

class UserListController extends ListController<UserModel> {
  @override
  String get key => "userkey";

  @override
  bool findById(UserModel element, UserModel current) =>
      element.id == current.id;

  @override
  Widget formWidget(UserModel? model) => EditProfileScreen(userModel: model);

  @override
  List<UserModel> fromStorage(String data) => userModelFromJson(data);

  @override
  String toStorage() => userModelToJson(state);
}
