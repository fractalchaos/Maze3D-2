//
//  MyMaze.h
//  Maze3D
//
//  Created by Samuel Jew on 8/18/14.
//  Copyright (c) 2014 Samuel Jew. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <fstream>
#include <string>
#include <iostream>
#import "LinkedList.h"

using namespace std;

class MyMaze {
private:
    
    char solutionString[1000];
    
    int stringLocation;
    //int mysizeX;
    
   // int mysizeY;
    
   // int mysizeZ;
    
    int size[3];
    
    int * Maze;
    
    
    int currentLocation;
    
        
    MyNode * workingNode;
    
    int startingLocation;
    
    int goalLocation;
    
    int tempArray[3];
    
    MyNode ** NodeArray;
    
    

    
public:
    LinkedList * SearchList;
    
    LinkedList * ClosedList;


    MyNode * startNode;
    
    MyNode * endNode;

    
    MyMaze(  int sizeX,int sizeY,int sizeZ,int obstacles);
    
    MyMaze(const char * myfile);

    MyMaze();
    
    ~MyMaze();
    
    void Initialize();
    
    int SearchNeighbors(MyNode * start,MyNode * end);

    void FindDirections();
    
//    int SolveProblem (MyNode * start, MyNode * end);

    
    void PrintMaze();
    
    void PrintSolution();
    
    void SetTempToDirection(MyNode * End, MyNode * Begin);
    
    int showChar(MyNode * first, MyNode * second);


    int FindEstimatedNumberOfSteps(MyNode * beginPoint, MyNode * endPoint);
    
    // utility functions to get coordinates from location value 
    int locationToX(int loc);
    
    int locationToY(int loc);
    
    int locationToZ(int loc);
    
       
};


