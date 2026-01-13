



import 'package:machine_test_quadleo/model/product_model.dart';

abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> filtered;

  ProductLoaded(this.products, this.filtered);
}

class ProductError extends ProductState {}
