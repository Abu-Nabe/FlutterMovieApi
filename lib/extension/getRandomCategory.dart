import 'dart:math';

String getRandomCategory(List<String> categories) {
  if (categories.isEmpty) {
    throw ArgumentError('The list of categories is empty.');
  }

  // it gets a random category on the category array to display
  Random random = Random();
  int index = random.nextInt(categories.length);
  return categories[index];
}