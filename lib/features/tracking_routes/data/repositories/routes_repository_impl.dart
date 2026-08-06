import '../../../../core/data/result.dart';
import '../../domain/entities/popular_route.dart';
import '../../domain/repositories/routes_repository.dart';

class RoutesRepositoryImpl implements IRoutesRepository {
  @override
  Future<Result<List<PopularRoute>>> getPopularRoutes() async {
    try {
      // Using mock data as seen in AllRoutesModel
      final routes = [
        PopularRoute(
          routeName: 'Mumbai to Pune',
          price: '499',
          imageUrl: 'https://dimg.dreamflow.cloud/v1/image/Lokhandwala%20Complex%20Mumbai',
        ),
        PopularRoute(
          routeName: 'Pune to Nashik',
          price: '350',
          imageUrl: 'https://dimg.dreamflow.cloud/v1/image/Sula%20Vineyards%20Nashik',
        ),
        PopularRoute(
          routeName: 'Ahmedabad to Surat',
          price: '550',
          imageUrl: 'https://dimg.dreamflow.cloud/v1/image/Dargah%20Ahmedabad',
        ),
        PopularRoute(
          routeName: 'Nagpur to Aurangabad',
          price: '750',
          imageUrl: 'https://dimg.dreamflow.cloud/v1/image/Deekshabhoomi%20Nagpur',
        ),
        PopularRoute(
          routeName: 'Bangalore to Hyderabad',
          price: '1100',
          imageUrl: 'https://dimg.dreamflow.cloud/v1/image/Vidhana%20Soudha%20Bangalore',
        ),
        PopularRoute(
          routeName: 'Mumbai to Goa',
          price: '1250',
          imageUrl: 'https://dimg.dreamflow.cloud/v1/image/Gateway%20of%20India%20Mumbai',
        ),
      ];
      return Result.success(routes);
    } catch (e) {
      return Result.error(AppException(e.toString()));
    }
  }
}
