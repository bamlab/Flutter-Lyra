```dart

void main() => runApp(const MyExampleApp());

class MyExampleApp extends StatelessWidget {
  const MyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReachFive>(
      future: LyraManager().initialize(
        publicKey: "publicKey",
        options: LyraInitializeOptions(
          apiServerName: "apiServerName",
          nfcEnabled: true,
          cardScanningEnabled: false,
        ),
      ),
      builder: (context, snapshot) {
        final lyra = snapshot.data;
        if (lyra != null) {
          // You can use your lyra method here
          // Here is an example with getFormTokenVersion
          // Check the others methods in the doc or in the example repo
          return Column(
            children: [
              ElevatedButton(
                onPressed: () async => lyra.getFormTokenVersion(),
                child: const Text('Get Form Token Version'),
              )
            ],
          );
        }

        if (snapshot.hasError) {
          return const Text('handle your initialization error here');
        }

        return const Text('Loading');
      },
    );
  }
}
```
