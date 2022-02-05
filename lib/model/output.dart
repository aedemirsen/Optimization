class Output {
  String kesimBicimiFormat =
      "id#Kesilen Profil#Elde edilen profiller#kesim adeti#fire#profil_id";

  int toplamAtikUzunluk = 0;

  int toplamAtikAgirlik = 0;

  late List<String> kesimBicimi;
  late List<String> eksikProfiller;

  Output() {
    kesimBicimi = [];
    eksikProfiller = [];
  }

  Map<int, int> usedItemMap(String id) {
    Map<int, int> items = <int, int>{};
    for (var kb in kesimBicimi) {
      var splitted = kb.split('#');
      if (splitted[0] == id) {
        int kesilen = int.parse(splitted[1]);
        int adet = int.parse(splitted[4]);
        items.putIfAbsent(kesilen, () => 0);
        items.update(kesilen, (value) => value + adet);
      }
    }
    return items;
  }
}
