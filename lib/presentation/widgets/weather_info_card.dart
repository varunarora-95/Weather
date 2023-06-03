part of '../screens/weather_details_screen.dart';

class _WeatherInfoCard extends StatelessWidget {
  const _WeatherInfoCard({
    required this.icon,
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  final String icon, title, value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 25,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              icon,
              color: Colors.white,
              height: 20,
              width: 20,
            ),
            const SizedBox(height: 10),
            Text(title, style: TextStyle(color: offWhite.withOpacity(0.5), fontSize: 16)),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
