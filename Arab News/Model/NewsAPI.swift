import Foundation

protocol NewsAPIDelegate{
    func didFetchPosts(posts: Posts)
    func didFailWithError(error: Error?)
}

struct NewsAPI {
    
    var delegate: NewsAPIDelegate?
    
    func fetchNews(){
        
        // 1.Create URL
        let urlString = "https://newsapi.org/v2/top-headlines?sources=google-news-sa&apiKey=2524838879e349c8a7683c7496112fda"
        let url = URL(string: urlString)
        
        // 2.Create URLSession
        let session = URLSession(configuration: .default)
        
        // 3.Create Task
        let task = session.dataTask(with: url!) { data, urlResponse, error in
            if error != nil{
                print(error?.localizedDescription)
            } else{
                
                do{
                    let thisPost = try JSONDecoder().decode(Posts.self, from: data!)
                    delegate?.didFetchPosts(posts: thisPost)
                    
                } catch{
                    print(error)
                }
                
            }
        }
        
        // 4.Resume Task
        task.resume()
    }
    
}



