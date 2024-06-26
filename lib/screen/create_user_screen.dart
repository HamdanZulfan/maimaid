import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maimaid_app/blocs/create_user_bloc/create_user_bloc.dart';
import 'package:maimaid_app/widgets/success_create.dart';

import '../services/api_service.dart';
import '../utils/theme.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _jobs = ['Front End', 'Back End', 'Data Analyst'];
  String? _selectedJob;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUserBloc(ApiService()),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
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
                          'Create User',
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
                  Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            Text(
                              'JOB',
                              style: grey2TextStyle.copyWith(
                                fontWeight: semiBold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            BlocBuilder<CreateUserBloc, CreateUserState>(
                              builder: (context, state) {
                                if (state is JobSelected) {
                                  _selectedJob = state.job;
                                }
                                return DropdownButtonFormField<String>(
                                  value: _selectedJob,
                                  hint: const Text('Select Job'),
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
                                  items: _jobs.map((String job) {
                                    return DropdownMenuItem<String>(
                                      value: job,
                                      child: Text(job),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    context.read<CreateUserBloc>().add(
                                          SelectJob(value!),
                                        );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a job';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: BlocConsumer<CreateUserBloc, CreateUserState>(
            listener: (context, state) {
              if (state is UserSuccess) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SuccessCreate(),
                  ),
                );
              } else if (state is UserFailure) {
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
              }
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange1Color,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final name = _nameController.text;
                    final job = _selectedJob;
                    if (job != null) {
                      context.read<CreateUserBloc>().add(CreateUser(name, job));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a job'),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'Create',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
