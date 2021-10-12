import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_aviation/src/common/dependencies/injection_container.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/screens/auth/bloc/auth_bloc.dart';
import 'package:one_aviation/src/screens/auth/login_screen.dart';
import 'package:one_aviation/src/screens/auth/new_password_screen.dart';
import 'package:one_aviation/src/screens/auth/registration_screen.dart';
import 'package:one_aviation/src/screens/auth/reset_password_screen.dart';
import 'package:one_aviation/src/screens/home/home_screen.dart';
import 'package:one_aviation/src/screens/profile/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        HomeScreen(),
        Hive.box('tokens').get('access') == null
            ? BlocProvider(
                create: (context) => AuthBloc(authServices: getIt()),
                child: LoginScreen(),
              )
            : ProfileScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(
            CupertinoIcons.home,
            size: 30,
          ),
          activeColorPrimary: PrimaryDarkTextColor,
          inactiveColorPrimary: PlaceholderIconColor,
        ),
        PersistentBottomNavBarItem(
          icon: RotationTransition(
            turns: AlwaysStoppedAnimation(30 / 360),
            child: Icon(
              Icons.airplanemode_active,
              color: PrimaryDarkTextColor,
              size: 30,
            ),
          ),
          inactiveIcon: RotationTransition(
            turns: AlwaysStoppedAnimation(30 / 360),
            child: Icon(
              Icons.airplanemode_active,
              color: PlaceholderIconColor,
              size: 30,
            ),
          ),
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: PlaceholderIconColor,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            CupertinoIcons.profile_circled,
            size: 30,
          ),
          activeColorPrimary: PrimaryDarkTextColor,
          inactiveColorPrimary: PlaceholderIconColor,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: '/',
            routes: {
              '/registration': (context) => BlocProvider(
                    create: (context) => AuthBloc(authServices: getIt()),
                    child: RegistrationScreen(),
                  ),
              '/reset_password': (context) => ResetPasswordScreen(),
              '/new_password': (context) => NewPasswordScreen(),
            },
          ),
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      onItemSelected: (i) {
        FocusScope.of(context).unfocus();
      },
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true,
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
