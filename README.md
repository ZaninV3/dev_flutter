# Разработка приложений на Flutter
## Порядок установки Flutter
Поскольку **Flutter** - фреймворк для ЯП **Dart**, то перед установкой первого необходимо установить **Dart**. Дальнейшая установка предполагает, что у вас уже установлен **Visual Studio Code**.

1) Установка менеджера пакетов **Chocolatey**
    - Запускаем **PowerShell** от имени администратора.
    - Выполняем команду `Get-ExecutionPolicy`. Если вывелось не `Bypass`, то выполняем следующие 3 команды (Они могут потребовать выбора действий. Выбираем `Y` или `A`):
      - `Set-ExecutionPolicy AllSigned`;
      - `Set-ExecutionPolicy Bypass -Scope Process`;
      - `Get-ExecutionPolicy`.
    - Выполняем команду `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`.
2) Установка **Dart SDK**.

   В том же **PowerShell** выполняем `choco install dart-sdk`. После установки **PowerShell** больше не понадобится.

4) Установка плагина **Dart** для **VS Code**
   
    В панели расширений (Комбинация клавиш `Ctrl` + `Shift` + `X`) ищем и устанавливаем расширение **Dart**. После установки перезапускаем **VS Code**

5) Установка **Flutter SDK**

    Переходим по [ссылке](https://docs.flutter.dev/get-started/install/windows/mobile) для скачивания `.zip` архива. Разархивируем в удобное для вас место (для удобства я установил в `C:/tools`).

6) Изменение переменной среды

   Изменяем переменную **Path** с добавлением адреса до папки из прошлого пункта. Обязательно до папки `bin`! В моем случае путь выглядит так: `C:/tools/flutter/bin`.

7) Установка плагина **Flutter** в **VS Code**
   
   Все в полной аналогии как для **Dart**. После перезапуска переходим в **Параметры** (`Ctrl` + `,`) и ищем пункт ***Dart: Flutter Sdk Path***. Редактируем `settings.json`, добавив к параметру `"dart.flutterSdkPath"` путь до папки **Flutter** (уже без `bin`).

Источники:
* https://codelab.pro/nastrojka-razrabotki-dart-v-visual-studio-code/
* https://codelab.pro/kak-ustanovit-flutter-v-vs-code-poshagovoe-rukovodstvo/
* https://ru.wikipedia.org/wiki/Flutter
