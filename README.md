# YouDo - A Flutter app which helps you keep track of your work/life-balance aswell as your daily tasks
![alt text](https://i.imgur.com/XlHKggB.png)

## YouDo also supports dark mode!
![alt_text](https://i.imgur.com/DnCrOHf.png)

## What is YouDo?

YouDo is a multiplatform Flutter App for keeping track of your daily tasks as well as which areas of your life you are currently paying the most attention on.

All data used is processed locally on the device and no communication with an external server is needed.

## Development environment setup

To run and edit this project you need to install Flutter aswell as the Flutter plugin for your used IDE.

## Building the project

To build the project first run following commands inside the projects folder:

```
flutter clean
```

```
flutter pub get
```

```
flutter run --release
```

### Known issues

Due to an issue with the AnimatedListState this app currently only runs in release mode, once started in debug mode flutter will throw an internal error when you try to add a new task.
