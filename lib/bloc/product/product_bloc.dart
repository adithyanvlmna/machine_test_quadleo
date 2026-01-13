
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_quadleo/service/api_service.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repo;

  ProductBloc(this.repo) : super(ProductLoading()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await repo.fetchProducts();
        emit(ProductLoaded(products, products));
      } catch (e) {
        emit(ProductError());
      }
    });

    on<SearchProduct>((event, emit) {
      final state = this.state as ProductLoaded;

      final filtered = state.products
          .where((p) =>
              p.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(ProductLoaded(state.products, filtered));
    });
  }
}
