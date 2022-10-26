# Flutter-Lyra-Platform-Interface

---

A common platform interface for the `flutter_lyra` plugin.

This interface allows platform-specific implementations of the `flutter_lyra` plugin, as well as the plugin itself, to ensure they are supporting the same interface.

---

# Usage

To implement a new platform-specific implementation of `flutter_lyra`, extend `FlutterLyraPlatform` with an implementation that performs the platform-specific behavior.
