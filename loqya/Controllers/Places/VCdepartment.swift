import UIKit
import NVActivityIndicatorView

class VCdepartment:  IndicatorViewController {
    
    @IBOutlet weak var tableViewDept: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet() {
            self.startIndicator()
            self.featchData()
        }
        else{
            
            Messages.showMessage(Message: "لا يوجد اتصال بالإنترنت", view: view)
        }
        navigationItem.title = "لقيا"
        tableViewDept.dataSource = self
        tableViewDept.delegate = self
    }
    
    func featchData(){
        Api.instance.getAllDepartment { (success) in
            if success {
                self.tableViewDept.reloadData()
                self.endIncator()
            }
        }
    }
}

extension VCdepartment : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Api.instance.departmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableViewDept.dequeueReusableCell(withIdentifier: "TVCdepartment", for: indexPath)
            as?TVCdepartment {
            
            let dept = Api.instance.departmentArray[indexPath.row]
            cell.configrationCell(dept: dept)
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = backgroundView
            
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dept = Api.instance.departmentArray[indexPath.row].deptId
        performSegue(withIdentifier: "segDept", sender: dept)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let tabBarContrller = segue.destination as? UITabBarController{
            
            if let navBarController = tabBarContrller.viewControllers![0] as? UINavigationController{
                if let mainVC = navBarController.viewControllers.first as? VCmain{
                    mainVC.getDataForSelecetedDept(dept_id:(sender as! Int))
                    
                }
            }
        }
    }
}
