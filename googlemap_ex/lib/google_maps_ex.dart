import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsEx extends StatefulWidget {
  const GoogleMapsEx({super.key});

  @override
  State<GoogleMapsEx> createState() => _GoogleMapsExState();
}

class _GoogleMapsExState extends State<GoogleMapsEx> {
  static final CameraPosition position = CameraPosition(
    // 서울역 카메라 줌을 12배로 해서 설정
      target: LatLng(37.555946, 126.972317),
      zoom: 14); // LatLng => Latitude:위도(세로), Longitude:경도(가로)

  final _markers = <Marker>{};

  final _position = [
    {
      "name": "시청",
      "latitude": 37.5648406,
      "longitude": 126.977303,
    },
    {
      "name": "엑스플렉스 상암",
      "latitude": 37.5754986,
      "longitude": 126.8899652,
    },
    {
      "name": "우리집",
      "latitude": 37.4135509,
      "longitude": 126.6263957,
    },
  ];

  @override
  void initState() {
    _markers.addAll(
      _position.map(
            (e) => Marker(
          markerId: MarkerId(e['name'] as String),
          infoWindow: InfoWindow(title: e['name'] as String),
          position: LatLng(
            e['latitude'] as double,
            e['longitude'] as double,
          ),
        ),
      ),
    );
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GoogleMaps"),
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal, // 지도 유형 설정
          // hybrid, satellite, terrain, normal(초기값)
          initialCameraPosition: position, // 지도 초기 위치 설정
          markers: _markers,
        ),
      ),
    );
  }
}
