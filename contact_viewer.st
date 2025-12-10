"Smalltalk-80 Contact Card Server - Viewer"
"Fixed version with proper error handling and compatibility"

| fileStream contactName contactPhone displayText textView topView textPane |

"Safely read the contact file"
[
    fileStream := FileStream oldFileNamed: 'contact.txt'.
    contactName := fileStream nextLine.
    contactPhone := fileStream nextLine.
    fileStream close.
] on: Error do: [:ex |
    contactName := 'Error reading file'.
    contactPhone := 'Check contact.txt exists'.
].

"Handle nil values"
contactName := contactName ifNil: ['No name found'].
contactPhone := contactPhone ifNil: ['No phone found'].

"Build display text"
displayText := 'Name: ', contactName, String cr, 'Phone: ', contactPhone.

"Create the top-level window"
topView := StandardSystemView new.
topView label: 'Contact Information'.
topView minimumSize: 300@120.
topView borderWidth: 2.

"Create text pane with scrolling support"
textPane := TextCollector new.
textPane show: displayText.

"Create text view"
textView := ScrollableView new.
textView model: textPane.
textView window: (0@0 extent: 300@120).
textView borderWidthLeft: 2 right: 2 top: 2 bottom: 2.

topView addSubView: textView.

"Display the window"
topView controller open.

"Alternative: Simple Transcript output"
"Uncomment if windowing doesn't work:"
"
Transcript clear.
Transcript show: '=== Contact Card Server ==='; cr; cr.
Transcript show: 'Name: '; show: contactName; cr.
Transcript show: 'Phone: '; show: contactPhone; cr.
"
