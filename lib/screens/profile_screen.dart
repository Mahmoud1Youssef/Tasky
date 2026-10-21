import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/screens/user_details_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String? userName;
  late String? motivationQuote;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      userName = PreferencesManager().getString('username') ?? "Guest";
      motivationQuote =
          PreferencesManager().getString('motivationQuote') ??
          "One task at a time. One step closer.";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFFFCFC),
              backgroundColor: Color(0xFF15B86C),
              strokeWidth: 3,
            ),
          )
        : Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Profile",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: ThemeController.isDark()
                                  ? null
                                  : Border.all(color: Color(0xFFD1DAD6)),
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/profile.png',
                              ),
                              radius: 60,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                shape: BoxShape.circle,
                                border: ThemeController.isDark()
                                    ? null
                                    : Border.all(color: Color(0xFFD1DAD6)),
                              ),
                              child: Icon(Icons.camera_alt, size: 18),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        userName!,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        motivationQuote!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Profile Info",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return UserDetailsScreen(
                                userName: userName!,
                                motivationQuote: motivationQuote!,
                              );
                            },
                          ),
                        );
                        if (result != null && result) {
                          _loadData();
                        }
                      },
                      // visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                      leading: CustomSvgPicture(
                        path: 'assets/images/profile.svg',
                      ),
                      trailing: CustomSvgPicture(
                        path: 'assets/images/arrow.svg',
                      ),
                      title: Text("User Details"),
                    ),
                    Divider(thickness: 1),
                    ListTile(
                      // visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                      leading: CustomSvgPicture(path: 'assets/images/mode.svg'),
                      trailing: ValueListenableBuilder(
                        valueListenable: ThemeController.themeNotifier,
                        builder: (context, value, Widget? child) {
                          return Switch(
                            value: value == ThemeMode.dark,
                            onChanged: (value) async {
                              ThemeController.toggleTheme();
                            },
                          );
                        },
                      ),
                      title: Text("Dark Mode"),
                    ),

                    Divider(thickness: 1),
                    ListTile(
                      onTap: () async {
                        PreferencesManager().remove('username');
                        PreferencesManager().remove('motivationQuote');
                        PreferencesManager().remove('tasks');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return WelcomeScreen();
                            },
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      // visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                      leading: CustomSvgPicture(
                        path: 'assets/images/log_out.svg',
                      ),
                      trailing: CustomSvgPicture(
                        path: 'assets/images/arrow.svg',
                      ),

                      title: Text("Log Out"),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
