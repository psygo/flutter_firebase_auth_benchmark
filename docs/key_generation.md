# Key Generation with `keytool`

> From [this SO answer](https://stackoverflow.com/a/7201252/4756173).

Simply enter these into Windows command prompt. Don't forget to replace `userName` with your actual user name.

```cmd
cd C:\Program Files\Java\jdk1.7.0_09\bin

keytool -exportcert -alias androiddebugkey -keystore "C:\Users\userName\.android\debug.keystore" -list -v
```

The base password is `android`.

You will be presented with the `MD5`, `SHA1`, and `SHA256` keys; Choose the one you need. 