Read excel numeric strings with spaces                                                             
                                                                                                   
I expect xlconnect can do this, probably faster but I like                                         
xlsx colClasses option                                                                             
                                                                                                   
github                                                                                             
https://tinyurl.com/y6zsnbzy                                                                       
https://github.com/rogerjdeangelis/utl-excel-import-number-strings-with-spaces                     
                                                                                                   
SAS-L                                                                                              
https://listserv.uga.edu/cgi-bin/wa?A2=SAS-L;dad9c834.1906a                                        
                                                                                                   
macros                                                                                             
https://tinyurl.com/y9nfugth                                                                       
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories         
                                                                                                   
*_                   _                                                                             
(_)_ __  _ __  _   _| |_                                                                           
| | '_ \| '_ \| | | | __|                                                                          
| | | | | |_) | |_| | |_                                                                           
|_|_| |_| .__/ \__,_|\__|                                                                          
        |_|                                                                                        
;                                                                                                  
                                                                                                   
%utlfkil(d:/xls/spacenums.xlsx);                                                                   
libname xel "d:/xls/spacenums.xlsx";                                                               
data xel.have (keep=op nums);                                                                      
retain op "Roger";                                                                                 
  do num1=1234 to 1234567890 by 10000000;                                                          
    do num2=123 to 12345678 by 1123456;                                                            
       nums=catx(" ",num1,num2);                                                                   
         do num3=12345678912345 to 12345678912350 by 1;                                            
            nums=catx(" ",num1,num2,put(num3,z14.));                                               
            output;                                                                                
         end;                                                                                      
    end;                                                                                           
  end;                                                                                             
run;quit;                                                                                          
libname xel clear;                                                                                 
                                                                                                   
d:/xls/spacenums.xlsx                                                                              
                                                                                                   
+----+---------+--------------------------------+                                                  
|    |         |                                |                                                  
|    |    OP   |              NUMS              |                                                  
|----|---------|--------------------------------|                                                  
|  1 |   Roger |   1234 123 12345678912345      |                                                  
|  2 |   Roger |   1234 123 12345678912346      |                                                  
|  3 |   Roger |   1234 123 12345678912347      |                                                  
|  4 |   Roger |   1234 123 12345678912348      |                                                  
|  5 |   Roger |   1234 123 12345678912349      |                                                  
|  6 |   Roger |   1234 123 12345678912350      |                                                  
|  7 |   Roger |   1234 1123579 12345678912345  |                                                  
|  8 |   Roger |   1234 1123579 12345678912346  |                                                  
|  9 |   Roger |   1234 1123579 12345678912347  |                                                  
| 10 |   Roger |   1234 1123579 12345678912348  |                                                  
| 11 |   Roger |   1234 1123579 12345678912349  |                                                  
| 12 |   Roger |   1234 1123579 12345678912350  |                                                  
| 13 |   Roger |   1234 2247035 12345678912345  |                                                  
| 14 |   Roger |   1234 2247035 12345678912346  |                                                  
| 15 |   Roger |   1234 2247035 12345678912347  |                                                  
+----+---------+--------------------------------+                                                  
                                                                                                   
*            _               _                                                                     
  ___  _   _| |_ _ __  _   _| |_                                                                   
 / _ \| | | | __| '_ \| | | | __|                                                                  
| (_) | |_| | |_| |_) | |_| | |_                                                                   
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                  
                |_|                                                                                
;                                                                                                  
                                                                                                   
                                                                                                   
WORK.WANT total obs=8,184                                                                          
                                                                                                   
 Obs     OP                 NUMS                                                                   
                                                                                                   
   1    Roger    1234 123 12345678912345                                                           
   2    Roger    1234 123 12345678912346                                                           
   3    Roger    1234 123 12345678912347                                                           
   4    Roger    1234 123 12345678912348                                                           
   5    Roger    1234 123 12345678912349                                                           
   6    Roger    1234 123 12345678912350                                                           
   7    Roger    1234 1123579 12345678912345                                                       
   8    Roger    1234 1123579 12345678912346                                                       
   9    Roger    1234 1123579 12345678912347                                                       
  10    Roger    1234 1123579 12345678912348  ** length 27 (longer ones much later)                
                                                                                                   
 Variables in Creation Order                                                                       
                                                                                                   
#    Variable    Type    Len                                                                       
                                                                                                   
1    OP          Char      5                                                                       
2    NUMS        Char     34                                                                       
                                                                                                   
*                                                                                                  
 _ __  _ __ ___   ___ ___  ___ ___                                                                 
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                
| |_) | | | (_) | (_|  __/\__ \__ \                                                                
| .__/|_|  \___/ \___\___||___/___/                                                                
|_|                                                                                                
;                                                                                                  
                                                                                                   
%utl_submit_r64('                                                                                  
library(xlsx);                                                                                     
library(SASxport);                                                                                 
library(data.table);                                                                               
want<-read.xlsx("d:/xls/spacenums.xlsx",1                                                          
   ,colClasses=c(OP = "character", NUMS = "character"),stringsAsFactors=FALSE);                    
want<-as.data.table(want);                                                                         
head(want);                                                                                        
str(want);                                                                                         
write.xport(want,file="d:/xpt/want.xpt");                                                          
');                                                                                                
                                                                                                   
libname xpt xport "d:/xpt/want.xpt";                                                               
   data want;                                                                                      
     set xpt.want;                                                                                 
   run;quit;                                                                                       
libname xpt clear;                                                                                 
                                                                                                   
                                                                                                   
p to 40 obs from WANT total obs=8,184                                                              
                                                                                                   
Obs     OP                 NUMS                                                                    
                                                                                                   
  1    Roger    1234 123 12345678912345                                                            
  2    Roger    1234 123 12345678912346                                                            
  3    Roger    1234 123 12345678912347                                                            
  4    Roger    1234 123 12345678912348                                                            
  5    Roger    1234 123 12345678912349                                                            
  6    Roger    1234 123 12345678912350                                                            
  7    Roger    1234 1123579 12345678912345                                                        
  8    Roger    1234 1123579 12345678912346                                                        
  9    Roger    1234 1123579 12345678912347                                                        
 10    Roger    1234 1123579 12345678912348                                                        
 11    Roger    1234 1123579 12345678912349                                                        
 12    Roger    1234 1123579 12345678912350                                                        
 13    Roger    1234 2247035 12345678912345                                                        
 14    Roger    1234 2247035 12345678912346                                                        
 15    Roger    1234 2247035 12345678912347                                                        
                                                                                                   
                                                                                                   
