import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/User/Presentation/widgets/user_detail_for_admin.dart';

class UserList extends ConsumerWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListController = ref.read(userListProvider.notifier);
    final userList = ref.watch(userListProvider);
    return Column(
      children: [
        Expanded(
            child: userList.when(
                data: (data) => ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final user = data[index];
                        return ListTile(
                          onTap: () {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   return UserDetailForAdmin();
                            // }));
                            userListController.showForm(context, model: user);
                          },
                          title: Text(user.fullName!),
                          subtitle: Text("${user.email}"),
                          // trailing:
                          //     Text(DateFormat.yMMMd().format(user.createdAt!))
                          trailing: IconButton(
                              onPressed: () {
                                userListController.delete(context, user);
                                //userListController.remove(context, index: index);
                              },
                              icon: Icon(Icons.delete)),
                        );
                      },
                    ),
                error: ((error, stackTrace) => Center(
                      child: Text(error.toString()),
                    )),
                loading: () => Center(
                      child: CircularProgressIndicator(),
                    ))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person_add,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          // child: FloatingActionButton(
          //   onPressed: () {
          //     userListController.storeUserList();
          //   },
          //   child: Icon(
          //     Icons.person_add,
          //     color: Theme.of(context).colorScheme.secondaryContainer,
          //   ),
          // ),
        )
      ],
    );
  }
}
