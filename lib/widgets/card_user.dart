import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maimaid_app/blocs/user_bloc/user_bloc.dart';
import '../screen/update_user_screen.dart';
import '../utils/theme.dart';

class CardUser extends StatelessWidget {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  const CardUser({
    super.key,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  void _showDeleteConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: BlocProvider.of<UserBloc>(context),
          child: DeleteConfirmationSheet(userId: id),
        );
      },
    );
  }

  void _navigateToUpdateUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateUserScreen(userId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 105,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                avatar,
                height: 105,
                width: 105,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$firstName $lastName',
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          email,
                          style: orangeStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      if (value == 'delete') {
                        _showDeleteConfirmation(context);
                      } else if (value == 'update') {
                        _navigateToUpdateUser(context);
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem<String>(
                        value: 'select',
                        child: Text('Select'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'update',
                        child: Text('Update'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                    icon: const Icon(
                      Icons.more_horiz_outlined,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteConfirmationSheet extends StatelessWidget {
  final String userId;

  const DeleteConfirmationSheet({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure?',
            style: blackTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserDeleteSuccess) {
                Navigator.pushReplacementNamed(context, '/successDelete');
              } else if (state is UserDeleteFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              if (state is UserDeleting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(DeleteUser(userId));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange1Color,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
