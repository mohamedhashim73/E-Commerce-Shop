## How to Run the App

### Prerequisites
Ensure you have the following installed on your system:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version 3.0 or later is recommended)
- An IDE such as [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)
- A device emulator or a physical device for testing

### Steps to Run the App
1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd orders_app
   ```

2. **Install Dependencies**
   Run the following command to install the necessary dependencies:
   ```bash
   flutter pub get
   ```

3. **Run the App**
   - To run the app on an emulator or a connected device:
     ```bash
     flutter run
     ```
   - If you are using an IDE, click the "Run" or "Debug" button in the IDE.
---

## Libraries/Packages Used

The following packages were used in the development of the app:

1. **[Flutter Chart](https://pub.dev/packages/fl_chart)**
   - Used to render pie charts and bar charts for visualizing order data..
2. **[Flutter Bloc](https://pub.dev/packages/flutter_bloc)**
   - Used for state management to separate business logic from UI.
3. **[Bloc](https://pub.dev/packages/bloc)**
   - Core library for handling BLoC patterns.
4. **[Internet Connection Checker](https://pub.dev/packages/internet_connection_checker)**
   - Checks for active internet connections to handle data fetching effectively.
---

## Assumptions Made During Development
- **Data Source:**
  - The orders data is fetched from a local JSON file located in `assets/json/orders.json`. The data is parsed and processed to calculate metrics like total orders, average price, and distribution of order statuses (ordered, delivered, returned).
- **Order Processing Logic:**
  - The `OrdersDataSource` class processes the JSON data and calculates the metrics. It also aggregates order counts by hour for the graph.
- **Repository Pattern:**
  - The `OrdersRepo` class abstracts the data source logic, making the app easily extendable to support remote APIs in the future.
- **BLoC State Management:**
  - The `OrdersCubit` handles business logic, including fetching data, handling errors, and managing loading states.
- **Internet Connection:**
  - The app uses `InternetConnectionChecker` to determine whether the user is offline when an error occurs.

### Example Classes and Workflow
#### Data Layer
- **OrdersDataSource:**
  ```dart
  class OrdersDataSource {
    Future<OrdersModel> getOrders() async {
      int ordered = 0;
      int delivered = 0;
      int returned = 0;
      double averagePrice = 0;
      List<OrderModel> ordersData = [];
      List<GraphBarModel> graphs = [];
      Map<int, double> mappedGraphsData = {};

      String jsonBody = await rootBundle.loadString("assets/json/orders.json");
      for (var order in jsonDecode(jsonBody)) {
        averagePrice += double.parse(order['price'].replaceAll(',', '').replaceAll('\$', ''));
        order['status'] == AppStrings.kReturnedName ? ++returned : order['status'] == AppStrings.kOrderedName ? ++ordered : ++delivered;
        ordersData.add(OrderModel.fromJson(order));
        if (mappedGraphsData.containsKey(ordersData.last.registered.hour)) {
          mappedGraphsData[ordersData.last.registered.hour] = mappedGraphsData[ordersData.last.registered.hour]! + 1;
        } else {
          mappedGraphsData[ordersData.last.registered.hour] = 1;
        }
      }

      graphs = mappedGraphsData.entries.map((entry) => GraphBarModel(x: entry.key, y: entry.value)).toList();
      graphs.sort((a, b) => a.x.compareTo(b.x));
      return OrdersModel(
        graphs: graphs,
        data: ordersData,
        statics: OrdersStatics(
          total: ordersData.length,
          averagePrice: averagePrice,
          delivered: delivered,
          ordered: ordered,
          returned: returned,
        ),
      );
    }
  }
  ```
- **OrdersRepo:**
  ```dart
  class OrdersRepo {
    final OrdersDataSource ordersDataSource;

    OrdersRepo({required this.ordersDataSource});

    Future<OrdersModel> getOrders() async {
      return await ordersDataSource.getOrders();
    }
  }
  ```

#### Business Logic Layer
- **OrdersCubit:**
  ```dart
  class OrdersCubit extends Cubit<OrdersStates> {
    final OrdersRepo ordersRepo;

    OrdersCubit({required this.ordersRepo}) : super(OrdersInitialState());

    static OrdersCubit getInstance(BuildContext context) => BlocProvider.of(context);

    OrdersModel? orders;

    Future<void> getOrders({bool? refreshData}) async {
      try {
        emit(GetOrdersDataLoadingState());
        if (orders == null || refreshData != null) {
          orders = await ordersRepo.getOrders();
          emit(GetOrdersDataSuccessfullyState());
        }
      } catch (e) {
        debugPrint("Exception $e");
        emit(FailedToGetOrdersDataState(
          internetNotFound: await InternetConnectionChecker.createInstance().hasConnection ? true : false,
        ));
      }
    }
  }
  ```

#### States:
  ```dart
  abstract class OrdersStates {}

  class OrdersInitialState extends OrdersStates {}
  class GetOrdersDataLoadingState extends OrdersStates {}
  class GetOrdersDataSuccessfullyState extends OrdersStates {}

  class FailedToGetOrdersDataState extends OrdersStates {
    final bool internetNotFound;

    FailedToGetOrdersDataState({required this.internetNotFound});
  }
  ```

