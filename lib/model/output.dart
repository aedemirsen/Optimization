class Output {
  String kesimBicimiFormat =
      "Kesilen Profil#Elde edilen profiller#kesim adeti#fire#profil_id";

  int toplamAtikUzunluk = 0;

  int toplamAtikAgirlik = 0;

  late List<String> kesimBicimi;

  Output() {
    kesimBicimi = [];
  }

  Map<int, int> usedItemMap() {
    Map<int, int> items = <int, int>{};
    for (var kb in kesimBicimi) {
      var splitted = kb.split('#');
      int kesilen = int.parse(splitted[0]);
      int adet = int.parse(splitted[3]);
      items.putIfAbsent(kesilen, () => 0);
      items.update(kesilen, (value) => value + adet);
    }
    return items;
  }
}
