# ✅ To-Do List App (Flutter + REST API)

**🔗 Live demo:** https://nainezz.github.io/todolist/ (the original API server is offline, so the demo shows the interface only)

A task manager built with **Flutter** that connects to a REST API. Users register, log in and manage their tasks. Every change is saved to the server and secured with a bearer token.

## Features

- **Registration and login** with full name, email, phone and password.
- **Persistent session.** The user and their token are stored with `get_storage`, so you stay logged in after closing the app.
- **Create tasks** from a dialog.
- **Mark tasks complete** with a checkbox. Completed tasks are shown crossed out.
- **Edit and delete tasks**, with a confirmation dialog before deleting.
- **Task details** showing when a task was created and last updated, as human-friendly times (`jiffy`).
- **Loading states** using `modal_progress_hud_nsn`, and error messages shown in snackbars.
- **Logout** from the side drawer.

## Tech stack

| | |
|---|---|
| Framework | Flutter (Dart, null-safe) |
| State management | Provider (`UserProvider`, `TodoProvider`) |
| Networking | `http` with REST and bearer-token auth |
| Local storage | `get_storage` |
| Dates | `jiffy` |

## API

The app uses the public [api-nodejs-todolist](https://api-nodejs-todolist.herokuapp.com) endpoints:

| Action | Method | Endpoint |
|---|---|---|
| Register | POST | `/user/register` |
| Login | POST | `/user/login` |
| List or create tasks | GET / POST | `/task` |
| Update or delete a task | PUT / DELETE | `/task/:id` |

> Note: this API was hosted on Heroku's free tier, which has since been discontinued, so the endpoints may no longer respond. To run the app, point it at your own compatible backend.

## Project structure

```
lib/
├── main.dart        # Providers and the auth check on start-up
├── models/          # UserModel, TodoModel
├── provider/        # user.dart (auth), todo.dart (CRUD)
└── screen/          # login, registration, home, complete (task detail)
```

## Getting started

```bash
git clone https://github.com/nainezz/todolist.git
cd todolist
flutter pub get
flutter run
```

Requires Dart `>=2.18.0 <3.0.0` (Flutter 3.3–3.7).

## Author

**Nainezz**, a software engineer in Nairobi, Kenya · [GitHub](https://github.com/nainezz)
