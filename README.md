# Flutter Firebase Authentication Benchmark

> **This was an interesting experiment but isn't really going to be scalable or easily turned into a package. What I'm going to do is turn it into a package from scratch, focusing on the Flutter native `StreamBuilder` and `rxdart` observables and Dart `Streams` to manage the state of multiple widgets when necessary, instead of using Provider or other high-level packages. This repo will still be up as a learning experience for others.**

A benchmark for Authentication through Firebase in Flutter.

Heavily inspired design by the [`flutter_login`](https://pub.dev/packages/flutter_login) package, by Near Huscarl. Even though it is not as pretty or so intensely parameterized, the overall structure of the code is much more simple and accessible &mdash; in part, this is due to using `AnimatedSwitcher` and `Visibility` widgets to handle animations, instead of customized raw animations.

## Firebase

Firebase is enabled, however, for security reasons, I chose to omit the `json` settings files. They are listed inside the `.gitignore` file.

More info can be found in the `docs/` folder.

## Tests

I chose to create a *real* Firebase server for the tests<sup>*</sup>. So, instead of mocking the Firebase instance, you will find tests which make real requests, thus, needing to use Flutter Driver.

The test `utils.dart` file features some very handy functions and classes that I spent a lot of time trying to make work. Some of the notable mentions are:

- How to extract widget states and `StatelessWidget`s from the `WidgetTester`.
    - Inspired by [`stateful_components_test.dart`](https://github.com/flutter/flutter/blob/77fb28b3da19dcf2b718ce963a23c2e4917c55f0/packages/flutter/test/widgets/stateful_components_test.dart#L47-L62), inside the [`flutter/flutter` repo](https://github.com/flutter/flutter).
- How to test rendered text from the `WidgetTester`.
    - Directly from [`text_field_test.dart`](https://github.com/flutter/flutter/blob/714d579839cc306b88288e4f25dbee74bf3a4f5d/packages/flutter/test/material/text_field_test.dart#L145-L160), inside the [`flutter/flutter` repo](https://github.com/flutter/flutter).

<hr>

<sup><sup>*</sup> Basically because I haven't been able to find a trustworthy package for the mocks, and haven't found the patience to implement one myself either. The closest I have been able to a reliable mock is in the [`firebase_auth`](https://pub.dev/packages/firebase_auth) package itself. Check out [`firebase_auth_test.dart`](https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_auth/firebase_auth/test/firebase_auth_test.dart).</sup>

### Email and Password Validation

Email and Password Validation were both accomplished through the use of *regular expressions*.

- Email Validation uses [this regex](https://stackoverflow.com/a/16800541/4756173).
- Password Validation uses [this regex](https://stackoverflow.com/a/21456918/4756173). And the error messages appear in this order:
    1. Minimum eight characters
    1. At least one uppercase letter
    1. One lowercase letter
    1. One number
    1. One special character

## Problems

### Architecture

My architecture sucks and yours is amazing, I know, I know.

But if it ain't broken, don't fix it. So I'm not going to remake everything unless there's huge benefit to it.

One of the biggest problems, besides the one with `labelText` and Provider, is the fact that most of what's in my validator is basically featured inside `firebase_auth`'s API anyway. Ditching out my validator could really reduce a lot of my code's complexity. But I didn't know that beforehand.

### The `TextFormField` Problem

Unfortunately, the source's `TextFormField` doesn't allow us to disable the `errorText`, which, in my case, can mess up the design quite badly, since I chose to present the errors in the `labelText`. However, there seems to be a more or less easy way of fixing this if we add a parameter to the original `TextFormField`, which is what I did. You can find out more about it in [this SO answer](https://stackoverflow.com/a/60695612/4756173) (or in Issue [#52634](https://github.com/flutter/flutter/issues/52634)).

### The `errorText` on `labelText` and Provider's `notifyListeners()` Problem

Since my architecture has the initial `Form` changing because of the internal `AnimatedSwitcher`, I think that the Provider's `notifyListeners()` and the `formKey.currentState.save()` could happen concurrently.

I couldn't find a clean solution solution to that, so I "fixed" it by delaying the saving with &mdash; inside `login_workflow_provider.dart` &mdash;:

```dart
Future<void> save() async =>
    await Future.delayed(Duration(milliseconds: 100), () {
      _formKey.currentState.save();
    });
```

More info about this problem can be found in Issue #31 or in [this StackOverflow question](https://stackoverflow.com/q/60764218/4756173).