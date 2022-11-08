I am `NSSpellChecker.shared.check` results seem to depend on some internal state. I'm trying to understand what that state is.

In particular if I programatically check "a" with all checking options on I don't see any corrections. On the other hand if I programatically check "a" in response to typing in a NSTextField then I do see a correction result that corrects "a" to "A".
