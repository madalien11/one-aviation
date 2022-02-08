import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_aviation/src/common/dependencies/injection_container.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/screens/auth/bloc/auth_bloc.dart';
import 'package:one_aviation/src/screens/auth/login_screen.dart';
import 'package:one_aviation/src/screens/auth/new_password_screen.dart';
import 'package:one_aviation/src/screens/auth/otp_screen.dart';
import 'package:one_aviation/src/screens/auth/registration_screen.dart';
import 'package:one_aviation/src/screens/auth/reset_password_screen.dart';
import 'package:one_aviation/src/screens/flight/add_passengers/add_passengers_screen.dart';
import 'package:one_aviation/src/screens/flight/bloc/flights_bloc.dart';
import 'package:one_aviation/src/screens/flight/flight_screen.dart';
import 'package:one_aviation/src/screens/flight/found_flights/found_flights_screen.dart';
import 'package:one_aviation/src/screens/home/home_screen.dart';
import 'package:one_aviation/src/screens/map/bloc/location_bloc.dart';
import 'package:one_aviation/src/screens/map/map_screen.dart';
import 'package:one_aviation/src/screens/profile/bloc/profile_bloc.dart';
import 'package:one_aviation/src/screens/profile/my_orders/my_orders_screen.dart';
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
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FlightsBloc(flightServices: getIt()),
            ),
            BlocProvider(
              create: (context) => ProfileBloc(profileService: getIt()),
            ),
          ],
          child: HomeScreen(),
        ),
        BlocProvider(
          create: (context) => FlightsBloc(flightServices: getIt()),
          child: FlightScreen(),
        ),
        Hive.box('tokens').get('access') == null
            ? BlocProvider(
                create: (context) => AuthBloc(authServices: getIt()),
                child: LoginScreen(),
              )
            : BlocProvider(
                create: (context) => ProfileBloc(profileService: getIt()),
                child: ProfileScreen(),
              )
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
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: '/home',
            routes: {
              '/home/passengers': (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            FlightsBloc(flightServices: getIt()),
                      ),
                      BlocProvider(
                        create: (context) =>
                            ProfileBloc(profileService: getIt()),
                      ),
                    ],
                    child: AddPassengersScreen(),
                  ),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: RotationTransition(
            turns: AlwaysStoppedAnimation(90 / 360),
            child: Icon(
              Icons.airplanemode_active,
              color: PrimaryBlueColor,
              size: 30,
            ),
          ),
          inactiveIcon: RotationTransition(
            turns: AlwaysStoppedAnimation(90 / 360),
            child: Icon(
              Icons.airplanemode_active,
              color: PlaceholderIconColor,
              size: 30,
            ),
          ),
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: PlaceholderIconColor,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: '/flight',
            routes: {
              '/flight/map': (context) => BlocProvider(
                    create: (context) => LocationBloc(locationService: getIt()),
                    child: MapScreen(),
                  ),
              '/flight/search': (context) => BlocProvider(
                    create: (context) => FlightsBloc(flightServices: getIt()),
                    child: FoundFlightsScreen(),
                  ),
              '/flight/passengers': (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            FlightsBloc(flightServices: getIt()),
                      ),
                      BlocProvider(
                        create: (context) =>
                            ProfileBloc(profileService: getIt()),
                      ),
                    ],
                    child: AddPassengersScreen(),
                  ),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            CupertinoIcons.profile_circled,
            size: 30,
          ),
          activeColorPrimary: PrimaryDarkTextColor,
          inactiveColorPrimary: PlaceholderIconColor,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: '/profile',
            routes: {
              '/profile/registration': (context) => BlocProvider(
                    create: (context) => AuthBloc(authServices: getIt()),
                    child: RegistrationScreen(),
                  ),
              '/profile/reset_password': (context) => BlocProvider(
                    create: (context) => AuthBloc(authServices: getIt()),
                    child: ResetPasswordScreen(),
                  ),
              '/profile/otp': (context) => BlocProvider(
                    create: (context) => AuthBloc(authServices: getIt()),
                    child: OTPScreen(),
                  ),
              '/profile/new_password': (context) => BlocProvider(
                    create: (context) => AuthBloc(authServices: getIt()),
                    child: NewPasswordScreen(),
                  ),
              '/profile/my_orders': (context) => MyOrdersScreen(),
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
