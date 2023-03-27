// Copyright (c) 2022 Jan Stehno

library multi_sort;

extension MultiSort on List {
  multiSort(List<bool> criteria, dynamic preference) {
    if (preference.length == 0 || criteria.isEmpty || isEmpty) {
      return this;
    }
    if (preference.length != criteria.length) {
      return this;
    }

    int compare(int index, dynamic a, dynamic b) {
      return criteria[index] ? a.get(preference[index]).compareTo(b.get(preference[index])) : b.get(preference[index]).compareTo(a.get(preference[index]));
    }

    int sortAll(a, b) {
      int index = 0;
      int result = 0;
      while (index < preference.length) {
        result = compare(index, a, b);
        if (result != 0) break;
        index++;
      }
      return result;
    }

    sort((a, b) => sortAll(a, b));
  }
}
