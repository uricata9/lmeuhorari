/*********************************************
 * OPL 20.1.0.0 Model
 * Author: catalan
 * Creation Date: May 15, 2021 at 11:40:53 AM
 *********************************************/

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

dvar boolean nrt[n in N, r in R, t in T];




// Define here your decision variables and any other auxiliary data.
// You can run an execute block if needed.
	
minimize (sum(t in T, r in R, n1 in N, n2 in N) (nrt[n1,r,t]+nrt[n2,r,t])*S[n1,n2] );

	//forall(n1,n2 in N: S[n1][n2]=1)
	  	//sum(nr)
 // Write here the objective function.

subject to {

  // Write here the constraints.
  
	forall(n in N)
    	sum(t in T,r in R) nrt[n,r,t] == 1;
  	//
	forall(r in R, t in T)
    	sum(n in N) nrt[n,r,t] <= 1;
   	
   	forall(t in T, n in N)
    	sum(r in R) nrt[n,r,t] <= 1;
   	
  	//forall(r in R)
  	  //	sum
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
    for (var j in R) {
  		for (var k in T) {
  			if (nrt[i][j][k]) {
  			  slotOfTalk[i]=k; 	
  			  roomOfTalk[i]=j;
  			}	
		}
	}	
  }   
    
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
 