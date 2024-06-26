import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maimaid_app/blocs/user_bloc/user_bloc.dart';
import 'package:maimaid_app/utils/theme.dart';
import 'package:maimaid_app/widgets/success_update.dart';

class UpdateUserScreen extends StatefulWidget {
  final String userId;

  const UpdateUserScreen({super.key, required this.userId});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _jobs = ['Front End', 'Back End', 'Data Analyst'];
  String? _selectedJob;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUserDetail(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserUpdateSuccess) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SuccessUpdate(),
                    ),
                  );
                } else if (state is UserUpdateFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is UserDetailLoaded) {
                  final user = state.user;
                  _nameController.text = user.firstName;
                  _emailController.text = user.email;
                  _selectedJob = _jobs.first;
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xffECF0F4),
                                  child: Icon(
                                    Icons.close,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Update User',
                                style: blackTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'NAME',
                          style: grey2TextStyle.copyWith(
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: grey3Color,
                              ),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: 'Name',
                            fillColor: grey3Color,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Text('Job',
                            style:
                                grey2TextStyle.copyWith(fontWeight: semiBold)),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedJob,
                          items: _jobs.map((String job) {
                            return DropdownMenuItem<String>(
                              value: job,
                              child: Text(job),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedJob = value;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: grey3Color,
                              ),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: 'JOB',
                            fillColor: grey3Color,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a job';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: orange1Color,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final updatedData = {
                'name': _nameController.text,
                'job': _selectedJob!,
              };
              context
                  .read<UserBloc>()
                  .add(UpdateUser(widget.userId, updatedData));
            }
          },
          child: Text(
            'Update',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      ),
    );
  }
}
