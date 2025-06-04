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

# Установка на Xubuntu

```bash
sudo snap install flutter --classic
flutter  # Скачивание происходит не сразу
flutter --version  # чтобы убедиться в правильности установки
```

Результат последней команды будет примерно следующий:

```bash
Flutter 3.32.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision b25305a883 (6 дней назад) • 2025-05-29 10:40:06 -0700
Engine • revision 1425e5e9ec (7 дней назад) • 2025-05-28 14:26:27 -0700
Tools • Dart 3.8.1 • DevTools 2.45.1
```

Исправьте возможные ошибки, которые обнаружит `flutter doctor`.

Возможные ошибки:

* Отсутствие **Android SDK**. Решается установкой `sudo apt install android-sdk`.
* Отсутствие командных инструментов.
```bash
sudo apt install openjdk-17-jdk
sudo apt install unzip  # Если нет

mkdir -p ~/Android/Sdk/cmdline-tools
cd ~/Android/Sdk/cmdline-tools
wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip
unzip commandlinetools-linux-*.zip
mv cmdline-tools latest  # папка должна называться latest !!!
echo 'export ANDROID_HOME="$HOME/Android/Sdk"' >> ~/.bashrc
echo 'export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"' >> ~/.bashrc
source ~/.bashrc
sdkmanager "platform-tools" "build-tools;34.0.0"
```
* Нет браузера.
```bash
echo 'export CHROME_EXECUTABLE="/usr/bin/chromium-browser"' >> ~/.bashrc  # Узнайте путь браузера `witch chromium-browser`  (Chromium для примера)
source ~/.bashrc
```
* Лицензионное соглашение не принято. `flutter doctor --android-licences`

Предполагается, что **VS Code** установлен (либо **VSCodium**). Установите расширения **Dart** и **Flutter**. Более подробно про поиск расширений рассказано в [README.md](https://github.com/ZaninV3/dev_flutter/blob/main/README.md).

Откройте палитру команд `Ctrl+Shift+P` и введите `Flutter: Run Flutter Doctor` чтобы убедиться, что все хорошо.

Если нет, то проверьте путь до **Flutter SDK** в настройках **VS Code** (аналогично в настройках параметр **Flutter SDK Path**). Убедитесь, что ключ `dart.flutterSdkPath` не `null` (Путь можно узнать через `flutter sdk-path`).
