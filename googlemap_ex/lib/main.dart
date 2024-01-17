import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'google_maps_ex.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // runApp() 함수 호출 전 WidgetsBinding을 초기화
  // // 초기화하지 않으면 ServicesBinding을 사용하는 일부 패키지에서 문제가 발생할 수 있음
  // final status = await Geolocator.checkPermission(); // 위치 권한 상태 확인
  // if (status == LocationPermission.denied) { // 권한이 거부된 경우
  //   await Geolocator.requestPermission(); // 권한 요청
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: GoogleMapsEx(),
    );
  }
}
