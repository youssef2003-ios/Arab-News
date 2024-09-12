
import UIKit
import WebKit

class DetailViewController: UIViewController {
    var urlLink: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label1.text = urlLink
       
        if NSURL(string: urlLink!) != nil {
            webView.load(NSURLRequest(url: NSURL(string: urlLink!)! as URL) as URLRequest)

        } else{
            print ("URL not found" )
        }
    }
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    
}
