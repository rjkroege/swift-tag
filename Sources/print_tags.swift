// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

func printFinderTags(_ fn: String) {
  let url = URL.init(fileURLWithPath: fn)

  let urvs = try? url.resourceValues(forKeys: [
    URLResourceKey.tagNamesKey, URLResourceKey.pathKey,
  ])

  guard let r_urvs = urvs else {
    print("resourceValues failed!")
    return
  }

  // Strips out the files that don't have any tag at all. Is that I want? I
  // can reconsider this later.
  if let path = r_urvs.path, let tags = r_urvs.tagNames {
    let joinedtags = tags[1...].reduce(
      tags[0],
      { x, y in
        x + ", " + y
      })
    print("\(path): \(joinedtags)")
  }
}

// printFinderTags("/Users/rjkroege/tools/mkconfig")
// printFinderTags("test")
// printFinderTags("guide")
