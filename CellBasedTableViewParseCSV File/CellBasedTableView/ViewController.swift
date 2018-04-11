//
//  ViewController.swift
//  CellBasedTableView
//
//  Copyright © 2017 Knowstack. All rights reserved.
//

//Cell based NSTableView using datasource.
import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource  {
    
    @IBOutlet weak var tableView:NSTableView!
    
    var tableArray = [[String]] ()
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        // return count
        return self.tableArray.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        // var number_rows = tableArray.count
        // var number_cols = tableArray[row].count
        // print("number_rows = \(number_rows)")
        // print("number_cols  = \(number_cols)")
        
        if (row >= tableArray.count-1){
            return "-"
        }
        
        // check needs to be here if row <= number_rows and col <= number_cols
        
        if (tableColumn?.identifier)!.rawValue == "Col0" {
            if (tableArray[row].count < 1){
                return "-"
            }
            else{
                return self.tableArray[row][0]
            }
        }
        else if (tableColumn?.identifier)!.rawValue == "Col1" {
            if (tableArray[row].count < 2){
                return "-"
            }
            else{
                return self.tableArray[row][1]
            }
            //return self.tableArray[row][1]
        }
        else if (tableColumn?.identifier)!.rawValue == "Col2" {
            if (tableArray[row].count < 3){
                return "-"
            }
            else{
                return self.tableArray[row][2]
            }
            //return self.tableArray[row][2]
        }

        else if (tableColumn?.identifier)!.rawValue == "Col3" {
            if (tableArray[row].count < 4){
                return "-"
            }
            else{
                return self.tableArray[row][3]
            }
            //return self.tableArray[row][3]
        }
        else if (tableColumn?.identifier)!.rawValue == "Col4" {
            if (tableArray[row].count < 5){
                return "-"
            }
            else{
                return self.tableArray[row][4]
            }
            //return self.tableArray[row][4]
        }
        else {
            // default:
            //return  self.tableArray[row][0]
            return "-"
        }
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
        return cleanFile
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            // let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
    
    
    func parseCSV() {
        
        // var data = readDataFromCSV(fileName: "mappe1", fileType: "csv")
        var data = readDataFromCSV(fileName: "mappe1", fileType: "csv")
        data = cleanRows(file: data!)
        // let csvRows = csv(data: data!)
        
        //self.tableArray = csvRows
        self.tableArray = csv(data: data!)
        print(self.tableArray)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self // as? NSTableViewDelegate
        self.tableView.dataSource = self
        
        //
        parseCSV()
        
    }
}


