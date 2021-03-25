import 'package:get/get.dart';
import 'package:roomandu/api_call/api.dart';

class RecommendationController extends GetxController{
  final Api api =Api();
  
   void recommend() async{
    await api.callRecommendation();
  }
}