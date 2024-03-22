library multi_sort;

import 'package:flutter/material.dart';

extension MultiSort on List {
  multiSort(BuildContext context, List<bool> criteria, List<String> preferences) {
    if (criteria.isEmpty || preferences.isEmpty || isEmpty) {
      return this;
    }
    if (preferences.length != criteria.length) {
      return this;
    }

    int compare(int i, dynamic a, dynamic b) {
      if (criteria.elementAt(i)) {
        return a.get(context, preferences.elementAt(i)).compareTo(b.get(context, preferences.elementAt(i)));
      } else {
        return b.get(context, preferences.elementAt(i)).compareTo(a.get(context, preferences.elementAt(i)));
      }
    }

    int sortAll(a, b) {
      int i = 0;
      int result = 0;
      while (i < preferences.length) {
        result = compare(i, a, b);
        if (result != 0) break;
        i++;
      }
      return result;
    }

    sort((a, b) => sortAll(a, b));
  }
}
