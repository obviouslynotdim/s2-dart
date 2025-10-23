UUIDs (Universally Unique Identifiers)
=> to give every object (like a Quiz, a Question, or an Answer) a unique "name" or ID.

Here's why it's necessary for your quiz app:
- Saves Relationships: UUIDs allow you to replace a complex object reference with a simple ID string when saving data to a file (like JSON). This makes it easy to store and retrieve relationships later.
- Prevents Errors: They are so unique that you avoid ID collisions (two different questions getting the same number), which is a risk with manual numbering.

Ex4: I use GPT to guid my understanding of uuid/ to create unque name/id
