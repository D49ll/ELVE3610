MODULE Server_Client_Communication
    CONST robtarget home:=[[620,0,600],[0.5,0,0.866025404,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    VAR robtarget current_target;
    
    !SERVER COMMUNICATION
    VAR socketdev server;
    VAR socketdev client;
    
    !STRINGS
    VAR string client_ip;
    VAR string direction;
    VAR string dir_value;
    VAR string temp;
    VAR string py_str := "";
    !VAR string msg := "Hei Client";
    
    !INT VARIABLES
    VAR num x := 0;
    VAR num y := 0;
    VAR num z := 0;
    VAR num dir_num_value;
    VAR num str_len;
    
    VAR bool ok;
    
    PROC main()
        home_pos;
        current_target := home;
        
        client_communication;
        
        home_pos;        
    ENDPROC
    

  PROC client_communication()
        TPErase;
        SocketCreate server;
        SocketBind server, "127.0.0.1",2222;
        SocketListen server;
        SocketAccept server, client,\ClientAddress:=client_ip,\Time:=120;
        
        TPWrite "Client IP: " + client_ip;
        
        ! INPUT VALUE FROM PYTHON
        WHILE py_str <> "exit" DO
            SocketReceive client \Str:=py_str;
            TPWrite "mottatt string: " + py_str;
            recived_py_str;
            !SocketSend client \str:=msg;
        ENDWHILE
        
        SocketClose server;
        SocketClose client;    
    ENDPROC
    
    PROC recived_py_str()
        
        x := 0;
        y := 0;
        z := 0;
        
        IF py_str <> "exit" THEN
            str_len := StrLen(py_str);
            
            ! Find direction (z, y or z), which is first char in string
            direction := StrPart(py_str,1,1);
            ! Find direction value, which is after first char in string          
            dir_value := StrPart(py_str,2,(str_len-1));
            ! Convert string value to num value
            ok := StrToVal(dir_value,dir_num_value);
            
        
        
        ! Checks direction is valid and direction number is valid
        IF direction = "x" and ok THEN
            x := dir_num_value;            
        ELSEIF direction = "y" and ok THEN
            y := dir_num_value;
        ELSEIF direction = "z" and ok THEN
            z := dir_num_value;
        ELSEIF py_str = "set" THEN
            SetDO DO10_3, 0;
            SetDO DO10_2, 1;           
        ELSEIF py_str = "reset" THEN
            SetDO DO10_2, 0;
            SetDO DO10_3, 1;
        ELSE
            TPWrite "Input NOT valid:" + py_str;
            TPWrite "User input direction: " + direction;
            TPWrite "User input numbervalue: " + dir_value;
            TPWrite "The correct input needs TO have format: [direction][number].";
        ENDIF
        

               
        MoveL Offs(current_target,x,y,z),v1000,fine,Gripper_1\WObj:=wobj0;
        current_target := CRobT(\Tool:=Gripper_1\WObj:=wobj0);
        
        ENDIF
        
        x := 0;
        y := 0;
        z := 0;
        
    ENDPROC
   
    PROC home_pos()
        SetDO DO10_3, 0;
        SetDO DO10_2, 1;
        SetDO DO10_2, 0;
        
        MoveL home,v1000,z100,Gripper_1\WObj:=wobj0;
    ENDPROC
ENDMODULE