import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/emergency_numbers/presentation/state/emergency_state.dart';
import 'package:traveltales/features/emergency_numbers/presentation/widget/emergency_list_item.dart';
import 'package:traveltales/utility/theme_controller.dart';

class EmergencyContactsScreen extends ConsumerWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authNotifierProvider);
    final isAdmin = currentUser?.role == true;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Emergency Contacts",
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.background),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.refresh(hotlineListProvider);
          },
          child: Consumer(
            builder: (context, ref, child) {
              final hotlineList = ref.watch(hotlineListProvider);
              return hotlineList.when(
                data: (data) => data.isEmpty
                    ? const Center(child: Text("No Hotlines Found"))
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final hotlineNumbers = data[index];

                          return HotlineNumberItem(
                              hotlineNumber: hotlineNumbers);
                        },
                      ),
                error: (error, stackTrace) {
                  return Center(
                    child: Text(error.toString()),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        floatingActionButton: Visibility(
          visible: isAdmin,
          child: FloatingActionButton(
            onPressed: () =>
                ref.read(hotlineListProvider.notifier).showForm(context),
            child:
                Icon(Icons.add_call, color: context.theme.colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
