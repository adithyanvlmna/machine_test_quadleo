abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class SearchProduct extends ProductEvent {
  final String query;
  SearchProduct(this.query);
}
