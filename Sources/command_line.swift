// [apple/swift-argument-parser: Straightforward, type-safe argument parsing for Swift](https://github.com/apple/swift-argument-parser)
import ArgumentParser

// Swift has a bunch of macros called a *property wrapper*. `@main` is one
// such wrapper. It makes the `run` method in the wrapped struct (class?) into
// the global entry point.
@main
struct Tag: ParsableCommand {
  @Flag(name: .shortAndLong, help: "clear the tags set on the file first or append them")
  var reset = false

  // TODO(rjk): Parse the tags out. They have leading '@' signs.
  @Argument(help: "Tags and files")
  var filesAndTags: [String]

  // I don't mutate this structure. If I assigned to self?
  mutating func run() throws {
    // Why can't I just use the standard integer subscripting? Is this some
    // kind of protecting me from wrong unicode habits thing? For low-level
    // String thwacking, Go or Zig would seem to be a better fit.
    let tags = filesAndTags.filter({ s in s.hasPrefix("@") }).map({ s in
      String.init(
        s.suffix(from: s.index(s.startIndex, offsetBy: 1)))
    })
    let files = filesAndTags.filter({ s in !s.hasPrefix("@") })

    if tags.count > 0 {
      for f in files {
        setFinderTags(tags, f, reset)
      }
    } else {
      for t in files {
        printFinderTags(t)
      }
    }
  }
}
