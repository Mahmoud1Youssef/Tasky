import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  final String userName;
  final String motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController motivationQuoteController =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController.text = widget.userName;
    motivationQuoteController.text = widget.motivationQuote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: userNameController,
                          title: "User Name",
                          hintText: "Enter Your Name",
                          maxLines: 1,
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please Enter Your Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          controller: motivationQuoteController,
                          title: "Motivation Quote",
                          hintText: "One task at a time. One step closer.",
                          maxLines: 5,
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please Write Your Motivation Quote";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      await PreferencesManager().setString(
                        'username',
                        userNameController.text,
                      );
                      await PreferencesManager().setString(
                        'motivationQuote',
                        motivationQuoteController.text,
                      );
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text("Save Changes"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
