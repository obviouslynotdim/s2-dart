class Joke {
  final String title;
  final String description;

  Joke({required this.title, required this.description});
}

List<Joke> jokesList = List.generate(
  20, // : length
  (index) => Joke(
    title: 'Joke ${index + 1}',
    description: 'This is the description for joke ${index + 1}.',
  ),
);
