import 'package:app_simple/Presentation/page/Home_screen.dart';
import 'package:app_simple/Presentation/page/Login_screen.dart';
import 'package:app_simple/Presentation/page/Menu_screeen.dart';
import 'package:app_simple/Presentation/page/Register_screen.dart';
import 'package:app_simple/Presentation/page/add_menu_screen.dart';
import 'package:app_simple/Presentation/page/edit_menu_screen.dart';
import 'package:app_simple/Presentation/page/forgot_password.dart';
import 'package:app_simple/core/models/menu_items.dart';
import 'package:go_router/go_router.dart';

part 'Route_name.dart';

final appRoute = [
  GoRoute(
    path: '/home',
    name: Routes.home,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/login',
    name: Routes.login,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    name: Routes.register,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/forgot_password',
    name: Routes.forgot_password,
    builder: (context, state) => const ForgotPasswordScreen(),
  ),
  GoRoute(
    path: '/menu',
    name: Routes.menu,
    builder: (context, state) => MenuScreen(),
  ),
  GoRoute(
    path: '/addmenu',
    name: Routes.addmenu,
    builder: (context, state) => AddMenuScreen(),
  ),
  GoRoute(
    path: '/editmenu',
    name: Routes.editmenu,
    builder: (context, state) {
      final menuitems = state.extra as MenuItems;
     return EditMenuScreen(menuItems: menuitems);
    },
  ),
];
