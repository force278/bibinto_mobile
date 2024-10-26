// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Localized {
  Localized();

  static Localized? _current;

  static Localized get current {
    assert(_current != null,
        'No instance of Localized was loaded. Try to initialize the Localized delegate before accessing Localized.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Localized> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Localized();
      Localized._current = instance;

      return instance;
    });
  }

  static Localized of(BuildContext context) {
    final instance = Localized.maybeOf(context);
    assert(instance != null,
        'No instance of Localized present in the widget tree. Did you add Localized.delegate in localizationsDelegates?');
    return instance!;
  }

  static Localized? maybeOf(BuildContext context) {
    return Localizations.of<Localized>(context, Localized);
  }

  /// `Нет аккаунта?`
  String get noAccount {
    return Intl.message(
      'Нет аккаунта?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Уже есть аккаунт?`
  String get haveAccount {
    return Intl.message(
      'Уже есть аккаунт?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Зарегистрироваться`
  String get registration {
    return Intl.message(
      'Зарегистрироваться',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Вход`
  String get entrance {
    return Intl.message(
      'Вход',
      name: 'entrance',
      desc: '',
      args: [],
    );
  }

  /// `Электронная почта`
  String get email {
    return Intl.message(
      'Электронная почта',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get password {
    return Intl.message(
      'Пароль',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Забыли пароль?`
  String get forgotPassword {
    return Intl.message(
      'Забыли пароль?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get logIn {
    return Intl.message(
      'Войти',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Регистрация`
  String get signUp {
    return Intl.message(
      'Регистрация',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Введите электронную почту на который мы отправим код для авторизации`
  String get descForRegistration {
    return Intl.message(
      'Введите электронную почту на который мы отправим код для авторизации',
      name: 'descForRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Подтверждение кода`
  String get codeConfirmation {
    return Intl.message(
      'Подтверждение кода',
      name: 'codeConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `На электронный адрес {email} отправлено сообщение с кодом подтверждения. Введите код и нажмите подтвердить`
  String descForCodeConfirm(Object email) {
    return Intl.message(
      'На электронный адрес $email отправлено сообщение с кодом подтверждения. Введите код и нажмите подтвердить',
      name: 'descForCodeConfirm',
      desc: '',
      args: [email],
    );
  }

  /// `Подтвердить`
  String get confirm {
    return Intl.message(
      'Подтвердить',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Отправить повторно через {seconds} сек.`
  String sendAgain(Object seconds) {
    return Intl.message(
      'Отправить повторно через $seconds сек.',
      name: 'sendAgain',
      desc: '',
      args: [seconds],
    );
  }

  /// `Создание пароля`
  String get createPassword {
    return Intl.message(
      'Создание пароля',
      name: 'createPassword',
      desc: '',
      args: [],
    );
  }

  /// `Придумайте пароль для входа в аккаунт`
  String get passwordForLogIn {
    return Intl.message(
      'Придумайте пароль для входа в аккаунт',
      name: 'passwordForLogIn',
      desc: '',
      args: [],
    );
  }

  /// `Введите пароль`
  String get enterPassword {
    return Intl.message(
      'Введите пароль',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Повторите пароль`
  String get repeatPassword {
    return Intl.message(
      'Повторите пароль',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Основная информация`
  String get basicInfo {
    return Intl.message(
      'Основная информация',
      name: 'basicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Никнейм`
  String get nickName {
    return Intl.message(
      'Никнейм',
      name: 'nickName',
      desc: '',
      args: [],
    );
  }

  /// `Введите никнейм`
  String get enterNickname {
    return Intl.message(
      'Введите никнейм',
      name: 'enterNickname',
      desc: '',
      args: [],
    );
  }

  /// `Дата рождения`
  String get birthDay {
    return Intl.message(
      'Дата рождения',
      name: 'birthDay',
      desc: '',
      args: [],
    );
  }

  /// `Выберите дату`
  String get selectDate {
    return Intl.message(
      'Выберите дату',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Ваш пол`
  String get gender {
    return Intl.message(
      'Ваш пол',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `мужской`
  String get male {
    return Intl.message(
      'мужской',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `женский`
  String get female {
    return Intl.message(
      'женский',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Продолжить`
  String get contin {
    return Intl.message(
      'Продолжить',
      name: 'contin',
      desc: '',
      args: [],
    );
  }

  /// `Фото профиля`
  String get profilePhoto {
    return Intl.message(
      'Фото профиля',
      name: 'profilePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Добавьте вашу фотографию для завершения регистрации`
  String get addPhotoDescription {
    return Intl.message(
      'Добавьте вашу фотографию для завершения регистрации',
      name: 'addPhotoDescription',
      desc: '',
      args: [],
    );
  }

  /// `Завершите регистрацию`
  String get finishRegistr {
    return Intl.message(
      'Завершите регистрацию',
      name: 'finishRegistr',
      desc: '',
      args: [],
    );
  }

  /// `Изменить фото`
  String get changePhoto {
    return Intl.message(
      'Изменить фото',
      name: 'changePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Фото`
  String get photo {
    return Intl.message(
      'Фото',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get cancel {
    return Intl.message(
      'Отмена',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Отменить`
  String get cencelSecond {
    return Intl.message(
      'Отменить',
      name: 'cencelSecond',
      desc: '',
      args: [],
    );
  }

  /// `Опубликовать`
  String get publish {
    return Intl.message(
      'Опубликовать',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `Имя`
  String get firstName {
    return Intl.message(
      'Имя',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Введите имя`
  String get enterFirstName {
    return Intl.message(
      'Введите имя',
      name: 'enterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Фамилия`
  String get lastName {
    return Intl.message(
      'Фамилия',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Введите фамилию`
  String get enterLastName {
    return Intl.message(
      'Введите фамилию',
      name: 'enterLastName',
      desc: '',
      args: [],
    );
  }

  /// `О себе`
  String get bio {
    return Intl.message(
      'О себе',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Введите информацию о себе`
  String get enterBio {
    return Intl.message(
      'Введите информацию о себе',
      name: 'enterBio',
      desc: '',
      args: [],
    );
  }

  /// `Подписаться`
  String get subscribe {
    return Intl.message(
      'Подписаться',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Постов`
  String get countPost {
    return Intl.message(
      'Постов',
      name: 'countPost',
      desc: '',
      args: [],
    );
  }

  /// `Подписчиков`
  String get countSubscribers {
    return Intl.message(
      'Подписчиков',
      name: 'countSubscribers',
      desc: '',
      args: [],
    );
  }

  /// `Подписок`
  String get countSubscription {
    return Intl.message(
      'Подписок',
      name: 'countSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Галерея`
  String get gallery {
    return Intl.message(
      'Галерея',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Редактировать профиль`
  String get editProfile {
    return Intl.message(
      'Редактировать профиль',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Ваша галерея пуста.`
  String get emptyGallery {
    return Intl.message(
      'Ваша галерея пуста.',
      name: 'emptyGallery',
      desc: '',
      args: [],
    );
  }

  /// `Добавьте фото`
  String get addPhoto {
    return Intl.message(
      'Добавьте фото',
      name: 'addPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Подписки`
  String get subscriptions {
    return Intl.message(
      'Подписки',
      name: 'subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Рекомендации`
  String get recommendations {
    return Intl.message(
      'Рекомендации',
      name: 'recommendations',
      desc: '',
      args: [],
    );
  }

  /// `Комментарии`
  String get comments {
    return Intl.message(
      'Комментарии',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `и еще {count} комментария`
  String andMoreComments(Object count) {
    return Intl.message(
      'и еще $count комментария',
      name: 'andMoreComments',
      desc: '',
      args: [count],
    );
  }

  /// `и еще {count} комментарий`
  String andMoreComment(Object count) {
    return Intl.message(
      'и еще $count комментарий',
      name: 'andMoreComment',
      desc: '',
      args: [count],
    );
  }

  /// `Напишите комментарий`
  String get enterComment {
    return Intl.message(
      'Напишите комментарий',
      name: 'enterComment',
      desc: '',
      args: [],
    );
  }

  /// `Пожаловаться`
  String get complaint {
    return Intl.message(
      'Пожаловаться',
      name: 'complaint',
      desc: '',
      args: [],
    );
  }

  /// `Заблокировать`
  String get block {
    return Intl.message(
      'Заблокировать',
      name: 'block',
      desc: '',
      args: [],
    );
  }

  /// `Готово`
  String get done {
    return Intl.message(
      'Готово',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Пожалуйста сообщите нам почему вы хотите пожаловаться на эту публикацию`
  String get descriptionOfReport {
    return Intl.message(
      'Пожалуйста сообщите нам почему вы хотите пожаловаться на эту публикацию',
      name: 'descriptionOfReport',
      desc: '',
      args: [],
    );
  }

  /// `Спам`
  String get spam {
    return Intl.message(
      'Спам',
      name: 'spam',
      desc: '',
      args: [],
    );
  }

  /// `Мошенничество`
  String get fraud {
    return Intl.message(
      'Мошенничество',
      name: 'fraud',
      desc: '',
      args: [],
    );
  }

  /// `Откровенные изображения`
  String get frankImages {
    return Intl.message(
      'Откровенные изображения',
      name: 'frankImages',
      desc: '',
      args: [],
    );
  }

  /// `Нарушение авторских прав`
  String get copyrightInfringement {
    return Intl.message(
      'Нарушение авторских прав',
      name: 'copyrightInfringement',
      desc: '',
      args: [],
    );
  }

  /// `Другое`
  String get other {
    return Intl.message(
      'Другое',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Вы можете оставить комментарий`
  String get addComment {
    return Intl.message(
      'Вы можете оставить комментарий',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `Введите ваш комментарий`
  String get enterYourComment {
    return Intl.message(
      'Введите ваш комментарий',
      name: 'enterYourComment',
      desc: '',
      args: [],
    );
  }

  /// `Отписаться`
  String get unsubscribe {
    return Intl.message(
      'Отписаться',
      name: 'unsubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get settings {
    return Intl.message(
      'Настройки',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Сменить пароль`
  String get changePass {
    return Intl.message(
      'Сменить пароль',
      name: 'changePass',
      desc: '',
      args: [],
    );
  }

  /// `Подтвердить аккаунт`
  String get confirmAcc {
    return Intl.message(
      'Подтвердить аккаунт',
      name: 'confirmAcc',
      desc: '',
      args: [],
    );
  }

  /// `Написать в техподдержку`
  String get writeSupport {
    return Intl.message(
      'Написать в техподдержку',
      name: 'writeSupport',
      desc: '',
      args: [],
    );
  }

  /// `Выйти`
  String get logout {
    return Intl.message(
      'Выйти',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Для обновления пароля введите свой текущий пароль`
  String get newPasswordDescription {
    return Intl.message(
      'Для обновления пароля введите свой текущий пароль',
      name: 'newPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Текущий пароль`
  String get currentPassword {
    return Intl.message(
      'Текущий пароль',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Новый пароль`
  String get newPassword {
    return Intl.message(
      'Новый пароль',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Повторите новый пароль`
  String get repeatNewPassword {
    return Intl.message(
      'Повторите новый пароль',
      name: 'repeatNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Для подтверждения аккаунта заполните поля`
  String get confirmAccDescription {
    return Intl.message(
      'Для подтверждения аккаунта заполните поля',
      name: 'confirmAccDescription',
      desc: '',
      args: [],
    );
  }

  /// `Прикрепите фото удостоверения личности`
  String get addPhotoIdCard {
    return Intl.message(
      'Прикрепите фото удостоверения личности',
      name: 'addPhotoIdCard',
      desc: '',
      args: [],
    );
  }

  /// `Файл выбран`
  String get fileIsSelected {
    return Intl.message(
      'Файл выбран',
      name: 'fileIsSelected',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать файл`
  String get selectFile {
    return Intl.message(
      'Выбрать файл',
      name: 'selectFile',
      desc: '',
      args: [],
    );
  }

  /// `Удалить файл`
  String get deleteFile {
    return Intl.message(
      'Удалить файл',
      name: 'deleteFile',
      desc: '',
      args: [],
    );
  }

  /// `Изменить фото профилья`
  String get changeAvatar {
    return Intl.message(
      'Изменить фото профилья',
      name: 'changeAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Редактировать профиль`
  String get changeProfile {
    return Intl.message(
      'Редактировать профиль',
      name: 'changeProfile',
      desc: '',
      args: [],
    );
  }

  /// `Ссылка`
  String get link {
    return Intl.message(
      'Ссылка',
      name: 'link',
      desc: '',
      args: [],
    );
  }

  /// `Написать в техподдержку`
  String get textToSupport {
    return Intl.message(
      'Написать в техподдержку',
      name: 'textToSupport',
      desc: '',
      args: [],
    );
  }

  /// `Напишите обращение`
  String get writeAppeal {
    return Intl.message(
      'Напишите обращение',
      name: 'writeAppeal',
      desc: '',
      args: [],
    );
  }

  /// `Отправить`
  String get send {
    return Intl.message(
      'Отправить',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Сообщения`
  String get messages {
    return Intl.message(
      'Сообщения',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Подписывайтесь на пользователей и начинайте общение`
  String get subscribeToUsers {
    return Intl.message(
      'Подписывайтесь на пользователей и начинайте общение',
      name: 'subscribeToUsers',
      desc: '',
      args: [],
    );
  }

  /// `Введите сообщение`
  String get enterMessage {
    return Intl.message(
      'Введите сообщение',
      name: 'enterMessage',
      desc: '',
      args: [],
    );
  }

  /// `Начните общение с {user}`
  String startMeet(Object user) {
    return Intl.message(
      'Начните общение с $user',
      name: 'startMeet',
      desc: '',
      args: [user],
    );
  }

  /// `Уведомления`
  String get notifications {
    return Intl.message(
      'Уведомления',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Новые: {count}`
  String newNotifications(Object count) {
    return Intl.message(
      'Новые: $count',
      name: 'newNotifications',
      desc: '',
      args: [count],
    );
  }

  /// `Просмотренные`
  String get viewed {
    return Intl.message(
      'Просмотренные',
      name: 'viewed',
      desc: '',
      args: [],
    );
  }

  /// `понравилась ваша публикация`
  String get likedYourPost {
    return Intl.message(
      'понравилась ваша публикация',
      name: 'likedYourPost',
      desc: '',
      args: [],
    );
  }

  /// `прокомментировал(-а): {payload}`
  String commented(Object payload) {
    return Intl.message(
      'прокомментировал(-а): $payload',
      name: 'commented',
      desc: '',
      args: [payload],
    );
  }

  /// `Подписался(-acь) на ваши обновления`
  String get subscribeToYou {
    return Intl.message(
      'Подписался(-acь) на ваши обновления',
      name: 'subscribeToYou',
      desc: '',
      args: [],
    );
  }

  /// `Нет новых уведомлений`
  String get newCommentisEmpty {
    return Intl.message(
      'Нет новых уведомлений',
      name: 'newCommentisEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Нет просмотренных уведомлений`
  String get notViewed {
    return Intl.message(
      'Нет просмотренных уведомлений',
      name: 'notViewed',
      desc: '',
      args: [],
    );
  }

  /// `Подписчики`
  String get followers {
    return Intl.message(
      'Подписчики',
      name: 'followers',
      desc: '',
      args: [],
    );
  }

  /// `Подписчики`
  String get following {
    return Intl.message(
      'Подписчики',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get deletePost {
    return Intl.message(
      'Удалить',
      name: 'deletePost',
      desc: '',
      args: [],
    );
  }

  /// `Добавление публикации`
  String get addPublish {
    return Intl.message(
      'Добавление публикации',
      name: 'addPublish',
      desc: '',
      args: [],
    );
  }

  /// `Удалить комментарий`
  String get deleteCommetn {
    return Intl.message(
      'Удалить комментарий',
      name: 'deleteCommetn',
      desc: '',
      args: [],
    );
  }

  /// `Галлерея пользователя пуста.`
  String get emptyUserGallery {
    return Intl.message(
      'Галлерея пользователя пуста.',
      name: 'emptyUserGallery',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localized> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Localized> load(Locale locale) => Localized.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
