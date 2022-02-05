import 'model/input.dart';
import 'model/output.dart';
import 'solver.dart';

class Optimizer {
  late Input input;
  late Output output;

  Optimizer(this.input) {
    output = Output();
  }

  void optimize(String id, List<int> list) {
    List<int> kullanilacakProfiller = input.storage![id]!;

    var solver = Solver(kullanilacakProfiller);
    var results = solver.solve(list);

    List<String> conf = [];

    //profil_id#Kesilen Profil#Elde edilen profiller#fire#kesim adeti
    for (var result in results) {
      String s = id + "#" + result.originalLength.toString() + "#";
      for (var c in result.cuts!) {
        s += c.toString() + ",";
      }
      s = s.substring(0, s.length - 1);
      s += "#" + result.remaining().toString();
      output.toplamAtikUzunluk += result.remaining()!;
      conf.add(s);
      s = "";
    }

    var dConf = conf.toSet().toList();

    for (int i = 0; i < dConf.length; i++) {
      int len = conf.where((e) => e == dConf[i]).length;
      dConf[i] += "#" + len.toString();
    }
    //kesim biçimini outputa ekleyelim.
    output.kesimBicimi.addAll(dConf);
  }

  // Map<int, int> storageMap(Input input) {
  //   Map<int, int> items = <int, int>{};
  //   var storageSet = input.storage!.toSet();
  //   for (var s in storageSet) {
  //     items.putIfAbsent(s, () => 0);
  //     for (var len in input.storage!) {
  //       if (s == len) {
  //         items.update(s, (value) => ++value);
  //       }
  //     }
  //   }
  //   return items;
  // }

  Map<int, int> missingMap(Map<int, int> storage, Map<int, int> cutMap) {
    Map<int, int> items = <int, int>{};
    for (var cut in cutMap.entries) {
      int count = cut.value;
      int available = storage[cut.key]!;
      int missing = count - available;
      if (missing > 0) {
        items.putIfAbsent(cut.key, () => missing);
      }
    }
    return items;
  }
}
