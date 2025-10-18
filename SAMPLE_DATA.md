# Sample Data for BookStore App

This file contains sample book data that you can add to your Firestore database.

## How to Add Sample Data

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Go to Firestore Database
4. Create a collection named `books`
5. For each book below, click "Add document" and copy the data

## Sample Books

### Fiction

#### Book 1: The Great Gatsby
```json
{
  "title": "The Great Gatsby",
  "author": "F. Scott Fitzgerald",
  "description": "The Great Gatsby is a 1925 novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, the novel depicts narrator Nick Carraway's interactions with mysterious millionaire Jay Gatsby and Gatsby's obsession to reunite with his former lover, Daisy Buchanan.",
  "price": 12.99,
  "category": "Fiction",
  "imageUrl": "https://via.placeholder.com/400x600?text=The+Great+Gatsby",
  "rating": 4.5,
  "reviewCount": 1250,
  "isbn": "978-0-7432-7356-5",
  "stock": 45
}
```

#### Book 2: To Kill a Mockingbird
```json
{
  "title": "To Kill a Mockingbird",
  "author": "Harper Lee",
  "description": "To Kill a Mockingbird is a novel by Harper Lee published in 1960. It was immediately successful, winning the Pulitzer Prize, and has become a classic of modern American literature. The plot and characters are loosely based on Lee's observations of her family and neighbors.",
  "price": 14.99,
  "category": "Fiction",
  "imageUrl": "https://via.placeholder.com/400x600?text=To+Kill+a+Mockingbird",
  "rating": 4.8,
  "reviewCount": 2100,
  "isbn": "978-0-06-112008-4",
  "stock": 38
}
```

#### Book 3: 1984
```json
{
  "title": "1984",
  "author": "George Orwell",
  "description": "1984 is a dystopian social science fiction novel and cautionary tale by English writer George Orwell. It was published on 8 June 1949 by Secker & Warburg as Orwell's ninth and final book completed in his lifetime.",
  "price": 13.99,
  "category": "Fiction",
  "imageUrl": "https://via.placeholder.com/400x600?text=1984",
  "rating": 4.7,
  "reviewCount": 1890,
  "isbn": "978-0-452-28423-4",
  "stock": 52
}
```

### Non-Fiction

#### Book 4: Sapiens
```json
{
  "title": "Sapiens: A Brief History of Humankind",
  "author": "Yuval Noah Harari",
  "description": "Sapiens is a popular science book that surveys the history of humankind from the Stone Age up to the twenty-first century. The account is situated within a framework provided by the natural sciences, particularly evolutionary biology.",
  "price": 18.99,
  "category": "Non-Fiction",
  "imageUrl": "https://via.placeholder.com/400x600?text=Sapiens",
  "rating": 4.6,
  "reviewCount": 3200,
  "isbn": "978-0-06-231609-7",
  "stock": 67
}
```

#### Book 5: Educated
```json
{
  "title": "Educated: A Memoir",
  "author": "Tara Westover",
  "description": "Educated is a memoir by the American author Tara Westover. Westover recounts overcoming her survivalist Mormon family in order to go to college, and emphasizes the importance of education in enlarging her world.",
  "price": 16.99,
  "category": "Non-Fiction",
  "imageUrl": "https://via.placeholder.com/400x600?text=Educated",
  "rating": 4.7,
  "reviewCount": 2890,
  "isbn": "978-0-399-59050-4",
  "stock": 41
}
```

### Science

#### Book 6: A Brief History of Time
```json
{
  "title": "A Brief History of Time",
  "author": "Stephen Hawking",
  "description": "A Brief History of Time: From the Big Bang to Black Holes is a book on theoretical cosmology by English physicist Stephen Hawking. It was first published in 1988. Hawking wrote the book for readers who had no prior knowledge of physics.",
  "price": 15.99,
  "category": "Science",
  "imageUrl": "https://via.placeholder.com/400x600?text=A+Brief+History+of+Time",
  "rating": 4.4,
  "reviewCount": 1560,
  "isbn": "978-0-553-38016-3",
  "stock": 33
}
```

#### Book 7: The Selfish Gene
```json
{
  "title": "The Selfish Gene",
  "author": "Richard Dawkins",
  "description": "The Selfish Gene is a 1976 book on evolution by the ethologist Richard Dawkins, in which the author builds on the principal theory of George C. Williams's Adaptation and Natural Selection (1966). Dawkins uses the term 'selfish gene' as a way of expressing the gene-centred view of evolution.",
  "price": 14.99,
  "category": "Science",
  "imageUrl": "https://via.placeholder.com/400x600?text=The+Selfish+Gene",
  "rating": 4.5,
  "reviewCount": 980,
  "isbn": "978-0-19-929114-4",
  "stock": 28
}
```

### Technology

#### Book 8: Clean Code
```json
{
  "title": "Clean Code: A Handbook of Agile Software Craftsmanship",
  "author": "Robert C. Martin",
  "description": "Even bad code can function. But if code isn't clean, it can bring a development organization to its knees. Every year, countless hours and significant resources are lost because of poorly written code. But it doesn't have to be that way.",
  "price": 42.99,
  "category": "Technology",
  "imageUrl": "https://via.placeholder.com/400x600?text=Clean+Code",
  "rating": 4.7,
  "reviewCount": 1420,
  "isbn": "978-0-13-235088-4",
  "stock": 24
}
```

#### Book 9: The Pragmatic Programmer
```json
{
  "title": "The Pragmatic Programmer",
  "author": "Andrew Hunt & David Thomas",
  "description": "The Pragmatic Programmer: From Journeyman to Master is a book about computer programming and software engineering, written by Andrew Hunt and David Thomas and published in October 1999. It is used as a textbook in related university courses.",
  "price": 39.99,
  "category": "Technology",
  "imageUrl": "https://via.placeholder.com/400x600?text=The+Pragmatic+Programmer",
  "rating": 4.8,
  "reviewCount": 1890,
  "isbn": "978-0-13-595705-9",
  "stock": 19
}
```

### Biography

#### Book 10: Steve Jobs
```json
{
  "title": "Steve Jobs",
  "author": "Walter Isaacson",
  "description": "Based on more than forty interviews with Steve Jobs conducted over two years—as well as interviews with more than 100 family members, friends, adversaries, competitors, and colleagues—Walter Isaacson has written a riveting story of the roller-coaster life and searingly intense personality of a creative entrepreneur.",
  "price": 16.99,
  "category": "Biography",
  "imageUrl": "https://via.placeholder.com/400x600?text=Steve+Jobs",
  "rating": 4.6,
  "reviewCount": 2340,
  "isbn": "978-1-4516-4853-9",
  "stock": 56
}
```

#### Book 11: Becoming
```json
{
  "title": "Becoming",
  "author": "Michelle Obama",
  "description": "In her memoir, a work of deep reflection and mesmerizing storytelling, Michelle Obama invites readers into her world, chronicling the experiences that have shaped her—from her childhood on the South Side of Chicago to her years as an executive balancing the demands of motherhood and work.",
  "price": 19.99,
  "category": "Biography",
  "imageUrl": "https://via.placeholder.com/400x600?text=Becoming",
  "rating": 4.9,
  "reviewCount": 4120,
  "isbn": "978-1-5247-6313-8",
  "stock": 71
}
```

### Business

#### Book 12: The Lean Startup
```json
{
  "title": "The Lean Startup",
  "author": "Eric Ries",
  "description": "The Lean Startup is a new approach to business that's being adopted around the world. It is changing the way companies are built and new products are launched. The Lean Startup is about learning what your customers really want and learning it quickly.",
  "price": 24.99,
  "category": "Business",
  "imageUrl": "https://via.placeholder.com/400x600?text=The+Lean+Startup",
  "rating": 4.5,
  "reviewCount": 1680,
  "isbn": "978-0-307-88791-7",
  "stock": 43
}
```

#### Book 13: Zero to One
```json
{
  "title": "Zero to One: Notes on Startups, or How to Build the Future",
  "author": "Peter Thiel",
  "description": "The great secret of our time is that there are still uncharted frontiers to explore and new inventions to create. In Zero to One, legendary entrepreneur and investor Peter Thiel shows how we can find singular ways to create those new things.",
  "price": 22.99,
  "category": "Business",
  "imageUrl": "https://via.placeholder.com/400x600?text=Zero+to+One",
  "rating": 4.6,
  "reviewCount": 1290,
  "isbn": "978-0-8041-3929-8",
  "stock": 37
}
```

### Self-Help

#### Book 14: Atomic Habits
```json
{
  "title": "Atomic Habits: An Easy & Proven Way to Build Good Habits & Break Bad Ones",
  "author": "James Clear",
  "description": "No matter your goals, Atomic Habits offers a proven framework for improving--every day. James Clear, one of the world's leading experts on habit formation, reveals practical strategies that will teach you exactly how to form good habits, break bad ones, and master the tiny behaviors that lead to remarkable results.",
  "price": 16.99,
  "category": "Self-Help",
  "imageUrl": "https://via.placeholder.com/400x600?text=Atomic+Habits",
  "rating": 4.8,
  "reviewCount": 5670,
  "isbn": "978-0-7352-1129-2",
  "stock": 89
}
```

#### Book 15: The 7 Habits of Highly Effective People
```json
{
  "title": "The 7 Habits of Highly Effective People",
  "author": "Stephen R. Covey",
  "description": "The 7 Habits of Highly Effective People has captivated readers for 25 years. It has transformed the lives of Presidents and CEOs, educators, parents, and students—in short, millions of people of all ages and occupations.",
  "price": 15.99,
  "category": "Self-Help",
  "imageUrl": "https://via.placeholder.com/400x600?text=7+Habits",
  "rating": 4.7,
  "reviewCount": 3240,
  "isbn": "978-1-982-13727-4",
  "stock": 62
}
```

## Quick Add via Firebase Console

1. Go to Firestore Database in Firebase Console
2. Click on the `books` collection
3. Click "Add document"
4. Let Firebase auto-generate the Document ID
5. Copy and paste each field from the JSON above
6. Click "Save"
7. Repeat for all books

## Bulk Import (Advanced)

For bulk import, you can use the Firebase Admin SDK with a script, but this requires additional setup. The manual method above is recommended for getting started quickly.

## Custom Images

Replace the placeholder `imageUrl` values with real book cover images:
- You can use free image hosting services
- Or use Firebase Storage to upload and host your images
- Make sure images are 400x600 pixels or similar aspect ratio for best display
