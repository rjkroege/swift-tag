// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

print("Hello, world!")

func fooey(_ fn: String) {
  let r_url = URL.init(fileURLWithPath: fn)

  print(r_url.debugDescription)

  let urvs = try? r_url.resourceValues(forKeys: [
    URLResourceKey.isRegularFileKey, URLResourceKey.tagNamesKey, URLResourceKey.isDirectoryKey,
    URLResourceKey.totalFileSizeKey,
  ])

  guard let r_urvs = urvs else {
    print("resourceValues failed!")
    return
  }

  print("fooey middle \(r_urvs)")

  if let r_tfs = r_urvs.totalFileSize {
    print("totalFileSize \(r_tfs)")
  }
  if let r_irf = r_urvs.isRegularFile {
    print("isRegularFile \(r_irf)")
  }
  if let r_id = r_urvs.isDirectory {
    print("isDirectory \(r_id)")
  }
  if let r_tags = r_urvs.tagNames {
    print("tagNames \(r_tags)")
  }
  print("fooey end")

}

fooey("/Users/rjkroege/tools/mkconfig")
