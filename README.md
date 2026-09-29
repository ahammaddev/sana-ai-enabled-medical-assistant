# Sana — AI-enabled Medical Assistant

Sana is a Flutter app for quick, informational medical consultations. Describe
symptoms or ask about medications, and Sana replies using the Ahammad
Intelligence backend. Consultations are stored locally on the device.

> For informational purposes only. Always consult a doctor for emergencies.

## Features

- **Welcome screen** — always the start screen; opens the consultation history (back returns here) or a quick consultation.
- **Consultation history** — search, pull-to-refresh, swipe to delete, clear all.
- **Chat** — suggested topics, copyable replies, retry on failed replies,
  offline detection before sending.
- **Local storage** — conversations and messages persisted with `sqflite`.

## Stack

| Concern          | Package                          |
| ---------------- | -------------------------------- |
| State / DI / nav | `get` (GetX)                     |
| Networking       | `http`                           |
| Persistence      | `sqflite`, `path`                |
| Connectivity     | `connectivity_plus`              |
| UI               | `google_fonts`, `font_awesome_flutter`, `intl` |

## Project layout

```
lib/
  main.dart
  app/
    data/
      models/        MessageModel, ConsultationModel
      providers/     BaseProvider (HTTP)
      repository/    ChatRepository (API), AppDatabase (sqflite)
    modules/         GetX modules: bindings / controllers / views
      welcome/  chat_list/  chat/  global/
    utils/
      constants/     colors, themes, config, helpers
      routes/        AppPages / Routes
```

## Getting started

```sh
flutter pub get
flutter run
flutter test
```

The chat endpoint and token live in `lib/app/utils/constants/config/app_urls.dart`.
