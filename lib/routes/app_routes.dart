// ignore_for_file: constant_identifier_names

part of './app_pages.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const HOME = '/home';

  ///
  /// [AuthRoutes]
  ///
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const FORGOT_PASSWORD = '/forgot-password';

  ///
  /// [ProfileRoutes]
  ///
  static const PROFILE = '/profile';
  static const PROFILE_CREATE = '/profile/create';

  ///
  /// [ChannelRoutes]
  ///
  static const CHANNEL_CREATE = '/channel/create';
}
