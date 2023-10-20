import Foundation

// TODO(rjk): reset doesn't seem to be useful?
func setFinderTags(_ tags: [String], _ fn: String, _ reset: Bool) {
  // Makes a url corresponding to a specific file path.
  let url = URL.init(fileURLWithPath: fn)

  // Tries to retreive the tagNames resource for this URL. This has three
  // outcomes: success, nil (meaning that there are no tagNames and throws
  // for an I/O error or some such.
  let urvs = try? url.resourceValues(forKeys: [
    URLResourceKey.tagNamesKey
  ])

  // Give up if there was some kind of I/O error
  guard let r_urvs = urvs else {
    print("setFinderTags resourceValues failed. \(fn)  probably doesn't exist")
    return
  }

  // The file existed and had resources. If the tagNames are nil, it means
  // that everything is good except that there aren't any tagNames set on
  // this file.
  if let r_tagnames = r_urvs.tagNames {
    // Merge the old and new tags.
    let tagset = Set(r_tagnames)
    let mergedtagset = tagset.union(tags).map { $0 }
    setHelper(url, mergedtagset)
  } else {
    setHelper(url, tags)
  }
}

func setHelper(_ url: URL, _ mergedtagset: [String]) {
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
