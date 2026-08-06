import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/auth/base_auth_user_provider.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';
import '../../features/hajj_umrah/presentation/pages/package_listing_screen.dart' as hajj_pkg;
import '../../features/hajj_umrah/presentation/pages/package_details_screen.dart' as hajj_pkg_details;
import '../../features/hajj_umrah/presentation/pages/booking_screen.dart' as hajj_booking;

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? HomeDashboardScreen()
          : LoginOTPWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? HomeDashboardScreen()
              : LoginOTPWidget(),
        ),
        FFRoute(
          name: SplashOnboardingWidget.routeName,
          path: SplashOnboardingWidget.routePath,
          builder: (context, params) => SplashOnboardingWidget(),
        ),
        FFRoute(
          name: LoginOTPWidget.routeName,
          path: LoginOTPWidget.routePath,
          builder: (context, params) => LoginOTPWidget(),
        ),
        FFRoute(
          name: SignupWidget.routeName,
          path: SignupWidget.routePath,
          builder: (context, params) => SignupWidget(),
        ),
        FFRoute(
          name: HomeDashboardScreen.routeName,
          path: HomeDashboardScreen.routePath,
          builder: (context, params) => HomeDashboardScreen(),
        ),
        FFRoute(
          name: BusSearchResultsScreen.routeName,
          path: BusSearchResultsScreen.routePath,
          builder: (context, params) => BusSearchResultsScreen(
            fromLocation: params.getParam('fromLocation', ParamType.String) ?? 'Mumbai',
            toLocation: params.getParam('toLocation', ParamType.String) ?? 'Pune',
            date: params.getParam('date', ParamType.DateTime) ?? DateTime.now(),
          ),
        ),
        FFRoute(
          name: HotelSearchResultsScreen.routeName,
          path: HotelSearchResultsScreen.routePath,
          builder: (context, params) => HotelSearchResultsScreen(
            destination: params.getParam('destination', ParamType.String) ?? 'Mumbai',
            checkIn: params.getParam('checkIn', ParamType.DateTime),
            checkOut: params.getParam('checkOut', ParamType.DateTime),
            guests: params.getParam('guests', ParamType.int) ?? 2,
          ),
        ),
        FFRoute(
          name: HotelDetailsScreen.routeName,
          path: HotelDetailsScreen.routePath,
          builder: (context, params) {
            final hotel = params.getParam<dynamic>('hotel', ParamType.JSON);
            return HotelDetailsScreen(
              hotel: hotel is HotelRecord
                  ? hotel
                  : HotelRecord.fromMap(hotel, hotel['id'] ?? ''),
            );
          },
        ),
        FFRoute(
          name: HotelBookingConfirmationScreen.routeName,
          path: HotelBookingConfirmationScreen.routePath,
          builder: (context, params) {
            final hotel = params.getParam<dynamic>('hotel', ParamType.JSON);
            final room = params.getParam<dynamic>('room', ParamType.JSON);
            return HotelBookingConfirmationScreen(
              hotel: hotel is HotelRecord
                  ? hotel
                  : HotelRecord.fromMap(hotel, hotel['id'] ?? ''),
              room: room is RoomRecord
                  ? room
                  : RoomRecord.fromMap(room, room['id'] ?? ''),
            );
          },
        ),
        FFRoute(
          name: HolidayPackageListingScreen.routeName,
          path: HolidayPackageListingScreen.routePath,
          builder: (context, params) => const HolidayPackageListingScreen(),
        ),
        FFRoute(
          name: HolidayPackageBookingScreen.routeName,
          path: HolidayPackageBookingScreen.routePath,
          builder: (context, params) {
            final package = params.getParam<dynamic>('package', ParamType.JSON);
            return HolidayPackageBookingScreen(
              package: package is PackageRecord
                  ? package
                  : PackageRecord.fromMap(package, package['id'] ?? ''),
            );
          },
        ),
        FFRoute(
          name: HolidayPackageDetailsScreen.routeName,
          path: HolidayPackageDetailsScreen.routePath,
          builder: (context, params) {
            final package = params.getParam<dynamic>('package', ParamType.JSON);
            return HolidayPackageDetailsScreen(
              package: package is PackageRecord
                  ? package
                  : PackageRecord.fromMap(package, package['id'] ?? ''),
            );
          },
        ),
        FFRoute(
          name: TaxiSearchResultsScreen.routeName,
          path: TaxiSearchResultsScreen.routePath,
          builder: (context, params) => TaxiSearchResultsScreen(
            from: params.getParam<String>('from', ParamType.String),
            to: params.getParam<String>('to', ParamType.String),
          ),
        ),
        FFRoute(
          name: TaxiBookingScreen.routeName,
          path: TaxiBookingScreen.routePath,
          builder: (context, params) => const TaxiBookingScreen(),
        ),
        FFRoute(
          name: CarRentalScreen.routeName,
          path: CarRentalScreen.routePath,
          builder: (context, params) => const CarRentalScreen(),
        ),
        FFRoute(
          name: CarRentalDetailsScreen.routeName,
          path: CarRentalDetailsScreen.routePath,
          builder: (context, params) {
            final car = params.getParam<dynamic>('car', ParamType.JSON);
            return CarRentalDetailsScreen(
              car: car is RentalRecord
                  ? car
                  : RentalRecord.fromMap(car, car['id'] ?? ''),
            );
          },
        ),
        FFRoute(
          name: ReferralScreen.routeName,
          path: ReferralScreen.routePath,
          builder: (context, params) => const ReferralScreen(),
        ),
        FFRoute(
          name: SeatSelectionScreen.routeName,
          path: SeatSelectionScreen.routePath,
          builder: (context, params) => const SeatSelectionScreen(),
        ),
        FFRoute(
          name: PassengerDetailsScreen.routeName,
          path: PassengerDetailsScreen.routePath,
          builder: (context, params) => const PassengerDetailsScreen(),
        ),
        FFRoute(
          name: PaymentCheckoutScreen.routeName,
          path: PaymentCheckoutScreen.routePath,
          builder: (context, params) {
            return PaymentCheckoutScreen(
              booking: params.state.extra as BookingRecord?,
            );
          },
        ),
        FFRoute(
          name: BookingConfirmationTicketScreen.routeName,
          path: BookingConfirmationTicketScreen.routePath,
          builder: (context, params) {
            return BookingConfirmationTicketScreen(
              booking: params.state.extra as BookingRecord,
            );
          },
        ),
        FFRoute(
          name: MyTripsScreen.routeName,
          path: MyTripsScreen.routePath,
          builder: (context, params) => MyTripsScreen(),
        ),
        FFRoute(
          name: ProfileScreen.routeName,
          path: ProfileScreen.routePath,
          builder: (context, params) => const ProfileScreen(),
        ),
        FFRoute(
          name: PersonalInfoScreen.routeName,
          path: PersonalInfoScreen.routePath,
          builder: (context, params) => const PersonalInfoScreen(),
        ),
        FFRoute(
          name: WalletScreen.routeName,
          path: WalletScreen.routePath,
          builder: (context, params) => const WalletScreen(),
        ),
        FFRoute(
          name: NotificationsScreen.routeName,
          path: NotificationsScreen.routePath,
          builder: (context, params) => const NotificationsScreen(),
        ),
        FFRoute(
          name: LiveTrackingScreen.routeName,
          path: LiveTrackingScreen.routePath,
          builder: (context, params) => LiveTrackingScreen(
            busId: params.getParam<String>('busId', ParamType.String),
          ),
        ),
        FFRoute(
          name: AllRoutesScreen.routeName,
          path: AllRoutesScreen.routePath,
          builder: (context, params) => const AllRoutesScreen(),
        ),
        FFRoute(
          name: LiveChatScreen.routeName,
          path: LiveChatScreen.routePath,
          builder: (context, params) => const LiveChatScreen(),
        ),
        FFRoute(
          name: FlightTrackingScreen.routeName,
          path: FlightTrackingScreen.routePath,
          builder: (context, params) => FlightTrackingScreen(
            flightId: params.getParam<String>('flightId', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'HajjDashboard',
          path: '/hajjDashboard',
          builder: (context, params) => const HajjDashboardScreen(),
        ),
        FFRoute(
          name: 'HajjPackages',
          path: '/hajjPackages',
          builder: (context, params) {
            final typeStr = params.getParam<String>('type', ParamType.String);
            return hajj_pkg.PackageListingScreen(
              type: PackageType.values.firstWhere(
                (e) => e.name == typeStr,
                orElse: () => PackageType.hajj,
              ),
            );
          },
        ),
        FFRoute(
          name: 'HajjPackageDetails',
          path: '/hajjPackageDetails',
          builder: (context, params) => hajj_pkg_details.PackageDetailsScreen(
            packageId: params.getParam<String>('id', ParamType.String)!,
          ),
        ),
        FFRoute(
          name: 'HajjBooking',
          path: '/hajjBooking',
          builder: (context, params) => hajj_booking.HajjBookingScreen(
            package: params.getParam<HajjPackage>('package', ParamType.JSON),
          ),
        ),
        FFRoute(
          name: 'MyJourney',
          path: '/myJourney',
          builder: (context, params) => const MyJourneyScreen(),
        ),
        FFRoute(
          name: 'IslamicTools',
          path: '/islamicTools',
          builder: (context, params) => IslamicToolsScreen(
            initialTab: params.getParam<int>('initialTab', ParamType.int) ?? 0,
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/loginOTP';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 300),
      );
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
