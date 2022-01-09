class Bar {
  int? originalLength;
  List<int>? cuts;

  Bar(this.originalLength) {
    cuts = [];
  }

  int? remaining() {
    int sum = 0;
    if (cuts!.isNotEmpty) {
      sum = cuts!.reduce((a, b) => a + b);
    }
    return originalLength! - sum;
  }

  void cut(int len) => cuts!.add(len);
}
