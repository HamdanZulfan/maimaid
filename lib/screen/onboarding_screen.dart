import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maimaid_app/utils/theme.dart';

import '../blocs/onboarding_bloc/onboarding_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/onboarding_1.png',
      'title': 'Temukan Temanmu',
      'description':
          'Jangan Lupa Telpon Temanmu Sekarang Ya, Silahturami Yuk Sekarang.'
    },
    {
      'image': 'assets/onboarding_2.png',
      'title': 'Kemudahan Akses',
      'description':
          'Kontak tersimpan memudahkan pencarian dan penggunaan detail kontak.'
    },
    {
      'image': 'assets/onboarding_3.png',
      'title': 'Effisien',
      'description':
          'Penyimpanan kontak yang terorganisir mempercepat proses komunikasi!!'
    },
    {
      'image': 'assets/onboarding_4.png',
      'title': 'Keamanan Data',
      'description':
          'Penyimpanan kontak modern dilengkapi pencadangan untuk melindungi data.'
    },
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<OnboardingBloc, OnboardingState>(
            listener: (context, state) {
              if (state is OnboardingPageState) {
                _pageController.animateToPage(
                  state.currentPage,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            builder: (context, state) {
              int currentPage = 0;
              if (state is OnboardingPageState) {
                currentPage = state.currentPage;
              }

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: pages.length,
                      controller: _pageController,
                      onPageChanged: (index) {
                        if (index > currentPage) {
                          BlocProvider.of<OnboardingBloc>(context)
                              .add(NextPageEvent());
                        } else if (index < currentPage) {
                          BlocProvider.of<OnboardingBloc>(context)
                              .add(PrevPageEvent());
                        }
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(pages[index]['image']!),
                            const SizedBox(height: 20),
                            Text(pages[index]['title']!,
                                style: blackTextStyle.copyWith(
                                    fontSize: 24, fontWeight: bold)),
                            const SizedBox(height: 10),
                            Text(
                              pages[index]['description']!,
                              style: blue1Style.copyWith(
                                fontWeight: medium,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (index) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPage == index
                                ? orange1Color
                                : orange2Color,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange1Color,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (currentPage < pages.length - 1) {
                        BlocProvider.of<OnboardingBloc>(context)
                            .add(NextPageEvent());
                      } else {
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                    child: Text(
                      currentPage < pages.length - 1 ? 'NEXT' : 'GET STARTED',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Text(
                      'Skip',
                      style: blue1Style.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
