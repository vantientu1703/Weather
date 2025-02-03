import UIKit

protocol CustomScrollViewDelegate: class {
    func scrollView(_ scrollView: CustomScrollView, didSelectItemAt index: Int)
    func scrollView(_ scrollView: CustomScrollView, didScrollToAt index: Int)
}

extension CustomScrollViewDelegate {
    func scrollView(_ scrollView: CustomScrollView, didSelectItemAt index: Int) {
        
    }
    
    func scrollView(_ scrollView: CustomScrollView, didScrollToAt index: Int) {
        
    }
}

protocol CustomScrollViewDataSource: class {
    func numberOfRows() -> Int
    func scrollView(_ scrollView: CustomScrollView, cellForRowAt index: Int) -> UIView
}

class CustomScrollView: UIScrollView {
    
    weak var kDelegate: CustomScrollViewDelegate?
    weak var dataSource: CustomScrollViewDataSource?
    fileprivate var numberOfRows: Int {
        guard let number = self.dataSource?.numberOfRows() else {
            return 0
        }
        return number
    }
    
    fileprivate var contentViews: [UIView] = []
    fileprivate var currentIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configView()
    }
    
    private func configView() {
        self.clipsToBounds = true
        self.delegate = self
        self.frame = UIScreen.main.bounds
        print(UIScreen.main.bounds.width)
    }
    
    func reloadData() {
        self.contentViews.forEach{ $0.removeFromSuperview() }
        self.contentViews.removeAll()
        
        let mainSize = UIScreen.main.bounds.size
        self.contentSize = CGSize(width: mainSize.width * CGFloat(self.numberOfRows), height: mainSize.height)
        for i in 0..<self.numberOfRows {
            self.insert(at: i)
        }
    }
    
    private func insert(at index: Int) {
        guard let view = self.dataSource?.scrollView(self, cellForRowAt: index) else { return }
        view.frame = UIScreen.main.bounds
        view.frame.origin.x = CGFloat(index) * view.frame.size.width
        self.addSubview(view)
        
        self.contentViews.append(view)
    }
    
    func scrollTo(at index: Int) {
        let offsetX = self.frame.size.width * CGFloat(index)
        self.setContentOffset(CGPoint(x: offsetX, y: self.contentOffset.y), animated: false)
    }
    
    func scrollToBottom() {
        self.scrollTo(at: self.numberOfRows - 1)
    }
    
    func scrollToTop() {
        self.scrollTo(at: 0)
    }
    
    func cellForRow(at index: Int) -> UIView? {
        if index < self.numberOfRows {
            return self.contentViews[index]
        }
        return nil
    }
}

extension CustomScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollToCurrentIndex()
        self.kDelegate?.scrollView(self, didScrollToAt: self.currentIndex)
    }
    
    private func scrollToCurrentIndex() {
        let contentOffset = self.contentOffset
        let width = self.frame.size.width
        let page = Int(abs(round(contentOffset.x / width)))
        if page != self.currentIndex {
            self.currentIndex = page
        }
    }
}
