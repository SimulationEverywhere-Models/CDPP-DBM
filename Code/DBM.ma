#include (DBM.inc)
[top]
components : DBM

[DBM]
type : cell
dim : (10,10,7)
delay : transport
defaultDelayTime  : 1
border : wrapped 
neighbors : DBM(-2,-2,0) DBM(-2,-1,0) DBM(-2,0,0) DBM(-2,1,0) DBM(-2,2,0)
neighbors : DBM(-1,-2,0) DBM(-1,-1,0) DBM(-1,0,0) DBM(-1,1,0) DBM(-1,2,0)
neighbors : DBM(0,-2,0)  DBM(0,-1,0)  DBM(0,0,0)  DBM(0,1,0)  DBM(0,2,0)
neighbors : DBM(1,-2,0)  DBM(1,-1,0)  DBM(1,0,0)  DBM(1,1,0)  DBM(1,2,0)
neighbors : DBM(2,-2,0)  DBM(2,-1,0)  DBM(2,0,0)  DBM(2,1,0)  DBM(2,2,0)
neighbors : DBM(0,0,-1) DBM(0,0,-2) DBM(0,0,-3) DBM(0,0,-4) DBM(0,0,-5) DBM(0,0,-6)
initialvalue : -1

localtransition : DBM-rule
zone : Cabbage      		{ (0,0,0)..(9,9,0) }
zone : Larva        		{ (0,0,1)..(9,9,1) }
zone : Pupae        		{ (0,0,2)..(9,9,2) }
zone : Adult_DBM_M  		{ (0,0,3)..(9,9,3) }
zone : Adult_DBM_F  		{ (0,0,4)..(9,9,4) }
zone : Adult_Parasitoid_M   { (0,0,5)..(9,9,5) }
zone : Adult_Parasitoid_F	{ (0,0,6)..(9,9,6) }
[Cabbage]
rule : {if(uniform(0,1) < #Macro(p_initialPlant), 1 , 0)}  1  { (0,0,0) = -1 } 
rule : {(0,0,0)} 1 { t } 

[Larva]

rule : 0 1 { (0,0,0) = -1 }
rule : 20 1 { trunc((0,0,-4)) = 11 and (0,0,0) = 0 }
rule : 60 1 { trunc((0,0,-2)) = 11 and trunc((0,0,0)) = 21 }
rule : { (0,0,0) + 1/200 } 1 { trunc((0,0,0)) = 60 }
rule : { (0,0,0) + trunc(uniform(1,3)) } 1 { trunc((0,0,0)) = 61 }
rule : 0 1 { trunc((0,0,0)) >= 61}
rule : { (0,0,0) + 1/100 } 1 { trunc((0,0,0)) = 20 }
rule : { (0,0,0) + 1/200 } 1 { trunc((0,0,0)) = 21 }
rule : { (0,0,0) + 1 } 1 { trunc((0,0,0)) = 22 }
rule : 0 1 { trunc((0,0,0)) = 23 }
rule : {(0,0,0)} 1 { t } 

[Pupae]
rule : 0 1 { (0,0,0) = -1 }
rule : 80 1 { trunc((0,0,-1)) = 22 }
rule : { (0,0,0) + 1/100 } 1 { trunc((0,0,0)) = 80}
rule : { (0,0,0) + trunc(uniform(1,3)) } 1 { trunc((0,0,0)) = 81}
rule : 0 1 { trunc((0,0,0)) >= 81}
rule : {(0,0,0)} 1 { t } 

[Adult_DBM_M]
  

rule : { if(uniform(0,1) < #Macro(p_initialDBM), 1 , 0) }  1  { (0,0,0) = -1 }
rule : 0 1 { remainder((0,0,0),1) > 0.32 } 
rule : 1 1 { trunc((0,0,-1)) = 82}
rule : { (0,0,0) + 9 + 1/1000 } 1 { trunc((0,0,0)) = 1 and trunc((0,0,-6)) = 10 }
rule : { (0,0,0) + 1 + 1/1000 } 1 { trunc((0,0,0)) = 10 }
rule : { (0,0,0) - 10 + 1/1000 } 1 { trunc((0,0,0)) = 11 }

rule : { (0,0,0) + trunc(uniform(1,9)) + 1/1000 } 1 { trunc( (0,0,0) ) = 1 and (0,0,0) != 0}

rule : { (1,0,0) - 1 + 1/1000} 1 { (0,0,0) = 0 and trunc( (1,0,0) ) = 2 }
rule : 0 1 { trunc( (0,0,0) ) = 2 and (-1,0,0) = 0 }

rule : { (1,-1,0) - 2  + 1/1000} 1 { (0,0,0) = 0 and trunc((1,-1,0)) = 3 }
rule : 0 1 { trunc( (0,0,0) ) = 3 and (-1,1,0) = 0 and trunc( (0,1,0) ) != 2 }

rule : { (0,-1,0) - 3 + 1/1000} 1 { (0,0,0) = 0 and trunc((0,-1,0)) = 4 }
rule : 0 1 { trunc((0,0,0)) = 4  and (0,1,0) = 0 and trunc(( 1,1,0)) != 2 and trunc((1,0,0)) != 3 } 
 
rule : { (-1,-1,0) - 4 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,-1,0)) = 5 } 
rule : 0 1 { trunc((0,0,0)) = 5 and (1,1,0) = 0 and trunc((2,1,0)) != 2 and trunc((2,0,0)) != 3 and trunc((1,0,0)) != 4 }

rule : { (-1,0,0) - 5 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,0,0)) = 6 }
rule : 0 1 { trunc((0,0,0)) = 6 and (1,0,0) = 0 and trunc((2,0,0)) != 2 and trunc((2,-1,0)) != 3 and trunc((1,-1,0)) != 4 and trunc((0,-1,0)) != 5 } 

rule : { (-1,1,0) - 6 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,1,0)) = 7 }
rule : 0 1 { trunc((0,0,0)) = 7 and (1,-1,0) = 0 and trunc((2,-1,0)) != 2 and trunc((2,-2,0)) != 3 and trunc((1,-2,0)) != 4 and trunc((0,-2,0)) != 5 and trunc((0,-1,0)) != 6 }
    
rule : { (0,1,0) - 7 + 1/1000} 1 { (0,0,0) = 0 and trunc((0,1,0)) = 8 }
rule : 0 1 { trunc((0,0,0)) = 8 and (0,-1,0) = 0 and trunc((1,-1,0)) != 2 and trunc((1,-2,0)) != 3 and trunc((0,-2,0)) != 4 and trunc((-1,-2,0)) != 5 and trunc((-1,-1,0)) != 6 and trunc((-1,0,0)) != 7  }

rule : { (1,1,0) - 8 + 1/1000} 1 { (0,0,0) = 0 and trunc((1,1,0)) = 9 }
rule : 0 1 { trunc((0,0,0)) = 9 and (-1,-1,0) = 0 and trunc((0,-1,0)) != 2 and trunc((0,-2,0)) != 3 and  trunc((-1,-2,0)) != 4 and trunc((-2,-2,0)) != 5 and trunc((-2,-1,0)) != 6 and trunc((-2,0,0)) !=7  and trunc((-1,0,0)) != 8  }

rule : { remainder((0,0,0),1) + 1 + 1/1000} 1 { (0,0,0) > 0 }
rule : 0 1 { t }
   

[Adult_DBM_F]

rule : { if(uniform(0,1) < #Macro(p_initialDBM), 1 , 0) }  1  { (0,0,0) = -1 }
rule : 0 1 { remainder((0,0,0),1) > 0.32 } 
rule : 1 1 { trunc((0,0,-2)) = 83}
rule : { (0,0,0) + 9 + 1/1000 } 1 { trunc((0,0,0)) = 1 and trunc((0,0,-4)) = 1 }
rule : { (0,0,0) + 1/1000 } 1 { trunc((0,0,0)) = 10 and trunc((0,0,-1)) != 11}
rule : { (0,0,0) + 1 + 1/1000 } 1 { trunc((0,0,0)) = 10 and trunc((0,0,-1)) = 11}
rule : { (0,0,0) - trunc(uniform(1,9)) + 1/1000 } 1 { trunc((0,0,0)) = 11 } 
rule : { (0,0,0) + trunc(uniform(1,9)) + 1/1000 } 1 { trunc( (0,0,0) ) = 1 and (0,0,0) != 0}

rule : { (1,0,0) - 1 + 1/1000} 1 { (0,0,0) = 0 and trunc( (1,0,0) ) = 2 }
rule : 0 1 { trunc( (0,0,0) ) = 2 and (-1,0,0) = 0 }

rule : { (1,-1,0) - 2  + 1/1000} 1 { (0,0,0) = 0 and trunc((1,-1,0)) = 3 }
rule : 0 1 { trunc( (0,0,0) ) = 3 and (-1,1,0) = 0 and trunc( (0,1,0) ) != 2 }

rule : { (0,-1,0) - 3 + 1/1000} 1 { (0,0,0) = 0 and trunc((0,-1,0)) = 4 }
rule : 0 1 { trunc((0,0,0)) = 4  and (0,1,0) = 0 and trunc(( 1,1,0)) != 2 and trunc((1,0,0)) != 3 } 
 
rule : { (-1,-1,0) - 4 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,-1,0)) = 5 } 
rule : 0 1 { trunc((0,0,0)) = 5 and (1,1,0) = 0 and trunc((2,1,0)) != 2 and trunc((2,0,0)) != 3 and trunc((1,0,0)) != 4 }

rule : { (-1,0,0) - 5 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,0,0)) = 6 }
rule : 0 1 { trunc((0,0,0)) = 6 and (1,0,0) = 0 and trunc((2,0,0)) != 2 and trunc((2,-1,0)) != 3 and trunc((1,-1,0)) != 4 and trunc((0,-1,0)) != 5 } 

rule : { (-1,1,0) - 6 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,1,0)) = 7 }
rule : 0 1 { trunc((0,0,0)) = 7 and (1,-1,0) = 0 and trunc((2,-1,0)) != 2 and trunc((2,-2,0)) != 3 and trunc((1,-2,0)) != 4 and trunc((0,-2,0)) != 5 and trunc((0,-1,0)) != 6 }
    
rule : { (0,1,0) - 7 + 1/1000} 1 { (0,0,0) = 0 and trunc((0,1,0)) = 8 }
rule : 0 1 { trunc((0,0,0)) = 8 and (0,-1,0) = 0 and trunc((1,-1,0)) != 2 and trunc((1,-2,0)) != 3 and trunc((0,-2,0)) != 4 and trunc((-1,-2,0)) != 5 and trunc((-1,-1,0)) != 6 and trunc((-1,0,0)) != 7  }

rule : { (1,1,0) - 8 + 1/1000} 1 { (0,0,0) = 0 and trunc((1,1,0)) = 9 }
rule : 0 1 { trunc((0,0,0)) = 9 and (-1,-1,0) = 0 and trunc((0,-1,0)) != 2 and trunc((0,-2,0)) != 3 and  trunc((-1,-2,0)) != 4 and trunc((-2,-2,0)) != 5 and trunc((-2,-1,0)) != 6 and trunc((-2,0,0)) !=7  and trunc((-1,0,0)) != 8  }

rule : { remainder((0,0,0),1) + 1 + 1/1000} 1 { (0,0,0) > 0 }
rule : 0 1 { t }

[Adult_Parasitoid_M]
rule : { if(uniform(0,1) < #Macro(p_initialParasitoid), 1 , 0) }  1  { (0,0,0) = -1 }
rule : 0 1 { remainder((0,0,0),1) > 0.32 } 
rule : 1 1 { trunc((0,0,-4)) = 62}
rule : { (0,0,0) + 9 + 1/1000 } 1 { trunc((0,0,0)) = 1 and trunc((0,0,-6)) = 10 }
rule : { (0,0,0) + 1 + 1/1000 } 1 { trunc((0,0,0)) = 10 }
rule : { (0,0,0) - 10 + 1/1000 } 1 { trunc((0,0,0)) = 11 }

rule : { (0,0,0) + trunc(uniform(1,9)) + 1/1000 } 1 { trunc( (0,0,0) ) = 1 and (0,0,0) != 0}

rule : { (1,0,0) - 1 + 1/1000} 1 { (0,0,0) = 0 and trunc( (1,0,0) ) = 2 }
rule : 0 1 { trunc( (0,0,0) ) = 2 and (-1,0,0) = 0 }

rule : { (1,-1,0) - 2  + 1/1000} 1 { (0,0,0) = 0 and trunc((1,-1,0)) = 3 }
rule : 0 1 { trunc( (0,0,0) ) = 3 and (-1,1,0) = 0 and trunc( (0,1,0) ) != 2 }

rule : { (0,-1,0) - 3 + 1/1000} 1 { (0,0,0) = 0 and trunc((0,-1,0)) = 4 }
rule : 0 1 { trunc((0,0,0)) = 4  and (0,1,0) = 0 and trunc(( 1,1,0)) != 2 and trunc((1,0,0)) != 3 } 
 
rule : { (-1,-1,0) - 4 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,-1,0)) = 5 } 
rule : 0 1 { trunc((0,0,0)) = 5 and (1,1,0) = 0 and trunc((2,1,0)) != 2 and trunc((2,0,0)) != 3 and trunc((1,0,0)) != 4 }

rule : { (-1,0,0) - 5 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,0,0)) = 6 }
rule : 0 1 { trunc((0,0,0)) = 6 and (1,0,0) = 0 and trunc((2,0,0)) != 2 and trunc((2,-1,0)) != 3 and trunc((1,-1,0)) != 4 and trunc((0,-1,0)) != 5 } 

rule : { (-1,1,0) - 6 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,1,0)) = 7 }
rule : 0 1 { trunc((0,0,0)) = 7 and (1,-1,0) = 0 and trunc((2,-1,0)) != 2 and trunc((2,-2,0)) != 3 and trunc((1,-2,0)) != 4 and trunc((0,-2,0)) != 5 and trunc((0,-1,0)) != 6 }
    
rule : { (0,1,0) - 7 + 1/1000} 1 { (0,0,0) = 0 and trunc((0,1,0)) = 8 }
rule : 0 1 { trunc((0,0,0)) = 8 and (0,-1,0) = 0 and trunc((1,-1,0)) != 2 and trunc((1,-2,0)) != 3 and trunc((0,-2,0)) != 4 and trunc((-1,-2,0)) != 5 and trunc((-1,-1,0)) != 6 and trunc((-1,0,0)) != 7  }

rule : { (1,1,0) - 8 + 1/1000} 1 { (0,0,0) = 0 and trunc((1,1,0)) = 9 }
rule : 0 1 { trunc((0,0,0)) = 9 and (-1,-1,0) = 0 and trunc((0,-1,0)) != 2 and trunc((0,-2,0)) != 3 and  trunc((-1,-2,0)) != 4 and trunc((-2,-2,0)) != 5 and trunc((-2,-1,0)) != 6 and trunc((-2,0,0)) !=7  and trunc((-1,0,0)) != 8  }

rule : { remainder((0,0,0),1) + 1 + 1/1000} 1 { (0,0,0) > 0 }
rule : 0 1 { t }

[Adult_Parasitoid_F]
rule : { if(uniform(0,1) < #Macro(p_initialParasitoid), 1 , 0) }  1  { (0,0,0) = -1 }
rule : 0 1 { remainder((0,0,0),1) > 0.32 } 
rule : 1 1 { trunc((0,0,-5)) = 63}
rule : { (0,0,0) + 9 + 1/1000 } 1 { trunc((0,0,0)) = 1 and trunc((0,0,-5)) = 21 }
rule : { (0,0,0) + 1/1000 } 1 { trunc((0,0,0)) = 10 and trunc((0,0,-1)) != 11}
rule : { (0,0,0) + 1 + 1/1000 } 1 { trunc((0,0,0)) = 10 and trunc((0,0,-1)) = 11}
rule : { (0,0,0) - trunc(uniform(1,9)) + 1/1000 } 1 { trunc((0,0,0)) = 11 } 
rule : { (0,0,0) + trunc(uniform(1,9)) + 1/1000 } 1 { trunc( (0,0,0) ) = 1 and (0,0,0) != 0}

rule : { (1,0,0) - 1 + 1/1000} 1 { (0,0,0) = 0 and trunc( (1,0,0) ) = 2 }
rule : 0 1 { trunc( (0,0,0) ) = 2 and (-1,0,0) = 0 }

rule : { (1,-1,0) - 2  + 1/1000} 1 { (0,0,0) = 0 and trunc((1,-1,0)) = 3 }
rule : 0 1 { trunc( (0,0,0) ) = 3 and (-1,1,0) = 0 and trunc( (0,1,0) ) != 2 }

rule : { (0,-1,0) - 3 + 1/1000} 1 { (0,0,0) = 0 and trunc((0,-1,0)) = 4 }
rule : 0 1 { trunc((0,0,0)) = 4  and (0,1,0) = 0 and trunc(( 1,1,0)) != 2 and trunc((1,0,0)) != 3 } 
 
rule : { (-1,-1,0) - 4 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,-1,0)) = 5 } 
rule : 0 1 { trunc((0,0,0)) = 5 and (1,1,0) = 0 and trunc((2,1,0)) != 2 and trunc((2,0,0)) != 3 and trunc((1,0,0)) != 4 }

rule : { (-1,0,0) - 5 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,0,0)) = 6 }
rule : 0 1 { trunc((0,0,0)) = 6 and (1,0,0) = 0 and trunc((2,0,0)) != 2 and trunc((2,-1,0)) != 3 and trunc((1,-1,0)) != 4 and trunc((0,-1,0)) != 5 } 

rule : { (-1,1,0) - 6 + 1/1000} 1 { (0,0,0) = 0 and trunc((-1,1,0)) = 7 }
rule : 0 1 { trunc((0,0,0)) = 7 and (1,-1,0) = 0 and trunc((2,-1,0)) != 2 and trunc((2,-2,0)) != 3 and trunc((1,-2,0)) != 4 and trunc((0,-2,0)) != 5 and trunc((0,-1,0)) != 6 }
    
rule : { (0,1,0) - 7 + 1/1000} 1 { (0,0,0) = 0 and trunc((0,1,0)) = 8 }
rule : 0 1 { trunc((0,0,0)) = 8 and (0,-1,0) = 0 and trunc((1,-1,0)) != 2 and trunc((1,-2,0)) != 3 and trunc((0,-2,0)) != 4 and trunc((-1,-2,0)) != 5 and trunc((-1,-1,0)) != 6 and trunc((-1,0,0)) != 7  }

rule : { (1,1,0) - 8 + 1/1000} 1 { (0,0,0) = 0 and trunc((1,1,0)) = 9 }
rule : 0 1 { trunc((0,0,0)) = 9 and (-1,-1,0) = 0 and trunc((0,-1,0)) != 2 and trunc((0,-2,0)) != 3 and  trunc((-1,-2,0)) != 4 and trunc((-2,-2,0)) != 5 and trunc((-2,-1,0)) != 6 and trunc((-2,0,0)) !=7  and trunc((-1,0,0)) != 8  }

rule : { remainder((0,0,0),1) + 1 + 1/1000} 1 { (0,0,0) > 0 }
rule : 0 1 { t }

[DBM-rule]
rule : 0 1 { t } 
