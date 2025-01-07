abstract class OrdersStates {}

class OrdersInitialState extends OrdersStates {}

// TODO: Get Orders Data
class GetOrdersDataLoadingState extends OrdersStates {}
class GetOrdersDataSuccessfullyState extends OrdersStates {}
class FailedToGetOrdersDataState extends OrdersStates {
  final bool internetNotFound;
  FailedToGetOrdersDataState({required this.internetNotFound});
}
