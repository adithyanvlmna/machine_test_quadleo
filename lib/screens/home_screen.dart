import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:machine_test_quadleo/core/app_theme/app_colors.dart';
import 'package:machine_test_quadleo/core/utils/internet_chacker.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ConnectivityWrapperWidget(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: searchBar(
                      onChanged: (value) {
                        context.read<ProductBloc>().add(SearchProduct(value));
                      },
                    ),
                  ),

                  const Icon(Icons.tune),
                ],
              ),
            ),

            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }
                  if (state is ProductLoaded) {
                    return RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: () async {
                        context.read<ProductBloc>().add(FetchProducts());
                      },
                      child: AnimationLimiter(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: state.filtered.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemBuilder: (context, index) {
                            final product = state.filtered[index];

                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              columnCount: 2,
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: customProductCard(
                                    image: product.image,
                                    title: product.title,
                                    price: product.price.toString(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }

                  return const Center(child: Text("Failed to load products"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar({required void Function(String)? onChanged}) {
    return TextField(
      onChanged: (value) {
        if (onChanged != null) {
          onChanged(value);
        }
      },
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget customProductCard({
    required String image,
    required String title,
    required String price,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(
                image,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "₹ $price",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
