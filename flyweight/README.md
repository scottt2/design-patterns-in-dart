## Flyweight Pattern
In computer programming, flyweight is a software design pattern. A flyweight is an object that minimizes memory usage by sharing as much data as possible with other similar objects; it is a way to use objects in large numbers when a simple repeated representation would use an unacceptable amount of memory. Often some parts of the object state can be shared, and it is common practice to hold them in external data structures and pass them to the objects temporarily when they are used.

A classic example usage of the flyweight pattern is the data structures for graphical representation of characters in a word processor. It might be desirable to have, for each character in a document, a glyph object containing its font outline, font metrics, and other formatting data, but this would amount to hundreds or thousands of bytes for each character. Instead, for every character there might be a reference to a flyweight glyph object shared by every instance of the same character in the document; only the position of each character (in the document and/or the page) would need to be stored internally.

Another example is string interning.

In other contexts the idea of sharing identical data structures is called hash consing.

[Wikipedia: Flyweight Pattern](https://en.wikipedia.org/wiki/Flyweight_pattern)

### Example

[View on GitHub](https://github.com/scottt2/design-patterns-in-dart/tree/master/flyweight)

```dart
import "dart:collection";

class Letter {
  String letter;
  Letter(String l) {
    if (l.length != 1) { throw new Exception("Can only be a single letter"); }
    letter = l;
  }

  @override
  String toString() => letter;
}

class Sentence {
  List<Letter> letters = [];
  void addLetter(Letter letter) => letters.add(letter);

  @override
  String toString() => letters.join("");
}

class LetterFactory {
  Map<String, Letter> letters = {};

  Letter fetchLetter(String l) {
    if (letters.containsKey(l)) { return letters[l]; }
    var letter = Letter(l);
    letters[l] = letter;
    return letter;
  }

  int get lettersCreated => letters.length;
}

class Document {
  LetterFactory letterFactory = LetterFactory();
  int lettersWritten = 0;
  SplayTreeMap<int, Sentence> sentences;

  Document() {
    sentences = new SplayTreeMap<int, Sentence>();
  }

  void export() => sentences.forEach((k, v) => print("$v"));

  void write(int sentenceKey, String letterString) {
    if (!sentences.containsKey(sentenceKey)) {
      sentences[sentenceKey] = Sentence();
    }

    var l = letterFactory.fetchLetter(letterString);
    sentences[sentenceKey].addLetter(l);
    lettersWritten++;
  }
}

void main() {
  var doc = Document();

  doc.write(6, "t");
  doc.write(7, "u");
  doc.write(1, "A");
  doc.write(2, "y");
  doc.write(7, "s");
  doc.write(3, "b");
  doc.write(2, "o");
  doc.write(3, "a");
  doc.write(2, "u");
  doc.write(1, "l");
  doc.write(3, "s");
  doc.write(3, "e");
  doc.write(4, "a");
  doc.write(1, "l");
  doc.write(2, "r");
  doc.write(5, "b");
  doc.write(5, "e");
  doc.write(5, "l");
  doc.write(5, "o");
  doc.write(4, "r");
  doc.write(5, "n");
  doc.write(4, "e");
  doc.write(6, "o");
  doc.write(5, "g");

  doc.export();

  /*
    All
    your
    base
    are
    belong
    to
    us
  */
}
```
