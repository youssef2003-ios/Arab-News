import UIKit

class PostsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsTabelView.dataSource=self
        newsTabelView.delegate=self
        newsAPI.delegate=self
        newsAPI.fetchNews() // *******
    }
  
    var newsAPI = NewsAPI()
    
    var articles = [Article(title: "", url: "")]
  
    @IBOutlet weak var newsTabelView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
      
        let selectedRow = newsTabelView.indexPathForSelectedRow?.row
        detailVC.urlLink = articles[selectedRow!].url
    }

}

extension PostsViewController: UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = articles[indexPath.row].title
        
        return cell
    }
    
    
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
}

extension PostsViewController: NewsAPIDelegate{
  
    func didFetchPosts(posts: Posts) {
        articles = posts.articles
        DispatchQueue.main.async {
            self.newsTabelView.reloadData()

        }
        
    }
    
    func didFailWithError(error: Error?) {
        print(error!)
    }
    
    
}

