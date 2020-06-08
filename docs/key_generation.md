# Key Generation with `keytool`

> A helpful answer: [this SO answer](https://stackoverflow.com/a/7201252/4756173).

```cmd
cd C:\Program Files (x86)\Java\jdk1.8.0_231\bin

keytool -exportcert -alias androiddebugkey -keystore "C:\Users\%USERNAME%\.android\debug.keystore" -list -v
```

The default password is `android`.

You will be presented with the `MD5`, `SHA1`, and `SHA256` keys; choose the one you need.

## Base 64 (Facebook)

For obtaining the base 64 version of the key, which is used by Facebook Login:

```cmd
keytool -exportcert -alias androiddebugkey -keystore "C:\Users\%USERNAME%\.android\debug.keystore" | "C:\Users\%USERNAME%\Documents\programs\openssl\bin\openssl" sha1 -binary | "C:\Users\%USERNAME%\Documents\programs\openssl\bin\openssl" base64
```

The openSSL package can be found in [Google's Archive](https://code.google.com/archive/p/openssl-for-windows/downloads).