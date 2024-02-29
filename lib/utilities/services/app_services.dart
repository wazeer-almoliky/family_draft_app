import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppService extends GetxService {
  static  GetStorage? getStorage ;
 static Future<AppService> init() async {
       await GetStorage.init();
     getStorage = GetStorage();
    return AppService();
  }
  static Future<void> write(String key, dynamic value) async{
   await getStorage!.write(key, value);
  }
  static Future<List?> readList(String key)async{
    if(getStorage!.read<List>(key) !=null){
      return  getStorage!.read<List>(key);
    }else{return null;}
  }
  static Future<int?> readInt(String key)async{
    if(getStorage!.read<int>(key) !=null){
      return  getStorage!.read<int>(key);
    }else{return 0;}
  }
  static Future<String?> readString(String key)async{
    if(getStorage!.read<String>(key) !=null){
      return  getStorage!.read<String>(key);
    }else{return '';}
  }
  static Future<void> mainInit() async {
  await Get.putAsync(() => init());
}
}