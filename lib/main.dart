import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_quadleo/bloc/login/login_bloc.dart';
import 'package:machine_test_quadleo/bloc/product/product_bloc.dart';
import 'package:machine_test_quadleo/bloc/register/register_bloc.dart';
import 'package:machine_test_quadleo/core/app_theme/app_colors.dart';
import 'package:machine_test_quadleo/core/utils/routes.dart';
import 'package:machine_test_quadleo/service/api_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final productRepository = ProductRepository(); 

  runApp(MyApp(productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepository productRepository;

  const MyApp({
    super.key,
    required this.productRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(),
        ),

        BlocProvider<RegisterBloc>(
          create: (_) => RegisterBloc(),
        ),

        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(productRepository),
        ),
      ],
      child: ConnectivityAppWrapper(
        app: MaterialApp(
          title: 'Emart',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splashScreen,
          routes: Routes.routes,
        ),
      ),
    );
  }
}
