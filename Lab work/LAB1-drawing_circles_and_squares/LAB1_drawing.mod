MODULE LAB1_drawing
    !Targets defined from modeling.
    CONST robtarget P1:=[[0,500,0],[1,0,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget P2:=[[200,500,0],[1,0,0,0],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget P3:=[[0,600,0],[1,0,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget P4:=[[200,600,0],[1,0,0,0],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    !Variables
    VAR num input := 0;


     PROC main()
        !define_var;
        
        WHILE TRUE DO
            input := 0;
            TPErase;
            TPReadFK input,"Velg en aksjon","P1","P2","P3","P4","Tegn";
            choose_action(input);
        ENDWHILE
        
    ENDPROC
    
    PROC choose_action(num input)
        !A simple procedure to decide the arms action depending on the input value from user
        IF input = 1 THEN
            draw_dot(P1);
           
        ELSEIF input = 2 THEN
            draw_dot(P2);
          
        ELSEIF input = 3 THEN
            draw_dot(P3);
           
        ELSEIF input = 4 THEN
            draw_dot(P4);
           
        ELSE
            !Draw circles, P1 then P2
            draw_circle(P1);
            draw_circle(P2);
                
            !Draw rectangles, P3 then P4
            draw_rectangle(P3);
            draw_rectangle(P4);
            
        ENDIF    
    ENDPROC
    
    PROC draw_rectangle(robtarget P)
        !Define variables for offsets
        VAR robtarget Q1;
        VAR robtarget Q2;
        VAR robtarget Q3;
        VAR robtarget home;
        
        !Offset for rectangle, l * w = 70mm * 70mm
        home := Offs(P,0,0,-100);
        Q1 := Offs(P,0,70,0);
        Q2 := Offs(P,70,70,0);
        Q3 := Offs(P,70,0,0);
        
        !Movements to draw rectangle
        MoveJ home,v1000,fine,blyant\WObj:=WO_flate;
        
        MoveL P,v1000,fine,blyant\WObj:=WO_flate;
        MoveL Q1,v1000,fine,blyant\WObj:=WO_flate;
        MoveL Q2,v1000,fine,blyant\WObj:=WO_flate;
        MoveL Q3,v1000,fine,blyant\WObj:=WO_flate;
        MoveL P,v1000,fine,blyant\WObj:=WO_flate;
        
        MoveJ home,v1000,fine,blyant\WObj:=WO_flate;
    ENDPROC
    
    
    PROC draw_circle(robtarget P)
        !Define variables for offset
        VAR robtarget Q1;
        VAR robtarget Q2;
        VAR robtarget Q3;
        VAR robtarget Q4;
        VAR robtarget home;
        
        !Offset for circle, R = 35mm
        home := Offs(P,0,0,-100);
        Q1 := Offs(P,0,-35,0);
        Q2 := Offs(P,35,0,0);
        Q3 := Offs(P,0,35,0);
        Q4 := Offs(P,-35,0,0);
        
        !Movements to draw circle
        MoveJ home,v1000,fine,blyant\WObj:=WO_flate;
        
        MoveL Q1,v1000,fine,blyant\WObj:=WO_flate;
        MoveC Q2,Q3,v1000,fine,blyant\WObj:=WO_flate;
        MoveC Q4,Q1,v1000,fine,blyant\WObj:=WO_flate;
        
        MoveJ home,v1000,fine,blyant\WObj:=WO_flate;   
    ENDPROC
    
    PROC draw_dot(robtarget P)
        !Define variables for offset
        VAR robtarget home;
        
        !Offset for dot, 100mm over dot
        home := Offs(P,0,0,-100);
        
        !Movements to draw dot
        MoveL home,v1000,fine,blyant\WObj:=WO_flate;
        
        MoveL P,v1000,fine,blyant\WObj:=WO_flate;
        
        MoveL home,v1000,fine,blyant\WObj:=WO_flate;
    ENDPROC
    
ENDMODULE
