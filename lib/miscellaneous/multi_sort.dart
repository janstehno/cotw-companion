// Copyright (c) 2023 Jan Stehno

library multi_sort;

extension MultiSort on List {
  multiSort(List<bool> criteria, List<String> preferences) {
    if (criteria.isEmpty || preferences.isEmpty || isEmpty) {
      return this;
    }
    if (preferences.length != criteria.length) {
      return this;
    }

    int compare(int index, dynamic a, dynamic b) {
      return criteria[index] ? a.get(preferences[index]).compareTo(b.get(preferences[index])) : b.get(preferences[index]).compareTo(a.get(preferences[index]));
    }

    int sortAll(a, b) {
      int index = 0;
      int result = 0;
      while (index < preferences.length) {
        result = compare(index, a, b);
        if (result != 0) break;
        index++;
      }
      return result;
    }

    sort((a, b) => sortAll(a, b));
  }
}
