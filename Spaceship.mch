/* Spaceship
 * Author: Rehan Samarasekera
 * Creation date: 12/16/2018
 */
MACHINE
    Spaceship
    
SEES
    SpaceGrid

SETS
    // this set used for represent the spaceship movement 
   SPACESHIP_MOVEMENT_STATUS ={Spaceship_Hit_Asteroid,Spaceship_Moved,Spaceship_Is_Not_In_The_Grid,Warp_drive_Can_Not_Use_In_Current_Region,Spaceship_Can_not_Directly_Move,Spaceship_is_docked};
    
    // this set used for represent space game status
    GAME_STATUS = {Game_WON,Game_LOST,Game_Not_Over,Game_Start}
    
        
VARIABLES
    current_Location,
    current_Power,
    asteroid_Collision_Count,
    spaceship_Path
    
INVARIANT 
    // spaceship must move within the grid and its not should move through the asteroids
    current_Location : (NAT1 * NAT1)
    & current_Location : space_region_grid
    & current_Location /: astroids
    
    // Power is must have to move the spaceship 
    & current_Power : NAT
    
    // asteroid count is should have to make a mission report 
    & asteroid_Collision_Count : NAT
    
    // For track the spaceship movements,spaceship must move via the space region grid
    & spaceship_Path : seq(NAT1 * NAT1)
    & spaceship_Path : seq(space_region_grid)
    
INITIALISATION
    //Spaceship should start from the (1,1)coordinates
    current_Location := start_position
    
    // Initially spaceship has 100 of power
    || current_Power := 100
    
    //In the (1,1) coordinates spaceship not hit any asteroids
    || asteroid_Collision_Count := 0
    
    //clear spaceship path
    || spaceship_Path := []
    
    
OPERATIONS
    
    /* spaceship move up */
    display_spaceship_action_message <-- move_Up =    	
    
    //spaceship must inside the space region grid, current location should not be star base and current power should not be zero
        PRE ((current_Location : space_region_grid) & (display_spaceship_action_message : SPACESHIP_MOVEMENT_STATUS)& (current_Power >=5) &(current_Location /= starBase))
        THEN
            
                        // In the move up operation, y axis only change then its value should not be greater then grid height otherwise spaceship is out of the grid
             IF (prj2(NAT1, NAT1)(current_Location) + 1 > grid_height)
                THEN 
                    display_spaceship_action_message  := Spaceship_Is_Not_In_The_Grid 
            ELSIF
                
                        // spaceship hit asteroid 
                ((prj1(NAT1, NAT1)(current_Location), prj2(NAT1, NAT1)(current_Location) + 1) : astroids)
            THEN
                
                        // spaceship power reduce by 10 units
                    current_Power := current_Power - 10
                    
                        // asteroid count increment  
                    || asteroid_Collision_Count := asteroid_Collision_Count + 1
                    || display_spaceship_action_message := Spaceship_Hit_Asteroid                   
            ELSE
                
                        // normal move spaceship power reduce by 5 units
                    current_Power := current_Power -5      
                    
                        // spaceship move to next region
                    || current_Location := (prj1(NAT1, NAT1)(current_Location) |-> prj2(NAT1, NAT1)(current_Location) + 1)
                        
                        // add current location to spaceship path
                    || spaceship_Path := spaceship_Path <-  (prj1(NAT1, NAT1)(current_Location) |-> prj2(NAT1, NAT1)(current_Location)+1)
                    || display_spaceship_action_message := Spaceship_Moved
            END
       
        END;
		  
		  /* spaceship move down */
    display_spaceship_action_message <-- move_Down =    
    
        //spaceship must inside the space region grid, current location should not be star base and current power should not be zero
        PRE ((current_Location : space_region_grid) & (display_spaceship_action_message : SPACESHIP_MOVEMENT_STATUS)& (current_Power >=5)&(current_Location /= starBase))
        THEN
               // In the move up operation, y axis only change then its value should not be less then zero otherwise spaceship is out of the grid
             IF (prj2(NAT1, NAT1)(current_Location) -1 <= 0 )
                THEN 
                    display_spaceship_action_message  := Spaceship_Is_Not_In_The_Grid 
            ELSIF
                
                // spaceship hit asteroid 
                ((prj1(NAT1, NAT1)(current_Location), prj2(NAT1, NAT1)(current_Location) - 1) : astroids)
            THEN
                
                     // spaceship power reduce by 10 units
                    current_Power := current_Power - 10
                    
                    // asteroid count increment 
                    || asteroid_Collision_Count := asteroid_Collision_Count + 1
                    || display_spaceship_action_message := Spaceship_Hit_Asteroid               
            ELSE
                
                    // normal move spaceship power reduce by 5 units
                    current_Power := current_Power -5 
                    
                    // spaceship move to next region
                    || current_Location := (prj1(NAT1, NAT1)(current_Location) |-> prj2(NAT1, NAT1)(current_Location) - 1)
                    
                    // add current location to spaceship path
                    || spaceship_Path := spaceship_Path <-  (prj1(NAT1, NAT1)(current_Location) |-> prj2(NAT1, NAT1)(current_Location)-1)
                    || display_spaceship_action_message := Spaceship_Moved
            END
       
        END;
    
    /* spaceship move right(forward) */
        display_spaceship_action_message <-- move_Forward =   
        
        //spaceship must inside the space region grid, current location should not be star base and current power should not be zero
        PRE ((current_Location : space_region_grid) & (display_spaceship_action_message : SPACESHIP_MOVEMENT_STATUS)& (current_Power >=5)&(current_Location /= starBase))
        THEN
            
               // In the move up operation, x axis only change then its value should not be greater then grid width otherwise spaceship is out of the grid
             IF (prj1(NAT1, NAT1)(current_Location) + 1 > grid_width)
                THEN 
                    display_spaceship_action_message  := Spaceship_Is_Not_In_The_Grid 
            ELSIF
                
                // spaceship hit asteroid 
                ((prj1(NAT1, NAT1)(current_Location) + 1 , prj2(NAT1, NAT1)(current_Location)) : astroids)
            THEN
                
                     // spaceship power reduce by 10 units
                    current_Power := current_Power - 10
                    
                    // asteroid count increment 
                    || asteroid_Collision_Count := asteroid_Collision_Count + 1
                    || display_spaceship_action_message := Spaceship_Hit_Asteroid                   
            ELSE
                
                    // normal move spaceship power reduce by 5 units
                    current_Power := current_Power -5
                    
                    // spaceship move to next region
                    || current_Location := (prj1(NAT1, NAT1)(current_Location)+ 1 |-> prj2(NAT1, NAT1)(current_Location))
                    
                    // add current location to spaceship path
                    || spaceship_Path := spaceship_Path <-  (prj1(NAT1, NAT1)(current_Location)+1 |-> prj2(NAT1, NAT1)(current_Location))
                    || display_spaceship_action_message := Spaceship_Moved
            END
       
        END;
    
    /* spaceship move left(backward) */
        display_spaceship_action_message <-- move_Backward =  
        
        //spaceship must inside the space region grid, current location should not be star base and current power should not be zero
        PRE ((current_Location : space_region_grid) & (display_spaceship_action_message : SPACESHIP_MOVEMENT_STATUS)& (current_Power >= 5)&(current_Location /= starBase))
        THEN
            
                 // In the move up operation, x axis only change then its value should not be less then zero otherwise spaceship is out of the grid
             IF (prj1(NAT1, NAT1)(current_Location) -1 <= 0 )
                THEN 
                    display_spaceship_action_message  := Spaceship_Is_Not_In_The_Grid 
            ELSIF
                
                // spaceship hit asteroid 
                ((prj1(NAT1, NAT1)(current_Location)-1, prj2(NAT1, NAT1)(current_Location) ) : astroids)
            THEN
                
                     // spaceship power reduce by 10 units
                    current_Power := current_Power - 10
                    
                    // asteroid count increment 
                    || asteroid_Collision_Count := asteroid_Collision_Count + 1
                    || display_spaceship_action_message := Spaceship_Hit_Asteroid                   
            ELSE
                
                    // normal move spaceship power reduce by 5 units
                    current_Power := current_Power -5
                    
                    // spaceship move to next region
                    || current_Location := (prj1(NAT1, NAT1)(current_Location)- 1 |-> prj2(NAT1, NAT1)(current_Location))
                    
                    // add current location to spaceship path
                    || spaceship_Path := spaceship_Path <-  (prj1(NAT1, NAT1)(current_Location)-1 |-> prj2(NAT1, NAT1)(current_Location))
                    || display_spaceship_action_message := Spaceship_Moved
            END
       
        END;
        
        /* spaceship wants to move fast, then its warp drive(jump) */
    display_spaceship_action_message <-- warp_Drive(new_coordinates) =
    
    //spaceship must inside the space region grid,current location should not be star base and current power should not be zero
    PRE ((current_Location : space_region_grid) & (new_coordinates : (NAT1 * NAT1)) & (display_spaceship_action_message : SPACESHIP_MOVEMENT_STATUS)& (current_Power >= 20)&(current_Location /= starBase))
    THEN
        
        // new coordinates should inside the shape region grid otherwise spaceship is out of the grid
        IF (new_coordinates /: space_region_grid)
            THEN
                display_spaceship_action_message := Spaceship_Is_Not_In_The_Grid
        ELSIF
            
            // new coordinates in asteroid location
            (new_coordinates : astroids)
            THEN
                display_spaceship_action_message := Spaceship_Hit_Asteroid
                
                // asteroid count increment 
                || asteroid_Collision_Count := asteroid_Collision_Count + 1
                
                // spaceship power reduce by 10 units
                || current_Power := current_Power - 10
        ELSIF
            
            // From the start position spaceship can't jump directly in to star base
            ((spaceship_Path = []) & (new_coordinates = starBase))
            THEN
                display_spaceship_action_message := Spaceship_Can_not_Directly_Move
        ELSIF
            
            // spaceship can't jump into current position
            (new_coordinates = current_Location)
            THEN
                display_spaceship_action_message := Warp_drive_Can_Not_Use_In_Current_Region
        ELSE
            
             // spaceship power reduce by 20 units
             current_Power := current_Power - 20
             
             // spaceship move to next region
             || current_Location := (prj1(NAT1, NAT1)(new_coordinates) |-> prj2(NAT1, NAT1)(new_coordinates))
             
             // add current location to spaceship path
             || spaceship_Path := spaceship_Path <-  (prj1(NAT1, NAT1)(new_coordinates) |-> prj2(NAT1, NAT1)(new_coordinates))
             || display_spaceship_action_message := Spaceship_Moved
         END
         
     END;
     
     /* mission status(report) */
    power,location,collision_Count <-- mission_Report =  
    
    //spaceship must inside the space region grid
    PRE (current_Location : space_region_grid) 
    THEN
        
        IF (current_Power < 0)
            
            THEN 
            
             // display power zero because power can't be minus value
              power := 0
             // display current location
             || location := (prj1(NAT1, NAT1)(current_Location) |-> prj2(NAT1, NAT1)(current_Location))
            
             // display asteroid count
             || collision_Count := asteroid_Collision_Count
             
            ELSE
            
             // display current location
             location := (prj1(NAT1, NAT1)(current_Location) |-> prj2(NAT1, NAT1)(current_Location))
             
             // display current power
             || power := current_Power
             
             // display asteroid count
             || collision_Count := asteroid_Collision_Count
          
         END       
   
    END;

    /* spaceship went to star base */
    display_spaceship_action_message <-- Spaceship_Docked  =   
    
    //spaceship must locate in the star base
    PRE ((current_Location = starBase) & (display_spaceship_action_message : SPACESHIP_MOVEMENT_STATUS))
    THEN
         display_spaceship_action_message := Spaceship_is_docked        
    
    END;
    
    /* game status */
    display_game_state_message <-- game_Status =     
    
    //spaceship must inside the space region grid
    PRE ((current_Location : space_region_grid) & (display_game_state_message : GAME_STATUS))
    THEN
        IF
            
        // spaceship current location in star base
        (current_Location = starBase)
         THEN
             display_game_state_message := Game_WON
          ELSIF
              
              // spaceship current location in start position and current power is full(100)
            ((current_Power = 100)& (current_Location = start_position))
            THEN
                display_game_state_message := Game_Start    
          ELSIF
              
              // spaceship current location not in star base and power zero
            ((current_Power <=0) & current_Location /= starBase )
            THEN
                display_game_state_message := Game_LOST
          ELSE
              
              // spaceship current location is not in start position,current power less then 100 and more then zero
                display_game_state_message := Game_Not_Over
          END
     END;

    /* mission route */
    Spaceship_Mission_Route <-- mission_Route =     
    
    //spaceship must inside the space region grid
    PRE (current_Location : space_region_grid)
    THEN
        
            Spaceship_Mission_Route := spaceship_Path
                
    END

    
END
