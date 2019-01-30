/* SpaceGrid
 * Author: Rehan Samarasekera
 * Creation date: 12/16/2018
 */
MACHINE
    SpaceGrid
    
CONSTANTS 
    space_region_grid,
    astroids,
    starBase,
    start_position,
    grid_height,
    grid_width

PROPERTIES
    
    // Define all space regions in the grid
    space_region_grid : POW(NAT1 * NAT1)
    & space_region_grid = {(1 |-> 1),(1 |-> 2),(1 |-> 3),(1 |-> 4),(1 |-> 5),(1 |-> 6),(1 |-> 7),(2 |-> 1),(2 |-> 2),(2 |-> 3),(2 |-> 4),(2 |-> 5),(2 |-> 6),(2 |-> 7),(3 |-> 1),(3 |-> 2),(3 |-> 3),(3 |-> 4),(3 |-> 5),(3 |-> 6),(3 |-> 7),(4 |-> 1),(4 |-> 2),(4 |-> 3),(4 |-> 4),(4 |-> 5),(4 |-> 6),(4 |-> 7),(5 |-> 1),(5 |-> 2),(5 |-> 3),(5 |-> 4),(4 |-> 5),(4 |-> 6),(4 |-> 7),(5 |-> 1),(5 |-> 2),(5 |-> 3),(5 |-> 4),(5 |-> 5),(5 |-> 6),(5 |-> 7),(6 |-> 1),(6 |-> 2),(6 |-> 3),(6 |-> 4),(6 |-> 5),(6 |-> 6),(6 |-> 7),(7 |-> 1),(7 |-> 2),(7 |-> 3),(7 |-> 4),(7 |-> 5),(7 |-> 6),(7 |-> 7),(8 |-> 1),(8 |-> 2),(8 |-> 3),(8 |-> 4),(8 |-> 5),(8 |-> 6),(8 |-> 7),(9 |-> 1),(9 |-> 2),(9 |-> 3),(9 |-> 4),(9 |-> 5),(9 |-> 6),(9 |-> 7),(10 |-> 1),(10 |-> 2),(10 |-> 3),(10 |-> 4),(10 |-> 5),(10 |-> 6),(10 |-> 7),(11 |-> 1),(11 |-> 2),(11 |-> 3),(11 |-> 4),(11 |-> 5),(11 |-> 6),(11 |-> 7),(12 |-> 1),(12 |-> 2),(12 |-> 3),(12 |-> 4),(12 |-> 5),(12 |-> 6),(12 |-> 7)}
    
    //Define all asteroid in the grid
    & astroids <: space_region_grid 
    & astroids = {(3 |-> 2),(3 |-> 5),(5 |-> 4),(6 |-> 7),(7 |-> 1),(7 |-> 5),(7 |-> 7),(8 |-> 3),(10 |-> 6),(11 |-> 2),(12 |-> 5)}
    
    //Define star based in grid but it's should not locate in asteroids
    & starBase = (6 |-> 4)
    & starBase : space_region_grid 
    & starBase /: astroids
    
    //Define start position in grid but it's should not locate in asteroids
    & start_position = (1 |-> 1)
    & start_position : space_region_grid
    & start_position /: astroids
    
    //Define grid height
    & grid_height : NAT1
    & grid_height = 7
    
    //Define grid width
    & grid_width : NAT1
    & grid_width =12
    
END
