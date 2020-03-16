# Build Errors

## MultiDex

Past a certain number of methods, a single dex file won't be able to handle your app. This will probably happen after you include Firestore functionality in your app.

To fix it, include the following in your `android/app/build.gradle` file:

1. Enable MultiDex:
    ```gradle
    defaultConfig {
        ...
        multiDexEnabled true
    }
    ```
1. Implement it in the background:
    ```gradle
    dependencies {
        ...
        implementation 'com.android.support:multidex:1.0.3'
    }
    ```

For more information, check out:

- [@julianfalcionelli's comment on a Github issue](https://github.com/flutter/flutter/issues/28770#issuecomment-499432909)
- [A related SO answer](https://stackoverflow.com/a/27284064/4756173)

## Skia Shader Compilation Errors

You might encounter some errors like this in the `Debug Console` when building the app with an emulator:

```none
D/skia    (21392): Shader compilation error
D/skia    (21392): ------------------------
D/skia    (21392): Errors:
```

However, the app will still work fine.

This happens because `skia` is not working 100% properly with the hardware acceleration capabilities of the emulation process apparently.

You can get rid of all of these errors by running `flutter run --enable-software-rendering`, which will, in turn, diminish the emulator's performance though. Alternatively, resetting your emulator's data completing (wiping out everything) might also solve the problem.

## Spans Cannot Have a Zero Length (Warning)

> For more info, check out [this SO answer](https://stackoverflow.com/a/56621852/4756173).

~~Apparently, having a `FormKey` demands that all related nested widgets be stateful.~~