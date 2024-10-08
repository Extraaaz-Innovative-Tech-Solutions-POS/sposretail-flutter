import 'package:spos_retail/views/widgets/export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    settingsController.checkToken();
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: bgImageDecor,
        child: Center(
            child: Lottie.asset('assets/Animation/splashScreen.json',
                repeat: false)
                ),
      ),
    );
  }
}