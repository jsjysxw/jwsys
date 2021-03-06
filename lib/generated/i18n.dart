import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) =>
      Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  // /// "Flutter Template"
  // String get title => "Flutter Template";

  // /// "Login"
  // String get login => "Login";

  // /// "Logout"
  // String get logout => "Logout";

  // /// "LoginName"
  // String get loginName => "LoginName";

  // /// "Please enter your login name or email"
  // String get loginNameHint => "Please enter your login name or email";

  // /// "LoginName cannot be empty!"
  // String get loginNameError => "LoginName cannot be empty!";

  // /// "Password"
  // String get password => "Password";

  // /// "Please enter your password"
  // String get passwordHint => "Please enter your password";

  // /// "Password cannot be less than 6 digits!"
  // String get passwordError => "Password cannot be less than 6 digits!";

  // /// "Login Success"
  // String get loginSuccess => "Login Success";

  // /// "Register"
  // String get register => "Register";

  // /// "Repeat Password"
  // String get repeatPassword => "Repeat Password";

  // /// "Register Success"
  // String get registerSuccess => "Register Success";

  // /// "Settings"
  // String get settings => "Settings";

  // /// "Theme"
  // String get theme => "Theme";

  // /// "Language"
  // String get language => "Language";

  // /// "Chinese"
  // String get chinese => "Chinese";

  // /// "English"
  // String get english => "English";

  // /// "Auto"
  // String get auto => "Auto";

  // /// "About"
  // String get about => "About";

  // /// "Version"
  // String get versionName => "Version";

  // /// "Author"
  // String get author => "Author";

  // /// "QQ Group"
  // String get qqgroup => "QQ Group";

  // /// "AppUpdate"
  // String get appupdate => "AppUpdate";

  // /// "Home"
  // String get home => "Home";

  // /// "Category"
  // String get category => "Category";

  // /// "Activity"
  // String get activity => "Activity";

  // /// "Message"
  // String get message => "Message";

  // /// "Profile"
  // String get profile => "Profile";

  // /// "Reminder"
  // String get reminder => "Reminder";

  // /// "Agree"
  // String get agree => "Agree";

  // /// "Disagree"
  // String get disagree => "Disagree";

  // /// "Look Again"
  // String get lookAgain => "Look Again";

  // /// "Still Disagree"
  // String get stillDisagree => "Still Disagree";

  // /// "  Do you want to think about it again???"
  // String get thinkAboutItAgain => "  Do you want to think about it again???";

  // /// "    We attach great importance to the protection of your personal information and promise to protect and process your information in strict accordance with the ???${appName} privacy policy???. If you do not agree with the policy, we regret that we will not be able to provide you with services."
  // String privacyExplainAgain(String appName) =>
  //     "    We attach great importance to the protection of your personal information and promise to protect and process your information in strict accordance with the ???${appName} privacy policy???. If you do not agree with the policy, we regret that we will not be able to provide you with services.";

  // /// "Exit App"
  // String get exitApp => "Exit App";

  // /// "???${appName} privacy policy???"
  // String privacyName(String appName) => "???${appName} privacy policy???";

  // /// "   Welcome to ${appName}!"
  // String welcome(String appName) => "   Welcome to ${appName}!";

  // /// "   We know the importance of personal information to you and thank you for your trust in us."
  // String get welcome1 =>
  //     "   We know the importance of personal information to you and thank you for your trust in us.";

  // /// "   In order to better protect your rights and interests and comply with the relevant regulatory requirements, we will explain to you through "
  // String get welcome2 =>
  //     "   In order to better protect your rights and interests and comply with the relevant regulatory requirements, we will explain to you through ";

  // /// " how we will collect, store, protect, use and provide your information to the outside world, and explain your rights."
  // String get welcome3 =>
  //     " how we will collect, store, protect, use and provide your information to the outside world, and explain your rights.";

  // /// "   For more details, please refer to"
  // String get welcome4 => "   For more details, please refer to";

  // /// " the full text."
  // String get welcome5 => " the full text.";

  // /// "Privacy agreement agreed!"
  // String get agreePrivacy => "Privacy agreement agreed!";

  // /// "Dark Theme"
  // String get darkTheme => "Dark Theme";

  /// "Flutter????????????"
  @override
  String get title => "Flutter????????????";

  /// "??????"
  @override
  String get login => "??????";

  /// "??????"
  @override
  String get logout => "??????";

  /// "?????????"
  @override
  String get loginName => "?????????";

  /// "?????????????????????????????????"
  @override
  String get loginNameHint => "?????????????????????????????????";

  /// "?????????????????????!"
  @override
  String get loginNameError => "?????????????????????!";

  /// "??????"
  @override
  String get password => "??????";

  /// "?????????????????????"
  @override
  String get passwordHint => "?????????????????????";

  /// "??????????????????6???!"
  @override
  String get passwordError => "??????????????????6???!";

  /// "????????????"
  @override
  String get loginSuccess => "????????????";

  /// "??????"
  @override
  String get register => "??????";

  /// "????????????"
  @override
  String get repeatPassword => "????????????";

  /// "????????????"
  @override
  String get registerSuccess => "????????????";

  /// "??????"
  @override
  String get settings => "??????";

  /// "??????"
  @override
  String get theme => "??????";

  /// "??????"
  @override
  String get language => "??????";

  /// "????????????"
  @override
  String get chinese => "????????????";

  /// "??????"
  @override
  String get english => "??????";

  /// "????????????"
  @override
  String get auto => "????????????";

  /// "??????"
  @override
  String get about => "??????";

  /// "?????????"
  @override
  String get versionName => "?????????";

  /// "??????"
  @override
  String get author => "??????";

  /// "QQ???"
  @override
  String get qqgroup => "QQ???";

  /// "????????????"
  @override
  String get appupdate => "????????????";

  /// "??????"
  @override
  String get home => "??????";

  /// "??????"
  @override
  String get category => "??????";

  /// "??????"
  @override
  String get activity => "??????";

  /// "??????"
  @override
  String get message => "??????";

  /// "??????"
  @override
  String get profile => "??????";

  /// "????????????"
  @override
  String get reminder => "????????????";

  /// "??????"
  @override
  String get agree => "??????";

  /// "?????????"
  @override
  String get disagree => "?????????";

  /// "????????????"
  @override
  String get lookAgain => "????????????";

  /// "????????????"
  @override
  String get stillDisagree => "????????????";

  /// "  ?????????????????????"
  @override
  String get thinkAboutItAgain => "  ?????????????????????";

  /// "    ?????????????????????????????????????????????????????????????????????${appName}???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"
  @override
  String privacyExplainAgain(String appName) =>
      "    ?????????????????????????????????????????????????????????????????????${appName}???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????";

  /// "????????????"
  @override
  String get exitApp => "????????????";

  /// "???${appName}??????????????????"
  @override
  String privacyName(String appName) => "???${appName}??????????????????";

  /// "   ????????????${appName}!"
  @override
  String welcome(String appName) => "   ????????????${appName}!";

  /// "   ??????????????????????????????????????????????????????????????????????????????"
  @override
  String get welcome1 => "   ??????????????????????????????????????????????????????????????????????????????";

  /// "   ???????????????????????????????????????????????????????????????????????????????????????"
  @override
  String get welcome2 => "   ???????????????????????????????????????????????????????????????????????????????????????";

  /// "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"
  @override
  String get welcome3 => "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????";

  /// "   ???????????????????????????"
  @override
  String get welcome4 => "   ???????????????????????????";

  /// "?????????"
  @override
  String get welcome5 => "?????????";

  /// "?????????????????????!"
  @override
  String get agreePrivacy => "?????????????????????!";

  /// "????????????"
  @override
  String get darkTheme => "????????????";
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_zh_CN extends I18n {
  const _I18n_zh_CN();

  /// "Flutter????????????"
  @override
  String get title => "Flutter????????????";

  /// "??????"
  @override
  String get login => "??????";

  /// "??????"
  @override
  String get logout => "??????";

  /// "?????????"
  @override
  String get loginName => "?????????";

  /// "?????????????????????????????????"
  @override
  String get loginNameHint => "?????????????????????????????????";

  /// "?????????????????????!"
  @override
  String get loginNameError => "?????????????????????!";

  /// "??????"
  @override
  String get password => "??????";

  /// "?????????????????????"
  @override
  String get passwordHint => "?????????????????????";

  /// "??????????????????6???!"
  @override
  String get passwordError => "??????????????????6???!";

  /// "????????????"
  @override
  String get loginSuccess => "????????????";

  /// "??????"
  @override
  String get register => "??????";

  /// "????????????"
  @override
  String get repeatPassword => "????????????";

  /// "????????????"
  @override
  String get registerSuccess => "????????????";

  /// "??????"
  @override
  String get settings => "??????";

  /// "??????"
  @override
  String get theme => "??????";

  /// "??????"
  @override
  String get language => "??????";

  /// "????????????"
  @override
  String get chinese => "????????????";

  /// "??????"
  @override
  String get english => "??????";

  /// "????????????"
  @override
  String get auto => "????????????";

  /// "??????"
  @override
  String get about => "??????";

  /// "?????????"
  @override
  String get versionName => "?????????";

  /// "??????"
  @override
  String get author => "??????";

  /// "QQ???"
  @override
  String get qqgroup => "QQ???";

  /// "????????????"
  @override
  String get appupdate => "????????????";

  /// "??????"
  @override
  String get home => "??????";

  /// "??????"
  @override
  String get category => "??????";

  /// "??????"
  @override
  String get activity => "??????";

  /// "??????"
  @override
  String get message => "??????";

  /// "??????"
  @override
  String get profile => "??????";

  /// "????????????"
  @override
  String get reminder => "????????????";

  /// "??????"
  @override
  String get agree => "??????";

  /// "?????????"
  @override
  String get disagree => "?????????";

  /// "????????????"
  @override
  String get lookAgain => "????????????";

  /// "????????????"
  @override
  String get stillDisagree => "????????????";

  /// "  ?????????????????????"
  @override
  String get thinkAboutItAgain => "  ?????????????????????";

  /// "    ?????????????????????????????????????????????????????????????????????${appName}???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"
  @override
  String privacyExplainAgain(String appName) =>
      "    ?????????????????????????????????????????????????????????????????????${appName}???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????";

  /// "????????????"
  @override
  String get exitApp => "????????????";

  /// "???${appName}??????????????????"
  @override
  String privacyName(String appName) => "???${appName}??????????????????";

  /// "   ????????????${appName}!"
  @override
  String welcome(String appName) => "   ????????????${appName}!";

  /// "   ??????????????????????????????????????????????????????????????????????????????"
  @override
  String get welcome1 => "   ??????????????????????????????????????????????????????????????????????????????";

  /// "   ???????????????????????????????????????????????????????????????????????????????????????"
  @override
  String get welcome2 => "   ???????????????????????????????????????????????????????????????????????????????????????";

  /// "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"
  @override
  String get welcome3 => "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????";

  /// "   ???????????????????????????"
  @override
  String get welcome4 => "   ???????????????????????????";

  /// "?????????"
  @override
  String get welcome5 => "?????????";

  /// "?????????????????????!"
  @override
  String get agreePrivacy => "?????????????????????!";

  /// "????????????"
  @override
  String get darkTheme => "????????????";

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[Locale("en", "US"), Locale("zh", "CN")];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode =
        I18n._locale != null ? I18n._locale.languageCode : "";
    if ("en_US" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    } else if ("zh_CN" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_zh_CN());
    } else if ("en" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    } else if ("zh" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_zh_CN());
    }

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}
