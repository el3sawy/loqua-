import UIKit

class VCopinionClients: IndicatorViewController ,UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet weak var tableViewopinion: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "اراء العملاء"
        self.tableViewopinion.dataSource = self
        self.tableViewopinion.delegate = self
        
        self.startIndicatorWithWhiteView()
        Api.instance.getOpinionClients { (success) in
            if success == true{
                self.tableViewopinion.reloadData()
                self.endIndicatroWithWhiteView()
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
