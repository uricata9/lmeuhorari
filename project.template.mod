// PLEASE ONLY CHANGE THIS FILE WHERE INDICATED.

int n = ...;
int t = ...;
int r = ...;
int d = ...;

range N = 1..n;
range T = 1..t;
range R = 1..r;

int P[N][N] = ...;
int S[N][N] = ...;

dvar boolean nt[n in N, t in T];
dvar boolean nr[n in N, r in R];
dvar int RoomSlotTime[R][T];
dvar boolean RoomSlotTimeO[R][T];
int temps_total;
int z;

// Define here your decision variables and any other auxiliary data.
// You can run an execute block if needed.
execute {
  
	temps_total=t*(t+1)/2;
}	
	
	
minimize (sum(t in T, n1, n2 in N: S[n1,n2] == 1) (nt[n1,t]*nt[n2,t]));

	//forall(n1,n2 in N: S[n1][n2]=1)
	  	//sum(nr)
 // Write here the objective function.

subject to {

  // Write here the constraints.
  
	forall(n in N)
    	sum(t in T) nt[n,t] == 1;
  	//
	forall(n in N)
    	sum(r in R) nr[n,r] == 1;
  
  	forall (r in R, t in T)
  	  	sum(n in N) nr[n,r]*nt[n,t] <= 1; 
  	
  	forall(n1,n2 in N: P[n1,n2] == 1, t in T)
  	   	 nt[n1,t]+nt[n2,t] <= 1;
  	
  	forall(n1,n2 in N: P[n1,n2] == 1,t1,t2 in T)
  	   	 abs(nt[n1,t1]-nt[n2,t2]) <=d;
  	
  	//forall(t1,t2 in T: abs(t1-t2) <= d, n1,n2 in N: P[n1,n2] == 1)
  	  // 	nt[n1,t1]*nt[n2,t2] == 1;
  	  	
  	//forall (r in R)
  	  //	sum (t in T)rt[r,t]
  	  	
  	//forall(t in T)
  	  	//sum(n in N) nt[n,t] <= r;
  	 
  	//forall(r in R)
  	  	//sum(n in N) nt[n,r] <= t;
  	  	
	/*forall(n1,n2 in N : P[n1,n2] == 1)
  	  	sum(t in T) (nt[n1,t] + nt[n2,t]) <= 1;
  
	forall(t1,t2 in T: abs(t1-t2) <= d, n1,n2 in N: P[n1,n2] == 1)
  	   	(nt[n1,t1] + nt [n2,t2]) == 2;*/
  	   
}

execute {

  var slotOfTalk = new Array(n+1);
  var roomOfTalk = new Array(n+1);
  var talkOfSlotRoom = new Array(t+1);
  for (var i in T) talkOfSlotRoom[i] = new Array(r+1);
  for (var i in T) for (var k in R) talkOfSlotRoom[i][k] = 0;

  // Populate here arrays slotOfTalk, roomOfTalk, talkOfSlotRoom.
    
  for (var i in N) {
  	for (var j in T) {
  		if (nt[i][j]==1) slotOfTalk[i]=j; 		
	}
  }  	
  
  for (var i in N) {
  	for (var j in R) {
  		if (nr[i][j]==1)
  			roomOfTalk[i]=j;
	}
  }  
  
  for (var i in N) {
  	for (var j in R) {
  	  for (var k in T) {
  		if (nr[i][j]==1 && nt[i][k]==1)
  			talkOfSlotRoom[j][k]=i;
      }  	  
	}
  } 
  
  //talkOfSlotRoom=RoomSlotTime
  
    
  writeln();

  for (var j in N) {
    writeln("Talk " + j + " --> slot " + (slotOfTalk[j]) + ", room " + (roomOfTalk[j]));
  }

  writeln();

  for (var k in R) {
    write("\tRoom " + k);
  }

  writeln();
  
  for (var i in T) {
    write("Slot " + i);
    for (var k in R) {
      if (talkOfSlotRoom[i][k] == 0)
        write("\t------");
      else
        write("\tTalk " + talkOfSlotRoom[i][k]);
    }
    writeln();
  }
}
