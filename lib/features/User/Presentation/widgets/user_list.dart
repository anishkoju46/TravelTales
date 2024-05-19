import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:traveltales/features/User/Data/user_repository.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/controller/user_list_controller.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/dashboard/state/user_home_state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';
import 'package:traveltales/utility/custom_network_image.dart';
import 'package:traveltales/utility/theme_controller.dart';

class UserList extends ConsumerWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListController = ref.read(userListProvider.notifier);
    final userList = ref.watch(userListProvider);

    final List<UserModel> filteredUsers = userList.maybeWhen(
      data: (data) => data.where((e) => e.role == false).toList(),
      orElse: () => [],
    );

    return RefreshIndicator(
      onRefresh: () async {
        return ref.read(userHomeProvider.notifier).refresh();
      },
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 15),
              color: Theme.of(context).colorScheme.primary,
              child: Text("User List",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary))),
          Expanded(
            child: userList.when(
              data: (data) {
                return ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = filteredUsers[index];
                    return InkWell(
                      onTap: () {
                        userListController.showForm(context, model: user);
                      },
                      child: data.isEmpty
                          ? Center(
                              child: Text("No User Available"),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: user.block!
                                              ? context.theme.colorScheme.error
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .tertiaryContainer),
                                      shape: BoxShape.circle,
                                      // image: DecorationImage(
                                      //   fit: BoxFit.cover,
                                      //   image: AssetImage(user
                                      //           .imageUrl!.isEmpty
                                      //       ? "assets/images/default2.jpeg"
                                      //       : "${user.imageUrl}"),
                                      // ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Consumer(
                                          builder: (context, ref, child) {
                                        final baseUrl =
                                            UserRepository().baseUrl;
                                        return CustomNetworkImage(
                                            allowFullScreen: false,
                                            url:
                                                "$baseUrl${user.imageUrl?.replaceAll('\\', '/')}");
                                      }),
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(user.fullName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: user.block!
                                                          ? context.theme
                                                              .colorScheme.error
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .tertiaryContainer)),
                                          //if (user.block)
                                          // Icon(Icons.block)
                                        ],
                                      ),
                                      Text("${user.email}"),
                                      // Text("${user.role}"),
                                      // Text(user.role.toString())
                                      Text(
                                        DateFormat.yMMMd()
                                            .format(user.createdAt!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  )),
                                  IconButton(
                                      onPressed: () {
                                        customShowDialog(
                                            context, userListController, user,
                                            button1: user.block!
                                                ? "Unblock"
                                                : "Block",
                                            confirmText: user.block!
                                                ? "Unblock"
                                                : "Block",
                                            title: user.block!
                                                ? "Unblock User?"
                                                : "Block User?");
                                      },
                                      icon: user.block!
                                          ? Icon(
                                              Icons.person_off,
                                              color: context
                                                  .theme.colorScheme.error,
                                            )
                                          : Icon(Icons.manage_accounts))
                                ],
                              ),
                            ),
                    );
                  },
                );
              },
              error: ((error, stackTrace) => Center(
                    child: Text(error.toString()),
                  )),
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> customShowDialog(BuildContext context,
      UserListController userListController, UserModel user,
      {required String button1,
      required String confirmText,
      required String title}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Container(
            alignment: Alignment.center,
            child: Text(
              "Manage User",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          actions: [
            Consumer(builder: (context, ref, child) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertBox(
                                confirmText: confirmText,
                                onPressed: () {
                                  userListController.blockUser(context, user,
                                      isBlock: user.block!);
                                  ref.refresh(userListProvider);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                title: title);
                          },
                        );
                        // Navigator.of(context).pop();
                        // userListController.blockUser(context, user,
                        //     isBlock: user.block!);
                        // ref.refresh(userListProvider);
                        // Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text(button1),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertBox(
                                confirmText: "Delete",
                                onPressed: () {
                                  userListController.delete(context, user);
                                  Navigator.of(context).pop();
                                },
                                title: "Delete Permanently?");
                          },
                        );
                      },
                      child: Text("Delete"),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

// Container(
//   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//   alignment: Alignment.centerRight,
//   child: IconButton(
//     onPressed: () {},
//     icon: Icon(
//       Icons.person_add,
//       color: Theme.of(context).colorScheme.secondaryContainer,
//     ),
//   ),
//   // child: FloatingActionButton(
//   //   onPressed: () {
//   //     userListController.storeUserList();
//   //   },
//   //   child: Icon(
//   //     Icons.person_add,
//   //     color: Theme.of(context).colorScheme.secondaryContainer,
//   //   ),
//   // ),
// )
