# EasyUIKit
This library is a UIKit exntesions wrappers that group many repetetive functionality for creating any kind of UI(Kit) code into an easy chainable modifiers.

# Examples

```swift
var _lable = "new title"
    .label                                       |  lazy var _label: UILabel {
    .font(.caption)                              |      let lbl = UILabel()
    .textColor(.blue300)                         |      lbl.font = .caption
    .textAlignment(.center)                      |      lbl.textAlignment = .center
    .numOfLines(0)                               |      lbl.numOfLines = 0
    .lineSpacing(0.8)                            |      
    .letterSpacing(1.3)                          |      return lbl
                                                 |  }()    
                                                 |  ...    
                                                 |  ..    
                                                 |  // some where eles in the code:
                                                 |  func applyLineSpacing(_ spacing) {
                                                 |      let paragraph = NSMutableParagraphStyle()
                                                 |      paragraph.lineSpacing = spacing
                                                 |      paragraph.lineHeightMultiple = lineHeightMultiple
                                                 |      paragraph.alignment = _label.testAlignment
                                                 |
                                                 |      let text: NSMutableAttributedString
                                                 |      if let attributedText = attributedText {
                                                 |          text = NSMutableAttributedString(attributedString: attributedText)
                                                 |      } else {
                                                 |          text = NSMutableAttributedString(string: self.text ?? "")
                                                 |      }
                                                 |
                                                 |      text.addAttributes([NSAttributedString.Key.paragraphStyle: paragraph], 
                                                 |                         range: NSRange(location: 0, length: text.length))
                                                 |      _label.attributedText = text
                                                 | }
                                                 | ...
                                                 | ...
                                                 | func applyLetterSpacing(_ spacing: CGFloat) { .... }
                                                 
-------------------------------------------------|-------------------------------------------------------------------------------
var _tableView = UITableView()                   |  lazy var _tableView: UITableView {
    .register(cell: Cell.self)                   |      let tv = UITableView()
    .register(header: HeaderCell.self)           |      tv.register(header, forHeaderFooterViewReuseIdentifier: "SomeHeader")
    .backgroundColor(.lightGray)                 |      tv.register(cell, forCellReuseIdentifier: "SomeCell")
    .separator(style: .singleLine)               |      tv.separator = .singleLine
    .rowHeight(estimated: 40, automatic: true)   |      tv.background = .lightGray
    .hideFooterView()                            |      tv.estimatedRowHeight = 40
                                                 |      tv.rowHeight = UITableView.automaticDimension
                                                 |      tv.tableFooterView = UIView()
                                                 |      return tv
                                                 |  }()
----------------------------------------------------------------------------------------------------------------------------------
                                                 |
lazy var lblButton = "new button".button         |  lazy var _button: UIButton {
    .font(.system)                               |      let btn = UIButton(.custom)
    .textColor(.red)                             |      btn.setTitle("new button", for: .normal)
    .centerVertically(padding: 0.5)              |      btn.font = UIFont(.system)
    .tap(target: self, action: #selector(click)  |      btn.textColor = .red
                                                 |      
                                                 |      let sign = 1.0
                                                 |      let padding = 0.5
                                                 |      let titleSize = btn.titleLabel.size(withAttributes: [NSAttributedString.Key.font: btn.titleLabel!.font!])
                                                 |      
                                                 |      btn.titleEdgeInsets = UIEdgeInsets(top: (btn.imageView.size.height + padding) * sign, 
                                                 |                                         left: -btn.imageView.size.width, bottom: 0, right: 0)
                                                 |     
                                                 |      btn.imageEdgeInsets = UIEdgeInsets(top: -(btn.titleSize.height + padding) * sign, 
                                                 |                                         left: 0, bottom: 0, right: -titleSize.width)
                                                 |      btn.addTarget(self, action: #selector(click), for: .touchUpInside)
                                                 |      
                                                 |      return btn
                                                 |  }()
---------------------------------------------------------------------------------------------------------------------------------
                                                 | let row1 = UIStackView()
let row1 = [view1, view2].stack(.horizontal)     |  row1.axis = .horizontal
    .spacing(8)                                  |  row1.spacing = 8
                                                 |  row1.addArragnedView(view1)
let row2 = [view3, view4].stack(.horizontal)     |  row1.addArragnedView(view2)
    .spacing(8)                                  |
                                                 | let row 2 = UIStackView() 
let vStack = [row1, row2].stack(.vertical)       |  row2.axis = .horizontal
    .spacing(8)                                  |  row2.spacing = 8
                                                 |  row2.addArragnedView(view3)
                                                 |  row2.addArragnedView(view4)
                                                 |
                                                 | let vStack = UIStackView()
                                                 |  vStack.axis = .vertical
                                                 |  vStack.spacing = 8
                                                 |  vStack.addArragnedView(row1)
                                                 |  vStack.addArragnedView(row2)
```

## Authors
Shalom Shwaitzer, shalom.shwaitzer@gmail.com
eliransha88, eliransha88@gmail.com

## License
EasyUIKit is available under the MIT license. See the LICENSE file for more info.
