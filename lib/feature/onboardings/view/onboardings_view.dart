import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_im_v00r01/feature/onboardings/view/mixin/onboardings_view_mixin.dart';
import 'package:x_im_v00r01/feature/onboardings/view/widget/onboardingpages.dart';
import 'package:x_im_v00r01/feature/onboardings/view_model/onboardings_view_model.dart';
import 'package:x_im_v00r01/feature/onboardings/view_model/state/onboardings_state.dart';
import 'package:x_im_v00r01/product/navigation/deeplink/app_router.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';

@RoutePage()
class OnboardingsView extends StatefulWidget {
  const OnboardingsView({super.key});

  @override
  State<OnboardingsView> createState() => _OnboardingsViewState();
}

class _OnboardingsViewState extends BaseState<OnboardingsView>
    with OnboardingsViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => onboardingsViewModel,
      child: Scaffold(
        body: BlocBuilder<OnboardingsViewModel, OnboardingsState>(
          builder: (context, state) {
            return Stack(
              children: [
                PageView.builder(
                  controller: onboardingsViewModel.pageController,
                  onPageChanged: (index) {
                    print('index: $index');
                    onboardingsViewModel
                        .emit(state.copyWith(currentPage: index));
                  },
                  itemCount: onboardingPages.length,
                  itemBuilder: (context, index) {
                    print('index: $index');
            
                    final page = onboardingPages[index];
            
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (page.titlePosition == 'top') ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 45,
                            ),
                            child: Text(
                              page.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'fallingskysebd',
                                //color: Color(int.parse('0xFF041839')),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 45,
                            ),
                            child: Text(
                              page.description,
                              style: const TextStyle(
                                fontFamily: 'lilgrotesk',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                //color: Color(int.parse('0xFF000000')),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          _buildImageOrAnimation(page),
                        ] else if (page.titlePosition == 'bottom') ...[
                          _buildImageOrAnimation(page),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 45,
                            ),
                            child: Text(
                              page.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'fallingskysebd',
                                //color: Color(int.parse('0xFF041839')),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 45,
                            ),
                            child: Text(
                              page.description,
                              style: const TextStyle(
                                fontFamily: 'lilgrotesk',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                //color: Color(int.parse('0xFF000000')),
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Row(
                    children: List.generate(
                      onboardingPages.length,
                      (index) => Container(
                        margin: const EdgeInsets.all(4),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: state.currentPage == index
                              ? const Color.fromARGB(255, 179, 134, 2)
                              : const Color(0xFFC9CCD2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: 40,
                  width: 150,
                  right: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      if (state.currentPage == onboardingPages.length - 1) {
                        onboardingsViewModel.completeOnboarding();
                        context.router.replaceAll([const NavigationRoute()]);
                      } else {
                        onboardingsViewModel.nextPage();
                      }
                    },
                    child: Text(
                      state.currentPage == onboardingPages.length - 1
                          ? 'onboardings.start'.tr()
                          : 'onboardings.next'.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'fallingskysebd',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: state.currentPage > 0
                      ? IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () {
                            onboardingsViewModel.previousPage();
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child: InkWell(
                    onTap: () {
                      onboardingsViewModel.completeOnboarding();
                      context.router.replaceAll([const NavigationRoute()]);
                    },
                    child: Text(
                      'onboardings.skip'.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'fallingskysebd',
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageOrAnimation(OnboardingPage page) {
    return Align(
      child: page.imageAsset as Widget,
    );
  }
}
