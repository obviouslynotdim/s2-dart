# Question 1 :
=> Method 3: Dedicated Function: why? Because it’s best maintainability, keep UI by separating logic and easy to test and reuse multiple places

# Question 4 :
What type of data will store the jokes?
=> jokesList → List<Joke>
What type of data will store the favorite joke?
=> _favoriteIndex - int?

Which widget should be in charge of storing the favorite joke? 
=> JokesList (specifically _JokesListState)
Which widget should be stateful?
=> JokesList - Stateful, because it updates when the favorite changes

How will your widget interact?
=> FavoriteCard calls onFavoriteClick(index) - this tell parent(JokesList) which joke selected
Do you need to pass callback function between widgets?
=> yes, i use it <onFavoriteClick>
