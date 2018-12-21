import UIKit

class VCopinionClients: IndicatorViewController ,UITableViewDelegate ,UITableViewDataSource {
    

    @IBOutlet weak var tableViewopinion: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicatorBegin()
        self.tableViewopinion.dataSource = self
        self.tableViewopinion.delegate = self
        Api.instance.getOpinionClients { (success) in
            if success == true{
                self.activityIndicatorEnd()
                self.tableViewopinion.reloadData()
                
            }
        }
    }

}

extension VCopinionClients  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Api.instance.arrayopnions.count)
        return Api.instance.arrayopnions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableViewopinion.dequeueReusableCell(withIdentifier: "OpinionClientsTVC", for: indexPath) as?  TVCOpinionClients{
            
            let opinion = Api.instance.arrayopnions[indexPath.row]
            print( opinion.clientName)
            cell.configrationCell(opinion: opinion)
            return cell
        }
        else{
        return UITableViewCell()
        }
    }
    
    
}
