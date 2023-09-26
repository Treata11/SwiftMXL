# SwiftMXL

This package is a fork of the original 
[dn-m/MusicXML](https://github.com/dn-m/MusicXML).

![Swift Version](https://img.shields.io/badge/Swift-5.1-orange.svg)
![Platforms](https://img.shields.io/badge/platform-linux%20%7C%20macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey)
<!-- [![Build Status](https://travis-ci.org/dn-m/MusicXML.svg?branch=latest)](https://travis-ci.org/dn-m/MusicXML) -->
<!-- [![Code Coverage](https://codecov.io/gh/dn-m/MusicXML/branch/latest/graph/badge.svg)](https://codecov.io/github/dn-m/MusicXML) -->

A **Work-In-Progress** implementation of the [MusicXML](https://www.musicxml.com) specification in Swift.

The goal of this project is to allow Swift users to read, manipulate, and write musicXML files in a richly-typed manner on any platform supported by Swift.

## Hello, world!

Let's construct the "Hello, world!" score example from the [musicXML documentation](https://www.musicxml.com/tutorial/hello-world/). This musical composition consists of one measure that contains a whole note on middle C, based in 4/4 time.

### Graphical Representation

When rendered graphically, this score example should look something like this:

![Hello, world!](Documentation/hello_world.gif)

### XML Representation

The musicXML representation looks like this:

```XML
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE score-partwise PUBLIC
    "-//Recordare//DTD MusicXML 3.1 Partwise//EN"
    "http://www.musicxml.org/dtds/partwise.dtd">
<score-partwise version="3.1">
  <part-list>
    <score-part id="P1">
      <part-name>Music</part-name>
    </score-part>
  </part-list>
  <part id="P1">
    <measure number="1">
      <attributes>
        <divisions>1</divisions>
        <key>
          <fifths>0</fifths>
        </key>
        <time>
          <beats>4</beats>
          <beat-type>4</beat-type>
        </time>
        <clef>
          <sign>G</sign>
          <line>2</line>
        </clef>
      </attributes>
      <note>
        <pitch>
          <step>C</step>
          <octave>4</octave>
        </pitch>
        <duration>4</duration>
        <type>whole</type>
      </note>
    </measure>
  </part>
</score-partwise>
```

### `MusicXML` Representation

To construct the "Hello, world!" example in Swift looks like this:

```Swift
let note = Note(
    pitch: Pitch(step: .c, octave: 4), 
    duration: 4, 
    type: .whole
)
let key = Key(fifths: 0)
let time = Time(4,4)
let clef = Clef(sign: .g, line: 2)
let attributes = Attributes(
    divisions: 1,
    keys: [key],
    times: [time],
    clefs: [clef]
)
let measure = Partwise.Measure(
    number: "1",
    musicData: [
        .attributes(attributes),
        .note(note)
    ]
)
let part = Partwise.Part(id: "P1", measures: [measure])
let header = Header(
    partList: [
        .part(ScorePart(id: "P1", name: "Music"))
    ]
)
let traversal = Partwise(header: header, parts: [part])
let score = Score.partwise(traversal)
```

### 🧬 Decoding musicXML into a `Score`

You can decode a `Score` in a variety of ways:

```Swift
let fromData = try Score(data: data)
let fromString = try Score(string: string)
let fromURL = try Score(url: url)
```

[comment]: <> ( ### 🚧 Work-in-progress: Encoding a `Score` into musicXML)




## Getting Started

### Requirements

Use the [Swift Package Manager](https://swift.org/package-manager/) to include the `SwiftMXL` module into your project.

[comment]: <> ( ### Usage)

[comment]: <> ( If you want to use the `SwiftMXL` module in your own project, add the `SwiftMXL` package to the `dependencies` section of your `Package.swift` file:)

<!-- ### Development

To contribute to the `SwiftMXL` package, clone the `git` repository:

```
git clone https://github.com/Treata11/SwiftMXL && cd SwiftMXL
```

Build the package:

```
swift build
```

Run the tests:

```
swift test
```

If you use the Xcode IDE

```open package.swift``` or simply ```xed .```
-->


## More Resources

See the 
[MusicXML XSD Schema Reference](http://usermanuals.musicxml.com/MusicXML/MusicXML.htm#MusicXMLReference.htm%3FTocPath%3DMusicXML%2520Reference%7C_____0) for more information about how MusicXML is structured.
