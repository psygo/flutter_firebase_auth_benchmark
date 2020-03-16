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