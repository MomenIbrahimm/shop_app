import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/const.dart';
import 'package:shop_app/shared/network/bloc_observe.dart';
import 'package:shop_app/shared/network/local.dart';
import 'package:shop_app/shared/network/remote.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/layout_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await CacheHelper.init();

  Widget widget;

  token = CacheHelper.getData(key: 'token');

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  if(onBoarding != null)
  {
    if(token !=null)
      {
        widget = const LayoutScreen();
      }else
        {
          widget = LoginScreen();
        }
  }else{
    widget = OnBoardingScreen();
  }


  BlocOverrides.runZoned(
        () {
      runApp(MyApp(startWidget: widget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  final Widget? startWidget;

  const MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>ShopGeneralCubit()..getHomeData()..getCategoryData()..getProfile()..getFavData()..getAbout()..getContact(),),
      ],
      child: BlocConsumer<ShopGeneralCubit,ShopGeneralStates>(
        listener: (context,state){},
        builder: (context,state){
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            home: startWidget,
            theme: lightTheme,
          );
        },
      ),
    );
  }
}
//113CFC
//1597E5
