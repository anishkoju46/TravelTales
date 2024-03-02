import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';

class UserList extends ConsumerWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListController = ref.read(userListProvider.notifier);
    final userList = ref.watch(userListProvider);

    final filteredUsers = userList.maybeWhen(
      data: (data) => data.where((e) => e.role == false).toList(),
      orElse: () => [],
    );

    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 15),
            color: Theme.of(context).colorScheme.primary,
            // width: double.infinity,
            child: Text(
              "User List",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            )),
        Expanded(
            child: userList.when(
                data: (data) => ListView.builder(
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
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondaryContainer),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(user
                                                    .imageUrl!.isEmpty
                                                ? "assets/images/default2.jpeg"
                                                : "${user.imageUrl}"),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(user.fullName!),
                                          Text("${user.email}"),
                                          // Text("${user.role}"),
                                          Text(user.role.toString())
                                        ],
                                      )),
                                      Text(DateFormat.yMMMd()
                                          .format(user.createdAt!)),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertBox(
                                                      confirmText: "Confirm",
                                                      onPressed: () {
                                                        userListController
                                                            .delete(
                                                                context, user);
                                                        //When user gets deleted, his review shall be refreshed for updated Review
                                                        // ref.refresh(
                                                        //     destinationListProvider);
                                                        Navigator.pop(context);
                                                      },
                                                      title: "Delete User");
                                                });
                                          },
                                          icon: Icon(Icons.delete))
                                    ],
                                  ),
                                ),
                        );
                      },
                    ),
                error: ((error, stackTrace) => Center(
                      child: Text(error.toString()),
                    )),
                loading: () => Center(
                      child: CircularProgressIndicator(),
                    ))),
      ],
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
