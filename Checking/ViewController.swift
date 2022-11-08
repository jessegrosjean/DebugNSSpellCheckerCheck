import Cocoa

extension NSSpellChecker.OptionKey {
    static var suppressKeyEventData = Self(rawValue: "SuppressKeyEventData")
}

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        // NOTE: These comments are only true if you don't pass in .suppressKeyEventData
        // Comment that option out to see the standard behavior, keep it in if you want correction results.
        //
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
    
    func performCheck(_ string: String, selection: NSRange? = nil) {
        let types: NSTextCheckingResult.CheckingType = [.correction, .spelling]
        let utf16Count = string.utf16.count
        let selection = selection ?? .init(utf16Count..<utf16Count)
        let range: NSRange = .init(0..<utf16Count)
        
        let results = NSSpellChecker.shared.check(
            string,
            range: range,
            types: types.rawValue,
            options: [
                .selectedRange : NSValue(range: selection),
                .suppressKeyEventData: true, // private, needed for corrections
            ],
            inSpellDocumentWithTag: 0,
            orthography: nil,
            wordCount: nil
        )
                
        let resultString = "Inputs:\(string), \(range), \(selection)\nResults: \"\(string)\"\n\(results)"
        
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
        self.performCheck(
            self.textField.stringValue,
            selection: (self.view.window?.fieldEditor(false, for: self.textField) as? NSTextView)?.selectedRange()
        )
    }
    
}

