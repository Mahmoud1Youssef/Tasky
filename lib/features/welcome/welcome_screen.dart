import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import '../../core/services/preferences_manager.dart';
import '../navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomSvgPicture.withoutColor(
                          path: 'assets/images/logo.svg',
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Tasky",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 116),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome To Tasky",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        SizedBox(width: 8),
                        CustomSvgPicture.withoutColor(
                          path: 'assets/images/waving_hand.svg',
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Your productivity journey starts here.",
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    CustomSvgPicture.withoutColor(
                      path: 'assets/images/welcome.svg',
                      width: 214,
                      height: 204,
                    ),
                    SizedBox(height: 28),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            controller: controller,
                            title: "Full Name",
                            hintText: "e.g. Sarah Khalid",
                            maxLines: 1,
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? false) {
                                return "Please Enter Your Full Name";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () async {
                              if (_key.currentState?.validate() ?? false) {
                                await PreferencesManager().setString(
                                  StorageKey.username,
                                  controller.value.text,
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return MainScreen();
                                    },
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    elevation: 10,
                                    content: Text(
                                      "Please Enter Your Full Name",
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                MediaQuery.of(context).size.width,
                                40,
                              ),
                            ),
                            child: Text("Let’s Get Started"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
