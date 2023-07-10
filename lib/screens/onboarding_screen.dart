import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _Loader());
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      "Consultando el clima...",
      "Un grande nubarrón se hace en el cielo \n Ya se aproxima una fuerte tormenta! ♪♫♪♫♪♫ ",
      "Calculando el clima con algoritmos a prueba de lluvia...",
      "Estamos barriendo las nubes para darte el pronóstico más preciso.",
      ""
    ];
    return Stream.periodic(
      const Duration(milliseconds: 1500),
      (step) {
        Future.delayed(const Duration(milliseconds: 300));
        return messages[step];
      },
    ); // .take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30 * 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            height: height,
            width: double.infinity,
            image: const AssetImage("assets/c.png"),
            fit: BoxFit.fill,
          ),
          SizedBox.expand(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        stops: const [0, 0.33, 0.66],
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent.withOpacity(0.1),
                          Colors.transparent,
                          Colors.transparent
                        ]))),
          ),
          Positioned(
            bottom: height * 0.7,
            child: FadeInRight(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 1000),
              child: Text(
                "¡Bienvenido a tu App del clima!",
                style: titleStyle,
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.35,
            child: const CircularProgressIndicator(
              strokeWidth: 4,
            ),
          ),
          Positioned(
            bottom: height * 0.28,
            child: StreamBuilder(
              stream: getLoadingMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  Text("Cargando ...", style: captionStyle);
                }
                return Text(
                  snapshot.data ?? "Cargando ...",
                  style: captionStyle,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
