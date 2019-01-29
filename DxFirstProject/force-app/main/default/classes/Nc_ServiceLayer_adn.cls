public class Nc_ServiceLayer_adn {
    /**
    * @Description - Method to Update records 
    * @name update Records
    * @param List<SObject> recordList - List of records to update
    * @param Boolean fullDataInsert - If false then partial insert else full data insert
    */
    public static Map<Boolean, List<sObject>> updateRecords(List<SObject> recordList, Boolean fullDataInsert, String type) {
        Map<Boolean, List<SObject>> mapStatusToList = new Map<Boolean, List<SObject>>();
        //List<DRMI_ErrorLogger.ErrorLog> listErrorLog = new List<DRMI_ErrorLogger.ErrorLog>();
        
        // DML statement
        Database.SaveResult[] saveResultList;
        if(type=='insert'){
            saveResultList = Database.insert(recordList, fullDataInsert);
        }else if(type=='update'){
            saveResultList = Database.update(recordList, fullDataInsert);
        }
        system.debug('Database.SaveResult[]Database.SaveResult[]'+saveResultList); 
        // Iterate through each returned result
        for (Integer i = 0; i < saveResultList.size(); i++) {
            Database.SaveResult saveResultInstance = saveResultList[i];
            sObject recordInstance = recordList[i];
            List<String> lstErrors = new List<String>();
            
            if (saveResultInstance.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted ID: ' + saveResultInstance.getId());
            } else {
                // Operation failed, so get all errors                
                for(Database.Error err : saveResultInstance.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Fields that affected this error: ' + err.getFields());
                    lstErrors.add(err.getMessage());
                    
                    /* Save the error in database
                    DRMI_ErrorLogger.ErrorLog errorLog = new DRMI_ErrorLogger.ErrorLog();
                    errorLog.functionalModule = 'Registration Enrollment Insert Failure';
                    errorLog.errorMessage = err.getMessage().left(200);
                    listErrorLog.add(errorLog);
					*/
                }
            }
            
            if (mapStatusToList.containsKey(saveResultInstance.isSuccess())) {
                mapStatusToList.get(saveResultInstance.isSuccess()).add(recordInstance);
            } else {
                mapStatusToList.put(saveResultInstance.isSuccess(), new List<sObject>{recordInstance});
            }
        }
        
        // Inserts all errors into database
        //DRMI_ErrorLogger.logError(listErrorLog);
        return mapStatusToList;
    } 
}