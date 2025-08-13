import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/services.dart';
import 'food_lib/main.dart';
import 'civil_service_lib/main.dart';
import 'airport_lib/main.dart';
import 'table_lib/main.dart';

// TODO: 여기에 본인의 Google Cloud Platform API 키를 입력하세요.
const String kGoogleApiKey = "AIzaSyDoeEdjOW6iBCK7EaK6NU-UOG3NzdHj4gA";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterNaverMap().init(
      clientId: 'ak8fx9v4ih',
      onAuthFailed: (ex) {
        switch (ex) {
          case NQuotaExceededException(:final message):
            print("사용량 초과 (message: $message)");
            break;
          case NUnauthorizedClientException() ||
              NClientUnspecifiedException() ||
              NAnotherAuthFailedException():
            print("인증 실패: $ex");
            break;
        }
      });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => NaverMapScreen(),
        '/civil_service': (context) => CivilServiceMain(),
        '/food': (context) => FoodMain(),
        '/airport': (context) => AirportMain(),
        '/table': (context)  => TableMain()
      },
    );
  }
}

class NaverMapScreen extends StatefulWidget {
  const NaverMapScreen({Key? key}) : super(key: key);

  @override
  State<NaverMapScreen> createState() => _NaverMapTestScreenState();
}

class _NaverMapTestScreenState extends State<NaverMapScreen> {
  late NaverMapController _mapController;
  final Set<NMarker> _burgerMarkers = {};
  final Set<NMarker> _restaurantMarkers = {};
  final Set<NMarker> _communityCenterMarkers = {};
  final Set<NMarker> _airportMarkers = {};
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const seoulCityHall = NLatLng(37.5666, 126.979);
    final safeAreaPadding = MediaQuery.paddingOf(context);
    return Scaffold(
      body: Stack(
        children: [
          NaverMap(
            options: NaverMapViewOptions(
              contentPadding: safeAreaPadding,
              initialCameraPosition: NCameraPosition(target: seoulCityHall, zoom: 14),
              locationButtonEnable: true,
            ),
            onMapReady: (controller) {
              _mapController = controller;
              print("naver map is ready!");
              _loadAllNearbyPlaces(); // Initial load
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _loadAllNearbyPlaces, // Refresh button
              tooltip: '새로고침',
              child: const Icon(Icons.refresh),
              heroTag: 'refresh',
            ),
          ),
        ],
      ),
    );
  }

  void _updateOverlays() {
    _mapController.clearOverlays();
    _mapController.addOverlayAll({..._burgerMarkers, ..._restaurantMarkers, ..._communityCenterMarkers, ..._airportMarkers});
  }

  Future<void> _loadAllNearbyPlaces() async {
    if (kGoogleApiKey == "YOUR_API_KEY") {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final position = await _determinePosition();
      final cameraUpdate = NCameraUpdate.withParams(
        target: NLatLng(position.latitude, position.longitude),
        zoom: 14,
      );
      await _mapController.updateCamera(cameraUpdate);

      final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

      // Find nearby burgers
      final burgerResponse = await places.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude),
        1500, // 1.5km 반경
        type: 'restaurant',
        keyword: 'hamburger',
      );
      _burgerMarkers.clear();
      if (burgerResponse.status == "OK") {
        for (final result in burgerResponse.results) {
          final lat = result.geometry?.location.lat;
          final lng = result.geometry?.location.lng;
          if (lat != null && lng != null) {
            final marker = NMarker(
              id: result.placeId,
              position: NLatLng(lat, lng),
              caption: NOverlayCaption(text: result.name),
              iconTintColor: Colors.red,
            );
            marker.setOnTapListener((_) {
              Navigator.pushNamed(context, '/food');
            });
            _burgerMarkers.add(marker);
          }
        }
      }

      // Find nearby restaurants
      final restaurantResponse = await places.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude),
        1500, // 1.5km 반경
        type: 'restaurant',
      );
      _restaurantMarkers.clear();
      if (restaurantResponse.status == "OK") {
        for (final result in restaurantResponse.results) {
          final name = result.name.toLowerCase();
          if (name.contains('버거') || name.contains('burger') || name.contains('hamburger')) {
            continue;
          }
          final lat = result.geometry?.location.lat;
          final lng = result.geometry?.location.lng;
          if (lat != null && lng != null) {
            final marker = NMarker(
              id: result.placeId,
              position: NLatLng(lat, lng),
              caption: NOverlayCaption(text: result.name),
              iconTintColor: Colors.blue,
            );
            marker.setOnTapListener((_) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
              Navigator.pushNamed(context, '/table');
            });
            _restaurantMarkers.add(marker);
          }
        }
      }

      // Find nearby community centers
      final communityCenterResponse1 = await places.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude),
        1500, // 1.5km
        type: 'local_government_office',
        keyword: '주민센터',
        language: 'ko',
      );
      final communityCenterResponse2 = await places.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude),
        1500, // 1.5km
        type: 'local_government_office',
        keyword: '행정복지센터',
        language: 'ko',
      );
      _communityCenterMarkers.clear();
      final Map<String, PlacesSearchResult> allCommunityCenterResults = {};
      if (communityCenterResponse1.status == "OK") {
        for (var result in communityCenterResponse1.results) {
          allCommunityCenterResults[result.placeId] = result;
        }
      }
      if (communityCenterResponse2.status == "OK") {
        for (var result in communityCenterResponse2.results) {
          allCommunityCenterResults[result.placeId] = result;
        }
      }
      if (allCommunityCenterResults.isNotEmpty) {
        for (final result in allCommunityCenterResults.values) {
          final lat = result.geometry?.location.lat;
          final lng = result.geometry?.location.lng;
          if (lat != null && lng != null) {
            final marker = NMarker(
              id: result.placeId,
              position: NLatLng(lat, lng),
              caption: NOverlayCaption(text: result.name),
              iconTintColor: Colors.green,
            );
            marker.setOnTapListener((_) {
              Navigator.pushNamed(context, '/civil_service');
            });
            _communityCenterMarkers.add(marker);
          }
        }
      }

      // Find nearby airports
      final airportResponse = await places.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude),
        15000, // 15km 반경 (airports can be further away)
        type: 'airport',
      );
      _airportMarkers.clear();
      if (airportResponse.status == "OK") {
        for (final result in airportResponse.results) {
          final lat = result.geometry?.location.lat;
          final lng = result.geometry?.location.lng;
          if (lat != null && lng != null) {
            final marker = NMarker(
              id: result.placeId,
              position: NLatLng(lat, lng),
              caption: NOverlayCaption(text: result.name),
              iconTintColor: Colors.purple,
            );
            marker.setOnTapListener((_) {
              Navigator.pushNamed(context, '/airport');
            });
            _airportMarkers.add(marker);
          }
        }
      }

      _updateOverlays(); // Update overlays once after all searches

    } catch (e) {
      // Do nothing
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
