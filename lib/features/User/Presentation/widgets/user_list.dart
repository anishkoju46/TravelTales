import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';

class UserList extends ConsumerWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);
    final userListController = ref.read(userListProvider.notifier);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final user = userList[index];
              return ListTile(
                onTap: () {
                  userListController.showUserForm(context, user: user);
                },
                title: Text(user.fullName),
                subtitle: Text(user.userDetail.email!),
                trailing: IconButton(
                    onPressed: () {
                      userListController.removeUser(index);
                    },
                    icon: Icon(Icons.delete)),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            onPressed: () {
              //userListController.storeUserList();
            },
            child: Icon(
              Icons.person_add,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
        )
      ],
    );
  }
}
