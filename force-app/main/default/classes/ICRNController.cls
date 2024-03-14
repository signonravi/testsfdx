Public class ICRNController{
    
    public static String icrngenerator(Decimal amount, String expdt, String crn){
        /*
        String amtstr=String.valueof(amount);
        if(amtstr.indexOf('.') == -1){
            // whole number
        } else { // decimal value 
        }
        */
        Integer amtint = Integer.valueof(amount * 100);
        String icrn = String.valueof(mod10v01(amtint)) + String.valueof(mod10v05(amtint)) ;
        icrn += calcdiffdays(expdt);
        icrn += String.valueof(crn);
        icrn += String.valueof(mod10v10(icrn));
        return icrn;
    }
    
   public static integer mod10v01(integer origNbr){
        String origStr = String.valueof(origNbr).reverse();
        Integer checksum = 0;
        for(Integer i=0; i<=origStr.length()-1; i++){
               if(math.mod(i,2) !=0) 
                { checksum = checksum + Integer.valueof(origStr.substring(i,i+1));  
                } else { 
                  checksum=checksum + getaccnbr(Integer.valueof(origStr.substring(i,i+1))*2);   
                }
            }
        return math.mod((10 - math.mod(checksum,10)),10);
    }

   public static integer mod10v05(integer origNbr){
        String origStr = String.valueof(origNbr);
        Integer checksum=0;
        Integer pos=12;
        for(Integer i = origStr.length()-1; i >= 0; i--){
            checksum=checksum+ Integer.valueof(origstr.substring(i,i+1))*pos;
            pos--;
        }
        return math.mod(checksum,10);
   } 
    
    public static integer mod10v10(String origNbr){
        String origStr = String.valueof(origNbr);
        Integer checksum = 0;
        for(Integer i=0; i<=origStr.length()-1; i++){
            if(math.mod(i,3)==0){
              checksum=checksum + Integer.valueof(origStr.substring(i,i+1))*3;
            } else if (math.mod(i,3)==1){
              checksum=checksum + Integer.valueof(origStr.substring(i,i+1))*7;
            } else
            { checksum=checksum + Integer.valueof(origStr.substring(i,i+1));
            }
    	}
        return math.mod((10 - math.mod(checksum,10)),10);
   }
   
    private static Integer getaccnbr(Integer origNbr){
        Integer accumulator=0;
        String origString=String.valueof(origNbr);
        for(Integer i=0;i<origString.length();i++){
            accumulator=accumulator+integer.valueof(origString.substring(i,i+1));
            }

        if(accumulator/10 > 0){
            return getaccnbr(accumulator);
        } else {
            return accumulator;
        }
    }
	
    public static Integer calcdiffdays(String dateparam){
        List<String> datearray = dateparam.split('/');
        date expdt = date.newInstance(Integer.valueof(datearray[2]),Integer.valueof(datearray[1]),
                                      Integer.valueof(datearray[0]));
        date basedate = date.newInstance(2010, 1, 1);
        Integer daysdiff = basedate.daysBetween(expdt);
        return math.mod(daysdiff,1000);
    }
  
}