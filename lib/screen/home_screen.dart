import 'package:flutter/material.dart';
import 'package:maimaid_app/utils/theme.dart';

import '../widgets/tab_bar_select.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'User List',
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/createUser');
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xffECF0F4),
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: TabBarSelect(),
            ),
          ],
        ),
      ),
    );
  }
}
