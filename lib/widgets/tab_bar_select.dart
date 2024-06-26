import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maimaid_app/utils/theme.dart';

import '../blocs/user_bloc/user_bloc.dart';
import '../services/api_service.dart';
import 'card_user.dart';

class TabBarSelect extends StatefulWidget {
  const TabBarSelect({super.key});

  @override
  State<TabBarSelect> createState() => _TabBarSelectState();
}

class _TabBarSelectState extends State<TabBarSelect> {
  late UserBloc userBloc;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc(apiService);
    userBloc.add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            indicatorColor: orange1Color,
            tabs: [
              Tab(
                child: Text(
                  'Non Selected',
                  style: orangeStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Selected',
                  style: orangeStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                BlocProvider(
                  create: (context) => userBloc,
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 2,
                              ),
                              child: Text(
                                'Total ${state.users.length} items',
                                style: greyTextStyle.copyWith(
                                  fontWeight: bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.users.length,
                                itemBuilder: (context, index) {
                                  final user = state.users[index];
                                  return CardUser(
                                    id: user.id.toString(),
                                    firstName: user.firstName,
                                    lastName: user.lastName,
                                    email: user.email,
                                    avatar: user.avatar,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else if (state is UserError) {
                        return Center(child: Text(state.message));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                const Center(
                  child: Text(
                    'Empty',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
