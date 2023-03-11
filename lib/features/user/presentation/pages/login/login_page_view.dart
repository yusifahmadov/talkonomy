// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talkonomy_app/features/home/presentation/pages/home_page_view.dart';
import 'package:talkonomy_app/features/user/data/models/helper/login_helper_model.dart';
import 'package:talkonomy_app/features/user/data/models/user_model.dart';
import 'package:talkonomy_app/features/user/presentation/bloc/login/login_bloc.dart';
import 'package:talkonomy_app/features/user/presentation/bloc/user_cubit.dart';
import 'package:talkonomy_app/features/user/presentation/pages/signup/signup_complete_page_view.dart';
import 'package:talkonomy_app/features/user/presentation/pages/signup/signup_page_view.dart';
import '../../../../../core/button/custom_button.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/text_field/custom_input_decoration.dart';
import '../../../../../core/text_field/custom_text_field.dart';

import '../../../../../injection.dart';

class LoginPageView extends StatelessWidget {
  LoginPageView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginHelperModel loginHelperModel = LoginHelperModel(email: '', password: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<LoginBloc>(),
        child: Builder(builder: (context) {
          return Container(
            width: 1.sw,
            height: 1.sh,
            decoration: const BoxDecoration(color: appPrimaryColor),
            child: Column(
              children: [_topSideImage(), _bottomSideForm(context)],
            ),
          );
        }),
      ),
    );
  }

  Expanded _bottomSideForm(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 15, spreadRadius: 2, color: Colors.black.withOpacity(0.2))],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.sp),
          ),
          color: Colors.white,
        ),
        child: SizedBox(
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) async {
                  if (state is LoginSuccess) {
                    UserModel userData = await getIt<UserCubit>().getAuthUserData(id: state.data.id!);
                    if (userData.verified!) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePageView(),
                          ),
                          (route) => false);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupCompletePageView(),
                          ));
                    }
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 55.sp,
                      ),
                      Text(
                        "Giriş",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(
                        height: 69.sp,
                      ),
                      CustomTextField(
                        onChanged: (value) {
                          loginHelperModel.email = value;
                        },
                        validator: (value) {
                          if (value == "") {
                            return 'Boş buraxıla bilməz!';
                          }
                          return null;
                        },
                        decoration: CustomInputDecoration(
                            prefixIcon: SvgPicture.asset(
                              "assets/mail-outline.svg",
                              width: 25.sp,
                              color: const Color(0xff676767),
                              height: 25.sp,
                            ),
                            hintText: "Email"),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomTextField(
                        validator: (value) {
                          if (value == "") {
                            return 'Boş buraxıla bilməz!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          loginHelperModel.password = value;
                        },
                        obscureText: true,
                        decoration: CustomInputDecoration(
                            prefixIcon: SvgPicture.asset(
                              "assets/lock-closed-outline.svg",
                              width: 25.sp,
                              height: 25.sp,
                              color: const Color(0xff676767),
                            ),
                            hintText: "Şifrə"),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          CustomButton(
                              text: "Giriş et",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
                                    model: loginHelperModel,
                                  ));
                                }
                              },
                              buttonColor: appPrimaryColor),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Hesabınız yoxdur?"),
                              SizedBox(
                                width: 10.sp,
                              ),
                              InkWell(
                                onTap: () async {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupPageView(),
                                      ),
                                      (route) => false);
                                },
                                child: Text(
                                  "Qeydiyyat ol",
                                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 16),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 55.sp,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _topSideImage() {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.transparent,
        child: Image(
          image: const AssetImage("assets/logo.png"),
          width: 250.sp,
        ),
      ),
    );
  }
}
