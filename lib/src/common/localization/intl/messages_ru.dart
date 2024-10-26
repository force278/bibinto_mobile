// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(count) => "и еще ${count} комментарий";

  static String m1(count) => "и еще ${count} комментария";

  static String m2(payload) => "прокомментировал(-а): ${payload}";

  static String m3(email) =>
      "На электронный адрес ${email} отправлено сообщение с кодом подтверждения. Введите код и нажмите подтвердить";

  static String m4(count) => "Новые: ${count}";

  static String m5(seconds) => "Отправить повторно через ${seconds} сек.";

  static String m6(user) => "Начните общение с ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addComment": MessageLookupByLibrary.simpleMessage(
            "Вы можете оставить комментарий"),
        "addPhoto": MessageLookupByLibrary.simpleMessage("Добавьте фото"),
        "addPhotoDescription": MessageLookupByLibrary.simpleMessage(
            "Добавьте вашу фотографию для завершения регистрации"),
        "addPhotoIdCard": MessageLookupByLibrary.simpleMessage(
            "Прикрепите фото удостоверения личности"),
        "addPublish":
            MessageLookupByLibrary.simpleMessage("Добавление публикации"),
        "andMoreComment": m0,
        "andMoreComments": m1,
        "basicInfo":
            MessageLookupByLibrary.simpleMessage("Основная информация"),
        "bio": MessageLookupByLibrary.simpleMessage("О себе"),
        "birthDay": MessageLookupByLibrary.simpleMessage("Дата рождения"),
        "block": MessageLookupByLibrary.simpleMessage("Заблокировать"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "cencelSecond": MessageLookupByLibrary.simpleMessage("Отменить"),
        "changeAvatar":
            MessageLookupByLibrary.simpleMessage("Изменить фото профилья"),
        "changePass": MessageLookupByLibrary.simpleMessage("Сменить пароль"),
        "changePhoto": MessageLookupByLibrary.simpleMessage("Изменить фото"),
        "changeProfile":
            MessageLookupByLibrary.simpleMessage("Редактировать профиль"),
        "codeConfirmation":
            MessageLookupByLibrary.simpleMessage("Подтверждение кода"),
        "commented": m2,
        "comments": MessageLookupByLibrary.simpleMessage("Комментарии"),
        "complaint": MessageLookupByLibrary.simpleMessage("Пожаловаться"),
        "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
        "confirmAcc":
            MessageLookupByLibrary.simpleMessage("Подтвердить аккаунт"),
        "confirmAccDescription": MessageLookupByLibrary.simpleMessage(
            "Для подтверждения аккаунта заполните поля"),
        "contin": MessageLookupByLibrary.simpleMessage("Продолжить"),
        "copyrightInfringement":
            MessageLookupByLibrary.simpleMessage("Нарушение авторских прав"),
        "countPost": MessageLookupByLibrary.simpleMessage("Постов"),
        "countSubscribers": MessageLookupByLibrary.simpleMessage("Подписчиков"),
        "countSubscription": MessageLookupByLibrary.simpleMessage("Подписок"),
        "createPassword":
            MessageLookupByLibrary.simpleMessage("Создание пароля"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Текущий пароль"),
        "deleteCommetn":
            MessageLookupByLibrary.simpleMessage("Удалить комментарий"),
        "deleteFile": MessageLookupByLibrary.simpleMessage("Удалить файл"),
        "deletePost": MessageLookupByLibrary.simpleMessage("Удалить"),
        "descForCodeConfirm": m3,
        "descForRegistration": MessageLookupByLibrary.simpleMessage(
            "Введите электронную почту на который мы отправим код для авторизации"),
        "descriptionOfReport": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста сообщите нам почему вы хотите пожаловаться на эту публикацию"),
        "done": MessageLookupByLibrary.simpleMessage("Готово"),
        "editProfile":
            MessageLookupByLibrary.simpleMessage("Редактировать профиль"),
        "email": MessageLookupByLibrary.simpleMessage("Электронная почта"),
        "emptyGallery":
            MessageLookupByLibrary.simpleMessage("Ваша галерея пуста."),
        "emptyUserGallery": MessageLookupByLibrary.simpleMessage(
            "Галлерея пользователя пуста."),
        "enterBio":
            MessageLookupByLibrary.simpleMessage("Введите информацию о себе"),
        "enterComment":
            MessageLookupByLibrary.simpleMessage("Напишите комментарий"),
        "enterFirstName": MessageLookupByLibrary.simpleMessage("Введите имя"),
        "enterLastName":
            MessageLookupByLibrary.simpleMessage("Введите фамилию"),
        "enterMessage":
            MessageLookupByLibrary.simpleMessage("Введите сообщение"),
        "enterNickname":
            MessageLookupByLibrary.simpleMessage("Введите никнейм"),
        "enterPassword": MessageLookupByLibrary.simpleMessage("Введите пароль"),
        "enterYourComment":
            MessageLookupByLibrary.simpleMessage("Введите ваш комментарий"),
        "entrance": MessageLookupByLibrary.simpleMessage("Вход"),
        "female": MessageLookupByLibrary.simpleMessage("женский"),
        "fileIsSelected": MessageLookupByLibrary.simpleMessage("Файл выбран"),
        "finishRegistr":
            MessageLookupByLibrary.simpleMessage("Завершите регистрацию"),
        "firstName": MessageLookupByLibrary.simpleMessage("Имя"),
        "followers": MessageLookupByLibrary.simpleMessage("Подписчики"),
        "following": MessageLookupByLibrary.simpleMessage("Подписчики"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
        "frankImages":
            MessageLookupByLibrary.simpleMessage("Откровенные изображения"),
        "fraud": MessageLookupByLibrary.simpleMessage("Мошенничество"),
        "gallery": MessageLookupByLibrary.simpleMessage("Галерея"),
        "gender": MessageLookupByLibrary.simpleMessage("Ваш пол"),
        "haveAccount":
            MessageLookupByLibrary.simpleMessage("Уже есть аккаунт?"),
        "lastName": MessageLookupByLibrary.simpleMessage("Фамилия"),
        "likedYourPost":
            MessageLookupByLibrary.simpleMessage("понравилась ваша публикация"),
        "link": MessageLookupByLibrary.simpleMessage("Ссылка"),
        "logIn": MessageLookupByLibrary.simpleMessage("Войти"),
        "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
        "male": MessageLookupByLibrary.simpleMessage("мужской"),
        "messages": MessageLookupByLibrary.simpleMessage("Сообщения"),
        "newCommentisEmpty":
            MessageLookupByLibrary.simpleMessage("Нет новых уведомлений"),
        "newNotifications": m4,
        "newPassword": MessageLookupByLibrary.simpleMessage("Новый пароль"),
        "newPasswordDescription": MessageLookupByLibrary.simpleMessage(
            "Для обновления пароля введите свой текущий пароль"),
        "nickName": MessageLookupByLibrary.simpleMessage("Никнейм"),
        "noAccount": MessageLookupByLibrary.simpleMessage("Нет аккаунта?"),
        "notViewed": MessageLookupByLibrary.simpleMessage(
            "Нет просмотренных уведомлений"),
        "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "other": MessageLookupByLibrary.simpleMessage("Другое"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "passwordForLogIn": MessageLookupByLibrary.simpleMessage(
            "Придумайте пароль для входа в аккаунт"),
        "photo": MessageLookupByLibrary.simpleMessage("Фото"),
        "profilePhoto": MessageLookupByLibrary.simpleMessage("Фото профиля"),
        "publish": MessageLookupByLibrary.simpleMessage("Опубликовать"),
        "recommendations": MessageLookupByLibrary.simpleMessage("Рекомендации"),
        "registration":
            MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "repeatNewPassword":
            MessageLookupByLibrary.simpleMessage("Повторите новый пароль"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Повторите пароль"),
        "selectDate": MessageLookupByLibrary.simpleMessage("Выберите дату"),
        "selectFile": MessageLookupByLibrary.simpleMessage("Выбрать файл"),
        "send": MessageLookupByLibrary.simpleMessage("Отправить"),
        "sendAgain": m5,
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "signUp": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "spam": MessageLookupByLibrary.simpleMessage("Спам"),
        "startMeet": m6,
        "subscribe": MessageLookupByLibrary.simpleMessage("Подписаться"),
        "subscribeToUsers": MessageLookupByLibrary.simpleMessage(
            "Подписывайтесь на пользователей и начинайте общение"),
        "subscribeToYou": MessageLookupByLibrary.simpleMessage(
            "Подписался(-acь) на ваши обновления"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Подписки"),
        "textToSupport":
            MessageLookupByLibrary.simpleMessage("Написать в техподдержку"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Отписаться"),
        "viewed": MessageLookupByLibrary.simpleMessage("Просмотренные"),
        "writeAppeal":
            MessageLookupByLibrary.simpleMessage("Напишите обращение"),
        "writeSupport":
            MessageLookupByLibrary.simpleMessage("Написать в техподдержку")
      };
}
