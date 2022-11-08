I am `NSSpellChecker.shared.check` results seem to depend on some internal state. I'm trying to understand what that state is.

In particular if I programatically check "a" with all checking options on I don't see any corrections. On the other hand if I programatically check "a" in response to typing in a NSTextField then I do see a correction result that corrects "a" to "A".

Seth Willits and Daniel Jalkut helped me find a workaround... it seems:

1. Cocoa text controls such as NSTextField share typing events with spell checker (through private api?)
2. NSSpellChecker.shared.check will only return correction results if those events are present
3. It turns out there is a undeclared NSSpellChecker.OptionKey that you can pass in to change this behavior
4. Pass `[NSSpellChecker.OptionKey(rawValue: "SuppressKeyEventData") : true]` into the check options and you will get correction results :)
