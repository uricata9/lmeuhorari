#INPUT set of roomsN R, set of talksN N, set of timeslotsN T
#OUTPUT A list of assignments to roomsN and timeslotsN
#alloc=0 <- number of allocated talksN
#allocated={} <- set of allocated talksN

#while |N| > alloc do:
#
from models import Talk

class Greedy:

    def get_primary_related(self,talk_i, talksN,matrixP):

        primary_list=[];
        for c in range(talksN,start=1):
            if matrixP[talk_i][c]:
                primary_list.append(c)

        return primary_list

    def is_feasable(self,talk_i,room_i,timeslot_i,talksN,matrixP,solution,d):
        
        primary_list = self.get_primary_related(talk_i,talksN,matrixP)
        for s in solution:
            if s.number in primary_list:
                if s.timeslot == timeslot_i or abs(s.timeslot - timeslot_i) > d:
                    return False
            if s.room == room_i:
                return False

        return True



    def greedy_cost_function(self,talk_i,room_i,timeslot_i,talksN,roomsN,timeslotsN,matrixP,matrixS,solution,d):
        
        if self.is_feasable(talk_i,room_i,timeslot_i,talksN,matrixP,solution,d):
            
        else:
            return -1


    def greedy_constructive_function(self,talksN,roomsN,timeslotsN,matrixP,matrixS,d):
        
        allocated_talksN=[]
        solution=[]
        while (talksN > len(allocated_talksN)):
            cost_i=10000
            talk_i=-1
            room_i=-1
            timeslot_i=-1
            for t in range(talksN,start=1):
                if not t in allocated_talksN:
                    for r in range(roomsN,start=1):
                        for s in range(timeslotsN,start=1):

                            costT = self.greedy_cost_function(t,r,s,talksN,roomsN,timeslotsN,matrixP,matrixS,solution,d)
                            if costT < cost_i and costT != -1:
                                cost_i = costT
                                talk_i = t
                                room_i = r
                                timeslot_i = s
            
            if talk_i != -1:
                allocated_talksN.append(t)
                talkS = Talk()
                talkS.room=room_i
                talkS.number=talk_i
                talkS.timeslot=timeslot_i
                solution.append(talkS)
            else:
                print('unable to allocate all talksN')
                break
        return solution

