# 💰 Flutter Expense Tracker

A clean and intuitive expense tracking application built with **Flutter** and **Material Design 3**. Track your daily expenses across multiple categories, visualize spending patterns with an interactive bar chart, and manage your finances with ease.

---

## ✨ Features

- **Add Expenses** — Log expenses with a title, amount, date, and category via a sleek modal bottom sheet.
- **Category Support** — Organize expenses into four categories: 🍔 Food, ✈️ Travel, 🎬 Leisure, and 💼 Work.
- **Interactive Chart** — Visualize spending distribution across categories with a dynamic bar chart.
- **Swipe to Delete** — Remove expenses effortlessly with a swipe gesture (Dismissible).
- **Undo Delete** — Accidentally deleted an expense? Undo it instantly via a SnackBar action.
- **Date Picker** — Select expense dates using Flutter's built-in date picker.
- **Input Validation** — Ensures all fields are filled correctly before saving, with platform-aware alert dialogs (Cupertino on iOS, Material on Android).
- **Dark Mode Support** — Seamless light and dark theme support that follows the system preference.
- **Responsive Layout** — Adapts between portrait (column) and landscape (row) layouts based on screen width.
- **Material Design 3** — Modern UI with seed-based color schemes and consistent theming.

---

## 📸 Screenshots

<!-- Add your screenshots here -->
<!-- ![Light Mode](screenshots/light_mode.png) -->
<!-- ![Dark Mode](screenshots/dark_mode.png) -->

---

## 🏗️ Project Structure

```
lib/
├── main.dart                          # App entry point, theme configuration
├── model/
│   └── expense.dart                   # Expense & ExpenseBucket data models
└── widget/
    ├── expenses.dart                  # Main screen with expense list & chart
    ├── new_expense.dart               # Modal form to add a new expense
    ├── chart/
    │   ├── chart.dart                 # Bar chart displaying category totals
    │   └── chart_bar.dart             # Individual bar in the chart
    └── expense_list/
        ├── expenses_list.dart         # Scrollable list of expenses (ListView)
        └── expense_item.dart          # Card widget for a single expense
```

---

## 🧩 Architecture Overview

| Layer       | Description                                                                 |
|-------------|-----------------------------------------------------------------------------|
| **Model**   | `Expense` — holds title, amount, date, category, and a UUID-based id.       |
|             | `ExpenseBucket` — groups expenses by category and computes totals.          |
| **Widget**  | `Expenses` — stateful root widget managing the expense list and user actions. |
|             | `NewExpense` — stateful form with text controllers, date picker, and dropdown. |
|             | `Chart` / `ChartBar` — stateless widgets rendering category-based bar chart. |
|             | `ExpensesList` / `ExpenseItem` — stateless widgets for the scrollable list. |

---

## 📦 Dependencies

| Package                  | Version   | Purpose                          |
|--------------------------|-----------|----------------------------------|
| `flutter`                | SDK       | Core framework                   |
| `cupertino_icons`        | ^1.0.8    | iOS-style icons                  |
| `uuid`                   | ^4.5.3    | Unique ID generation for expenses|
| `intl`                   | ^0.20.3   | Date formatting                  |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Dart SDK ^3.12.2)
- Android Studio / VS Code with Flutter extensions
- An emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/soumenmaity3/flutter_expense_tracker.git
   cd flutter_expense_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## 🎨 Theming

The app uses **Material 3** seed-based color schemes:

| Mode  | Seed Color                        |
|-------|-----------------------------------|
| Light | `Color.fromARGB(255, 96, 59, 181)` (purple) |
| Dark  | `Color.fromARGB(255, 5, 99, 125)` (teal)    |

Theme mode is set to `ThemeMode.system`, automatically adapting to the device's light/dark setting.

---

## 🛠️ Built With

- [Flutter](https://flutter.dev/) — UI toolkit for cross-platform apps
- [Dart](https://dart.dev/) — Programming language
- [Material Design 3](https://m3.material.io/) — Design system

---

## 📄 License

This project is for educational purposes as part of a Flutter course.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to open an issue or submit a pull request.
