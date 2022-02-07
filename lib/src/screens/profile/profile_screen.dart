import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_aviation/src/common/dependencies/injection_container.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/models/profile/profile_model.dart';
import 'package:one_aviation/src/screens/auth/bloc/auth_bloc.dart';
import 'package:one_aviation/src/screens/auth/login_screen.dart';

import 'bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  bool _showError = false;
  String _errorMessage = '';
  ProfileModel? _profileModel;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetMyProfile());
    context.read<ProfileBloc>().add(GetDocumentTypes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: paddingHorizontal24,
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) async {
              if (state is ProfileLoading) {
                setState(() => _isLoading = true);
              } else {
                setState(() => _isLoading = false);
              }

              if (state is ProfileSuccessful) {
                setState(() {
                  _showError = false;
                  _profileModel = state.profileModel;
                });
              } else if (state is ProfileUnsuccessful) {
                setState(() {
                  _showError = true;
                  _errorMessage = state.errorMessage;
                });
              }
            },
            child: _isLoading
                ? Center(child: CupertinoActivityIndicator())
                : _showError
                    ? GestureDetector(
                        onTap: () {
                          setState(() => _showError = false);
                        },
                        child: Center(child: Text(_errorMessage)))
                    : Column(
                        children: [
                          SizedBox(height: 30),
                          Center(
                            child: SizedBox(
                              height: 64 * 1.5,
                              width: 64 * 1.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: 'https://picsum.photos/200/300',
                                  placeholder: (context, url) =>
                                      CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: PlaceholderIconColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'M',
                                        style: MyTextStyle.googleFontWrapper(
                                          MyTextStyle
                                              .ProfilePlaceholderTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  (MediaQuery.of(context).size.width - 250) /
                                          2 -
                                      24,
                            ),
                            child: Text(
                              _profileModel != null
                                  ? _profileModel!.firstName +
                                      ' ' +
                                      _profileModel!.lastName
                                  : '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: MyTextStyle.googleFontWrapper(
                                MyTextStyle.TitleTextStyle,
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          Divider(
                            color: DividerColor,
                            thickness: 3,
                          ),
                          SizedBox(height: 30),
                          ProfileButton(
                            title: 'Orders',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/profile/my_orders');
                            },
                            icon: Icons.airplane_ticket,
                          ),
                          ProfileButton(
                            title: 'Notifications',
                            onTap: () {
                              print('Profile tab');
                            },
                            icon: Icons.notifications,
                          ),
                          ProfileButton(
                            title: 'Settings',
                            onTap: () {
                              print('Profile tab');
                            },
                            icon: Icons.settings,
                          ),
                          Divider(
                            color: DividerColor,
                            thickness: 3,
                          ),
                          SizedBox(height: 30),
                          ProfileButton(
                            title: 'Log out',
                            onTap: () async {
                              var box = Hive.box('tokens');
                              await box.delete('access');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) =>
                                        AuthBloc(authServices: getIt()),
                                    child: LoginScreen(),
                                  ),
                                ),
                              );
                            },
                            icon: Icons.logout,
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final String title;
  final Function onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: GestureDetector(
        onTap: onTap as Function(),
        child: Row(
          children: [
            Icon(
              icon,
              size: 36,
              color: PrimaryDarkTextColor,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: MyTextStyle.googleFontWrapper(
                  MyTextStyle.DarkTitleTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
