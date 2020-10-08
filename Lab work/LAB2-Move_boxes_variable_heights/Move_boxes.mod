MODULE Move_boxes
!***********************************************************
!
! Module:  Move boxes 
!
! Description: 
! This module will move 4 boxes between 4 different points depending on  
! user input
!
! Author: Daniel Stangeland.
!
! Version: 1.0
!
!***********************************************************
    ! Target
    CONST robtarget point1_pickup:=[[35,35,0],[1,0,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget point1_home:=[[35,35,-100],[1,0,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    ! Box positioning variables: 1 = P1, 2 = P2, 3 = P3, 4 = P4
    VAR num new_box_pos;
    VAR num current_box_pos := 0;
    
    ! Workobject variables
    VAR wobjdata woPlass{8};
    PERS wobjdata woTemp;
    
    PROC main()
        ! Home position
        MoveL point1_home,v500,fine,tool_suction\WObj:=LEVEL1_P1;
        ! Asks for initial position of boxes
        flexpedant_initial_pos;    
        
        WHILE TRUE DO
            ! Applies the correct settings for current box position
            current_current_box_position;
            
            ! User gets to choose where to place boxes
            flexpedant_new_position;
            
            ! Applies the correct settings for new box position
            new_current_box_position;      
            
            ! Moves the boxes
            FOR index FROM 1 TO 8 DO
                pickup_or_place(index);
            ENDFOR
            
            ! Remeberes new box position, which now becomes current_box_position
            current_box_pos := new_box_pos;
        ENDWHILE
        
    ENDPROC
    
    PROC flexpedant_initial_pos()
        TPErase;
        TPReadFK current_box_pos,"Hvor står boksene?","P1","P2","P3","P4",stEmpty;       
    ENDPROC 
    
    PROC current_current_box_position()
        IF current_box_pos = 1 THEN
            !The boxes are at P1
            woPlass{1} := LEVEL4_P1;
            woPlass{3} := LEVEL3_P1;
            woPlass{5} := LEVEL2_P1;
            woPlass{7} := LEVEL1_P1;        
        ELSEIF current_box_pos = 2 THEN
            !The boxes are at P2
            woPlass{1} := LEVEL4_P2;
            woPlass{3} := LEVEL3_P2;
            woPlass{5} := LEVEL2_P2;
            woPlass{7} := LEVEL1_P2;    
        ELSEIF current_box_pos = 3 THEN
            !The boxes are at P3
            woPlass{1} := LEVEL4_P3;
            woPlass{3} := LEVEL3_P3;
            woPlass{5} := LEVEL2_P3;
            woPlass{7} := LEVEL1_P3;
        ELSE
            !The boxes are at P4
            woPlass{1} := LEVEL4_P4;
            woPlass{3} := LEVEL3_P4;
            woPlass{5} := LEVEL2_P4;
            woPlass{7} := LEVEL1_P4;    
        ENDIF
    ENDPROC 
    
    PROC new_current_box_position()
        
        ! From "current_box_pos" to P1
        IF new_box_pos = 1 THEN
            woPlass{2} := LEVEL1_P1;
            woPlass{4} := LEVEL2_P1;
            woPlass{6} := LEVEL3_P1;
            woPlass{8} := LEVEL4_P1;     
            
        ! From "current_box_pos" to P2
        ELSEIF new_box_pos = 2 THEN
            woPlass{2} := LEVEL1_P2;
            woPlass{4} := LEVEL2_P2;
            woPlass{6} := LEVEL3_P2;
            woPlass{8} := LEVEL4_P2;
            
        ! From "current_box_pos" to P3
        ELSEIF new_box_pos = 3 THEN 
            woPlass{2} := LEVEL1_P3;
            woPlass{4} := LEVEL2_P3;
            woPlass{6} := LEVEL3_P3;
            woPlass{8} := LEVEL4_P3; 
            
        ! From "current_box_pos" to P4    
        ELSE
            woPlass{2} := LEVEL1_P4;
            woPlass{4} := LEVEL2_P4;
            woPlass{6} := LEVEL3_P4;
            woPlass{8} := LEVEL4_P4;
        ENDIF 
    ENDPROC
    
    PROC flexpedant_new_position()
        new_box_pos := 0;
        TPErase;
        
        ! The options available on the flexpedant depends on where the boxes are placed.
        IF current_box_pos = 1 THEN
            TPReadFK new_box_pos,"Boksene står i P1. Hvor skal de flyttes?",stEmpty,"Til P2","Til P3","Til P4",stEmpty;   
        ELSEIF current_box_pos = 2 THEN 
            TPReadFK new_box_pos,"Boksene står i P2. Hvor skal de flyttes?","Til P1",stEmpty,"Til P3","Til P4",stEmpty;
        ELSEIF current_box_pos = 3 THEN
            TPReadFK new_box_pos,"Boksene står i P3. Hvor skal de flyttes?","Til P1","Til P2",stEmpty,"Til P4",stEmpty;
        ELSE
            TPReadFK new_box_pos,"Boksene står i P4. Hvor skal de flyttes?","Til P1","Til P2","Til P3",stEmpty,stEmpty;
        ENDIF 
    ENDPROC
    
    PROC pickup_or_place(num index)
        woTemp := woPlass{index};
        MoveL point1_home,v500,fine,tool_suction\WObj:=woTemp;
        MoveL point1_pickup,v50,fine,tool_suction\WObj:=woTemp;
        
        ! Activates or de-activates suction tool
        IF index MOD 2 = 0 THEN
            ! If the robot is placing box
            SetDO DO10_1, 0;
        ELSE
            ! If the robot is picking up box
            SetDO DO10_1, 1;
        ENDIF
        
        MoveL point1_home,v500,fine,tool_suction\WObj:=woTemp;
    ENDPROC
ENDMODULE