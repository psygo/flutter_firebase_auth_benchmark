# Flutter Firebase Authentication Benchmark

A benchmark for Authentication through Firebase in Flutter.

Heavily inspired by the [`flutter_login`](https://pub.dev/packages/flutter_login) package, by Near Huscarl. Even though it is not as pretty or so intensely parameterized, the overall structure of the code is much more simple and accessible &mdash; in part, this is due to using `AnimatedSwitcher` and `Visibility` widgets to handle animations, instead of customized raw animations.

## Tests

The test `utils.dart` file features some very handy functions and classes that I spent a lot of time trying to make work. Some of the notable mentions are:

- How to extract widget states and `StatelessWidget`s from the `WidgetTester`.
    - Inspired by [`stateful_components_test.dart`](https://github.com/flutter/flutter/blob/77fb28b3da19dcf2b718ce963a23c2e4917c55f0/packages/flutter/test/widgets/stateful_components_test.dart#L47-L62), inside the [`flutter/flutter` repo](https://github.com/flutter/flutter).
- How to test rendered text from the `WidgetTester`.
    - Directly from [`text_field_test.dart`](https://github.com/flutter/flutter/blob/714d579839cc306b88288e4f25dbee74bf3a4f5d/packages/flutter/test/material/text_field_test.dart#L145-L160), inside the [`flutter/flutter` repo](https://github.com/flutter/flutter).

### Email and Password Validation

Email and Password Validation were both accomplished through the use of *regular expressions*.

- Email Validation uses [this regex](https://stackoverflow.com/a/16800541/4756173).
- Password Validation uses [this regex](https://stackoverflow.com/a/21456918/4756173).
    - Minimum eight characters
    - At least one uppercase letter
    - One lowercase letter
    - One number
    - One special character