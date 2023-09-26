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

	// TODO(rjk): Sort out the tags

    for t in filesAndTags {
      printFinderTags(t)
    }
  }
}
