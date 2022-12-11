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

    int compare(int i, dynamic a, dynamic b) {
      return criteria[i] ? a.get(preference[i]).compareTo(b.get(preference[i])) : b.get(preference[i]).compareTo(a.get(preference[i]));
    }

    int sortAll(a, b) {
      int i = 0;
      int result = 0;
      while (i < preference.length) {
        result = compare(i, a, b);
        if (result != 0) break;
        i++;
      }
      return result;
    }

    sort((a, b) => sortAll(a, b));
  }
}
