//
//  AppDelegate.m
//  Maze3D
//
//  Created by Samuel Jew on 8/18/14.
//  Copyright (c) 2014 Samuel Jew. All rights reserved.
//

#import "AppDelegate.h"
#import "MyMaze.h"
@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    
    // Insert code here to initialize your application
    
    
    printf("Hello World!\n");
    printf("GeneratingRandomMaze:\n\n");
    
    
    // instantiate some type of data structure to determine what has been moved through already
    // implent A* - speed is apparently not especially important here, but completeness is
    // btw, how can A* be too slow?  thought that's what everyone used?
    
    printf("A* Begin!!!\n");
    
        
    MyMaze * TheMaze = new MyMaze(8,5,3,120);
    
    printf("Print the generated Maze\n");
    
    
    TheMaze->PrintMaze();
    
    if (TheMaze->SearchNeighbors(TheMaze->startNode,TheMaze->endNode)) {
        
        TheMaze->FindDirections();
    
        TheMaze->PrintSolution();
    }
    
    printf("\n\n");
    
    MyMaze * FileMaze = new MyMaze("InputFile.txt");
    
    if (FileMaze->SearchNeighbors(FileMaze->startNode, FileMaze->endNode)) {
        
        FileMaze->FindDirections();
        
        FileMaze->PrintSolution();
    }
    
    delete TheMaze;
    
    delete FileMaze;
    
    exit(0);
       
}

@end
