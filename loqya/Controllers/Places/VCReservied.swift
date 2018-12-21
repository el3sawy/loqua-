
import UIKit

class VCReservied: IndicatorViewController {
    
    @IBOutlet weak var tableViewPlaces: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("statyyyyyyy")
        self.startIndicatorWithWhiteView()
        self.tableViewPlaces.delegate = self
        self.tableViewPlaces.dataSource = self
        featchData()
    }
    
    private func featchData (){
        Api.instance.UserReservation(token: AuthServices.instance.UserToken) { (success) in
            if success {
                self.tableViewPlaces.reloadData()
                self.endIndicatroWithWhiteView()
               
            }
        }
    }
}

extension VCReservied: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Api.instance.arrUserReserved.count)
        return Api.instance.arrUserReserved.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableViewPlaces.dequeueReusableCell(withIdentifier: "TVCreserviedPlaces", for: indexPath) as? TVCreserviedPlaces {
            let place   = Api.instance.arrUserReserved[indexPath.row]
            cell.configartonCell(place: place)
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeID = Api.instance.arrUserReserved[indexPath.row].placeID
        performSegue(withIdentifier: "seg_Delails_Place", sender: placeID)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VCdelails = segue.destination as? VCdetailsPlace{
            VCdelails.placID = (sender as! Int)
        }
    }
    
}
