import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkonomy_app/core/button/custom_button.dart';
import 'package:talkonomy_app/core/constant.dart';
import 'package:talkonomy_app/core/custom_flasher.dart';
import 'package:talkonomy_app/core/text_field/custom_input_decoration.dart';
import 'package:talkonomy_app/core/text_field/custom_text_field.dart';
import 'package:talkonomy_app/features/user/data/models/user_model.dart';
import 'package:talkonomy_app/features/user/presentation/bloc/auth/auth_bloc.dart';
import 'package:talkonomy_app/features/user/presentation/bloc/user_cubit.dart';
import 'package:intl/intl.dart';
import 'package:talkonomy_app/features/user/presentation/pages/login/login_page_view.dart';
import '../../../../../injection.dart';
import '../../../data/models/helper/update_user_helper_model.dart';

class UserDetailPageView extends StatefulWidget {
  const UserDetailPageView({super.key});

  @override
  State<UserDetailPageView> createState() => _UserDetailPageViewState();
}

class _UserDetailPageViewState extends State<UserDetailPageView> {
  final nameController = TextEditingController();

  final surNameController = TextEditingController();

  final ageController = TextEditingController();

  @override
  void dispose() {
    ageController.dispose();
    surNameController.dispose();
    nameController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UpdateUserHelperModel updateUserHelperModel = UpdateUserHelperModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "User detail",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 18.sp),
        ),
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<UserModel>(
          stream: ctx!.read<UserCubit>().userInformationCont,
          initialData: const UserModel(id: null, name: null, surname: null, age: null, profileImage: null, verified: null),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.sp,
                    ),
                    Align(
                      child: Container(
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(width: 1, color: Colors.grey)),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Image(
                              image: NetworkImage(snapshot.data!.profileImage ?? "https://static.thenounproject.com/png/104062-200.png")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    CustomTextField(
                        validator: (value) {
                          if (value == '') {
                            return 'Cannot be left blank';
                          }
                          return null;
                        },
                        controller: nameController..text = snapshot.data!.name ?? "",
                        decoration: CustomInputDecoration(hintText: "Name")),
                    SizedBox(
                      height: 20.sp,
                    ),
                    CustomTextField(
                        validator: (value) {
                          if (value == '') {
                            return 'Cannot be left blank';
                          }
                          return null;
                        },
                        controller: surNameController..text = snapshot.data!.surname ?? "",
                        decoration: CustomInputDecoration(hintText: "Surname")),
                    SizedBox(
                      height: 20.sp,
                    ),
                    CustomTextField(
                        validator: (value) {
                          if (value == '') {
                            return 'Cannot be left blank';
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: () async {
                          await showDatePicker(
                                  context: context,
                                  initialDate:
                                      ageController.text != "" ? DateFormat("dd-MM-yyyy").parse(ageController.text) : DateTime.now(),
                                  firstDate: DateTime(1910, 1, 1),
                                  lastDate: DateTime(2110, 1, 1))
                              .then((value) async {
                            if (value != null) {
                              ageController.text = DateFormat("dd-MM-yyyy").format(value);
                              updateUserHelperModel.age = DateFormat("yyyy-MM-dd").format(value);
                            }
                          });
                        },
                        controller: ageController
                          ..text = snapshot.data!.age != null ? DateFormat("dd-MM-yyyy").format(snapshot.data!.age!) : "",
                        decoration: CustomInputDecoration(hintText: "Age")),
                    const Spacer(),
                    CustomButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await getIt<UserCubit>().updateUserInformation(
                                model: UpdateUserHelperModel(
                                    age: DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(ageController.text)),
                                    id: snapshot.data!.id!,
                                    name: nameController.text,
                                    surname: surNameController.text),
                                whenSuccess: () async {
                                  CustomFlasher.showSuccess("User information is updated");
                                });
                          }
                        },
                        text: "Save"),
                    SizedBox(
                      height: 20.sp,
                    ),
                    CustomButton(
                      onPressed: () async {
                        ctx!.read<AuthBloc>().add(LoggedOut(whenSuccess: () async {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPageView(),
                              ),
                              (route) => false);
                        }));
                      },
                      text: "Logout",
                      buttonColor: redColor,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
