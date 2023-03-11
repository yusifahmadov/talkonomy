import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkonomy_app/features/home/presentation/pages/home_page_view.dart';
import '../../../../../core/button/custom_button.dart';
import '../../../../../core/shared_preferences/app_shared_preferences.dart';
import '../../../../../core/text_field/custom_input_decoration.dart';
import '../../../../../core/text_field/custom_text_field.dart';
import 'package:intl/intl.dart';
import '../../../../../injection.dart';
import '../../../data/models/helper/update_user_helper_model.dart';
import '../../../data/models/user_response_model.dart';
import '../../bloc/signup/signup_bloc.dart';

class SignupCompletePageView extends StatefulWidget {
  final SignupBloc? signupBloc;
  const SignupCompletePageView({super.key, this.signupBloc});

  @override
  State<SignupCompletePageView> createState() => _SignupCompletePageViewState();
}

class _SignupCompletePageViewState extends State<SignupCompletePageView> {
  final ageController = TextEditingController();
  UpdateUserHelperModel updateUserHelperModel = UpdateUserHelperModel();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      UserResponseModel userData = UserResponseModel.fromJson(await AppSharedPreferences.readUser("userData"));
      updateUserHelperModel.id = userData.user.id!;
    });
    super.initState();
  }

  @override
  void dispose() {
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.sp),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                  child: Text(
                "Qeydiyyatı tamamla",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
              )),
              SizedBox(
                height: 20.sp,
              ),
              CustomTextField(
                  validator: (value) {
                    if (value == '') {
                      return 'Boş buraxıla bilməz!';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    updateUserHelperModel.name = value;
                  },
                  decoration: CustomInputDecoration(
                    hintText: "Ad",
                  )),
              SizedBox(
                height: 20.sp,
              ),
              CustomTextField(
                  validator: (value) {
                    if (value == '') {
                      return 'Boş buraxıla bilməz!';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    updateUserHelperModel.surname = value;
                  },
                  decoration: CustomInputDecoration(
                    hintText: "Soyad",
                  )),
              SizedBox(
                height: 20.sp,
              ),
              CustomTextField(
                  readOnly: true,
                  controller: ageController,
                  validator: (value) {
                    if (value == '') {
                      return 'Boş buraxıla bilməz!';
                    }
                    return null;
                  },
                  onTap: () async {
                    await showDatePicker(
                            context: context,
                            initialDate: ageController.text != "" ? DateFormat("dd-MM-yyyy").parse(ageController.text) : DateTime.now(),
                            firstDate: DateTime(1910, 1, 1),
                            lastDate: DateTime(2110, 1, 1))
                        .then((value) async {
                      if (value != null) {
                        ageController.text = DateFormat("dd-MM-yyyy").format(value);
                        updateUserHelperModel.age = DateFormat("yyyy-MM-dd").format(value);
                      }
                    });
                  },
                  decoration: CustomInputDecoration(
                    prefixIcon: const Icon(Icons.calendar_month),
                    hintText: "Yaş",
                  )),
              const Spacer(),
              CustomButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      getIt<SignupBloc>().add(SignupCompleteButtonPressed(
                          model: updateUserHelperModel,
                          whenSuccess: () async {
                            Navigator.of(context)
                                .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePageView()), (route) => false);
                          }));
                    }
                  },
                  text: "Qeydiyyatı tamamla"),
              SizedBox(
                height: 25.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
