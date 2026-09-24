# Flutter-Lyra

## Installation

### Android

Prerequisites:

- In your `android/app/build.gradle.kts`, set your `minSdk` to at least 24:

  ```kotlin
  defaultConfig {
      // others configs
      minSdk = 24
  }
  ```

- Your `MainActivity` must inherit from `FlutterFragmentActivity`. Update your
  `MainActivity.kt`:

  ```kotlin
  import io.flutter.embedding.android.FlutterFragmentActivity

  class MainActivity : FlutterFragmentActivity()
  ```

- Use a theme that inherits from a Material theme for the Android theme to apply
  to the `FlutterFragmentActivity` as soon as the Android process has started.

  For example, in your `android/app/src/main/res/values/styles.xml`:

  ```xml
  <!-- Theme applied to the Android Window as soon as the process has started.
       This theme determines the color of the Android Window while your
       Flutter UI initializes, as well as behind your Flutter UI while its
       running. -->
  <style name="NormalTheme" parent="@style/Theme.Material3.Light.NoActionBar">
      <!-- Or any other material theme that you want -->
      <item name="android:windowBackground">?android:colorBackground</item>
  </style>
  ```

  Don't forget to change it as well in your
  `android/app/src/main/res/values-night/styles.xml` if you need to.

### iOS

Prerequisites:

- Set your iOS deployment target to at least 15.1: in Xcode, select the `Runner`
  target and update **Minimum Deployments** in the **General** tab.

The plugin supports both Swift Package Manager and CocoaPods. If your app still
uses CocoaPods, also update the platform in your `ios/Podfile`:

```rb
platform :ios, '15.1'
```

## About Lyra

This sdk is the flutter interface implementation of the
[android](https://github.com/lyra/android-sdk) and
[ios](https://github.com/lyra/ios-sdk) sdks of Lyra

If you want more informations about Lyra, here is their
[website](https://payzen.io/fr-FR/)

## 👉 About Theodo

This package is maintained by [Theodo](https://theodo.com), designing and
developing multiplatform applications with Flutter, React Native, Compose
Multiplatform and Android/iOS native. To get more information on the solutions
that would suit your needs, feel free to get in touch through our
[contact form](https://www.theodo.com/en-uk/contact)!

We will always answer you with pleasure 😁
