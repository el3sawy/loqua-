
import UIKit

class VCcommonQuestions: IndicatorViewController , UITableViewDelegate , UITableViewDataSource  {
    
    
    
    @IBOutlet weak var tableViewQuestions: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorBegin()
        self.tableViewQuestions.delegate = self
        self.tableViewQuestions.dataSource = self
        self.featchData()
    }
    // My Functions
    func featchData(){
        Api.instance.getCommonQuestions { (success) in
            if success{
                Api.instance.getCommonQuestions(complition: { (success) in
                    self.activityIndicatorEnd()
                    self.tableViewQuestions.reloadData()
                    print(Api.instance.arrayQuestions.count)
                })
            }
        }
    }
    
}

//---------------------------------Table View--------------
extension VCcommonQuestions {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Api.instance.arrayQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell  = tableViewQuestions.dequeueReusableCell(withIdentifier: "commonQuestions", for: indexPath) as? TVCcommonQuestions {
            
            let question = Api.instance.arrayQuestions[indexPath.row]
            cell.configrationCell(question: question)
            return cell
        }
        else{
        return UITableViewCell()
        }
    }
    
    
}
