global class flowBatch implements Database.Batchable<sObject>,  Database.Stateful, schedulable  {

  private String query;
  private Map<String, Object> params = new Map<String, Object>();
  private List<String> str = new List<String>();
  private List<apex_triggered_flow__mdt> atfm = apex_triggered_flow__mdt.getAll().values();
  private String Object_Name = atfm[0].Object_Name__c;
  private String Where_Clause = atfm[0].Where_Clause__c;
  private String flowName = atfm[0].label;  
  private String soql='SELECT ID from '+ Object_Name +' WHERE ' + Where_Clause +' LIMIT ' + atfm[0].Limit_records__c;
  //private String soql= atfm[0].soql__c;
      
  global void execute(SchedulableContext SC) {
 	database.executebatch(new flowBatch());
    }
    
   global static void start(){
     String chronExpression = '0 15 * * * ?'; // schedule to run 15 min of every hour
     system.schedule('Scheduled Flow batch', chronExpression, new flowBatch());
	 }     
    
  global static void start(Integer secondstoadd){
      String jobName = 'Scheduled Flow batch Remaining';
     // check if any instance is already scheduled
     List<cronTrigger> crontrig = [SELECT id, cronjobdetail.name from CRONTRIGGER WHERE cronjobdetail.name = :jobName]; 
     if (crontrig.size()>0) System.abortjob(crontrig[0].Id);
     // Schedule another instance to run in specified seconds
     Datetime sysTime = System.now().addSeconds( secondstoadd );      
     String chronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
	 system.schedule(jobName, chronExpression, new flowBatch());
	 }  

  // The batch job starts
  global Database.Querylocator start(Database.BatchableContext bc){
    // String query = soql +' LIMIT ' + atfm[0].Limit_records__c;
     return Database.getQuerylocator(soql);
     } 
  
  // The batch job executes and operates on one batch of records
  global void execute(Database.BatchableContext bc, List<Account> scope){
      for(Account acct:scope){
          str.add(acct.Id);  } 
      params.put('recordids',str);
      }
  
  // The batch job finishes
  global void finish(Database.BatchableContext bc){
      System.debug('finish parameters-->'+params);
      Flow.Interview myFlow = Flow.Interview.createInterview(flowName, params);
	  myFlow.start();
      
      //Reschedule job if more records exists
      List<Sobject> accts = Database.query(soql);
      if (accts.size() > 0) flowBatch.start(300); 
      }   
  }