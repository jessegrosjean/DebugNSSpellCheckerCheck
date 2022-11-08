import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // This seems needed in all both manual and programatic check cases
        // I don't know why, but if I don't initially check an empty string
        // then no matter input I never get "correction" the first time I
        // check a string.
        self.performCheck("")
    }
    
    override func viewDidAppear() {
        // I can continue this pattern as long as I want and I never
        // get text checking "corrections"
        //
        // On the other hand I can type "a" into the text field and I
        // immediatly get a correction that capitalizes to "A"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.performCheck("a") // no correction result
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // try again, still no correction result
                self.performCheck("b")
                // now trying typing a letter in text field, notice that you'll
                // get a correction result that capitlizes the letter.
            }
        }
    }

    func performCheck(_ string: String) {
        let results = NSSpellChecker.shared.check(
            string,
            range: .init(0..<string.utf16.count),
            types: NSTextCheckingAllTypes,
            options: nil,
            inSpellDocumentWithTag: 0,
            orthography: nil,
            wordCount: nil
        )
        
        let resultString = "Checking: \"\(string)\"\n\(results)"
        
        textView.textStorage?.beginEditing()
        textView.textStorage?.replaceCharacters(
            in: .init(0..<textView.textStorage!.length),
            with: resultString
        )
        textView.textStorage?.endEditing()
    }
    
}

extension ViewController: NSTextFieldDelegate {
    
    func controlTextDidChange(_ obj: Notification) {
        performCheck(textField.stringValue)
    }
    
}

