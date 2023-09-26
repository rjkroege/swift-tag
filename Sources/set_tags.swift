import Foundation

func setFinderTags(_ tags: [String], _ fn: String, _ reset: Bool) {
  let url = URL.init(fileURLWithPath: fn)

  let urvs = try? url.resourceValues(forKeys: [
    URLResourceKey.tagNamesKey
  ])
  guard let r_urvs = urvs else {
    print("setFinderTags resourceValues failed!")
    return
  }

  // Make a set
  guard let r_tagnames = r_urvs.tagNames else {
    print("getting tagNames failed")
    return
  }

  // Merge the set with tags
  let tagset = Set(r_tagnames)
  let mergedtagset = tagset.union(tags).map { $0 }

  // There is a bug in Foundation maybe? See [Setting filesystem metadata
  // from S… | Apple Developer
  // Forums](https://developer.apple.com/forums/thread/667379)
  let u = url as NSURL
  do {
    try u.setResourceValue(mergedtagset, forKey: .tagNamesKey)
  } catch {
    print("can't set the keys. Sigh")
  }
}
