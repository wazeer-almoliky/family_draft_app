import 'package:family/model/remote/api_data.dart';
import 'package:family/model/remote/api_model.dart';
import 'package:family/utilities/functions/api_function.dart';
import 'package:get/get.dart';
class RemoteState {
  static final RemoteState _rst =RemoteState.internal();
  factory RemoteState(){
    return _rst;
  }
  RemoteState.internal();
  int getID(List<CommonApi> names,String name){
   final nameId = names.indexWhere((el) => el.name==name);
   final id=nameId < 0 ? 0 : names[nameId].id;
  return id!;
  }
  // int getPrice(int periodID,int prID){
  //  final nameId = priceState.indexWhere((el) => el.periodID==periodID && el.serviceID==prID);
  //  log("The ID:: $nameId");
  //  final id=nameId < 0 ? 0 : priceState[nameId].price;
  // return id!;
  // }
  List<String> getNames(List<CommonApi> names){
   final name = names.map((el) => el.name!).toList();
    return name;
 }
  final serviceState = <Catagory>[].obs;
  final servicesState = <Product>[].obs;
  final userState = <User>[].obs;
  final reserveState = <Reserve>[].obs;
  final givserState = <Family>[].obs;
  // final priceState = <Price>[].obs;
  // final periodState = <Period>[].obs;
  final photoState = <Photo>[].obs;

  final isLoading = false.obs;
  final api = ApiData(Get.find<Crud>());
}