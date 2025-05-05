# Установка на Manjaro XFCE

```bash
sudo pacman -S paru  # На pacman почему-то нет flutter
sudo paru -S flutter
flutter --version  # чтобы убедиться в правильности установки
```

Результат последней команды будет примерно следующий:

```bash
Flutter 3.29.3 • channel  • https://github.com/flutter/flutter.git
Framework • revision archlinuxa (unknown (arch linux aur package)) • 2038-01-19 03:14:08
Engine • revision cf56914b32
Tools • Dart 3.7.0 • DevTools 2.42.2
```

Предполагается, что **VS Code** установлен. В списке расширений установите **Flutter** и **Dart**. Более подробно про поиск расширений рассказано в [README.md](https://github.com/ZaninV3/dev_flutter/blob/main/README.md).

Откройте палитру команд `Ctrl+Shift+P` и введите `Flutter: Run Flutter Doctor` чтобы убедиться, что все хорошо.

Если нет, то проверьте путь до **Flutter SDK** в настройках **VS Code** (аналогично в настройках параметр **Flutter SDK Path**). Убедитесь, что ключ `dart.flutterSdkPath` не `null` (я указал `~/flutter`).

Проверьте окружение. Выполните `flutter doctor` и проверьте чего не хватает.
