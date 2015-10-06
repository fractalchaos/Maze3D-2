//
//  MyMaze.m
//  Maze3D
//
//  Created by Samuel Jew on 8/18/14.
//  Copyright (c) 2014 Samuel Jew. All rights reserved.
//


#include "MyMaze.h"



MyMaze::MyMaze(  int sizeXX,int sizeYY,int sizeZZ,int obstacles) {
    
 printf("initialize Maze\n");
    
    size[0] = sizeXX;
    
    size[1] = sizeYY;
    
    size[2] = sizeZZ;
    
    stringLocation = 0;
    
    
    Maze = (int *)(malloc((size[0] * size[1] * size[2]) * sizeof(int )));
        
    for (int i = 0;i < size[2];i++) {

        for (int j = 0;j < size[1];j++) {
            for (int k = 0;k < size[0];k++) {
                
                tempArray[0] = k;
                
                tempArray[1] = j;
                
                tempArray[2] = i;
                
                Maze[k + size[0] * j + size[0] * size[1] * i] = 0;
               

            }
        }
    }
        

    /* add walls    */
    
    for (int i = 0;i < obstacles;i++)
            
        Maze[arc4random() % (size[0] * size[1] * size[2])] = 1;
    
        // add entrance and exit to maze
    startingLocation = (arc4random() % (size[0] * size[1] * size[2]));
    
    goalLocation = (arc4random() % (size[0] * size[1] * size[2]));
    
    
    Maze[startingLocation] = 2;
    
    Maze[goalLocation] = 3;
        
    Initialize();

};

void MyMaze::Initialize() {
    
    //currentLocation = startingLocation;
    

    NodeArray = (MyNode **)(malloc((size[0] * size[1] * size[2]) * sizeof(MyNode *))); // instantiate NodeArray
    
    for (int i = 0;i < size[2];i++) {
        
        for (int j = 0;j < size[1];j++) {
            
            for (int k = 0;k < size[0];k++) {
                
                NodeArray[k + size[0] * j + size[1] * size[0] * i] = new MyNode(); // instantiate NodeArray
                
                
            }
        }
    }
    
    /* Instantiate pointers and some member values of each node in NodeArray(3D Maze of Nodes) */
    
    for (int i = 0;i < size[2];i++) {
        
        for (int j = 0;j < size[1];j++) {
            
            for (int k = 0;k < size[0];k++) {
                
                (NodeArray[k + size[0] * j + size[1] * size[0] * i])->location = (k + size[0] * j + size[1] * size[0] * i); // set the location variable
                
                (NodeArray[k + size[0] * j + size[1] * size[0] * i])->costToArriveAtNode = MAX_COST;
                
                (NodeArray[k + size[0] * j + size[1] * size[0] * i])->minimumCostToGoal = FindEstimatedNumberOfSteps((NodeArray[k + size[0] * j + size[1] * size[0] * i]), NodeArray[goalLocation]);
                
                if (Maze[k + size[0] * j + size[1] * size[0] * i]  == 1)   // set blocked paths to maximum value of minimum steps
                    
                    ( NodeArray[k + size[0] * j + size[1] * size[0] * i])->minimumCostToGoal = 1000000;
                
                
                for (int m = 0;m < 6;m++) {  // fun part, set neighbor MyNode pointers
                    
                    
                    switch (m) {
                            
                        case 0: // set north pointer
                            
                            if (j < (size[1] - 1)) {
                                
                                (NodeArray[k + size[0] * j + size[1] * size[0] * i])->Neighbors[m] = NodeArray[k + size[0] * (j + 1) + size[1] * size[0] * i];
                                
                                //  printf("assign north pointer\n");
                                
                            }
                            
                            
                            else {
                                
                                NodeArray[k + size[0] * j + size[1] * size[0] * i]->Neighbors[m] = NULL; // north pointer goes out of bounds
                                
                                //  printf("north pointer out of bounds\n");
                                
                            }
                            
                            break;
                            
                            
                        case 1: // set east pointer
                            
                            if (k < (size[0] - 1)) {
                                
                                (NodeArray[k + size[0] * j + size[1] * size[0] * i])->Neighbors[m] = NodeArray[k + 1 + size[0] * j + size[1] * size[0] * i];
                                
                                //   printf("assign east pointer\n");
                                
                            }
                            
                            
                            else {
                                
                                NodeArray[k + size[0] * j + size[1] * size[0] * i]->Neighbors[m] = NULL; // north pointer goes out of bounds
                                
                                //    printf("east pointer out of bounds\n");
                                
                            }
                            
                            break;
                            
                        case 2: // set south pointer
                            
                            
                            if (j != 0) {
                                
                                (NodeArray[k + size[0] * j + size[1] * size[0] * i])->Neighbors[m] = NodeArray[k + size[0] * (j - 1) + size[1] * size[0] * i];
                                
                                //    printf("assign south pointer\n");
                                
                            }
                            
                            
                            else {
                                
                                NodeArray[k + size[0] * j + size[1] * size[0] * i]->Neighbors[m] = NULL; // north pointer goes out of bounds
                                
                                //   printf("south pointer out of bounds\n");
                                
                            }
                            
                            break;
                            
                        case 3: // set west pointer
                            
                            if (k != 0) {
                                
                                (NodeArray[k + size[0] * j + size[1] * size[0] * i])->Neighbors[m] = NodeArray[k - 1 + size[0] * j + size[1] * size[0] * i];
                                
                                //  printf("assign west pointer\n");
                                
                            }
                            
                            
                            else {
                                
                                NodeArray[k + size[0] * j + size[1] * size[0] * i]->Neighbors[m] = NULL; // north pointer goes out of bounds
                                
                                //  printf("west pointer out of bounds\n");
                                
                            }
                            
                            break;
                            
                        case 4: // set up pointer
                            
                            
                            if (i < (size[2] - 1)) {
                                
                                (NodeArray[k + size[0] * j + size[1] * size[0] * i])->Neighbors[m] = NodeArray[k  + size[0] * j + size[1] * size[0] * (i + 1)];
                                
                                //  printf("assign up pointer\n");
                                
                            }
                            
                            
                            else {
                                
                                NodeArray[k + size[0] * j + size[1] * size[0] * i]->Neighbors[m] = NULL; // north pointer goes out of bounds
                                
                                // printf("up pointer out of bounds\n");
                                
                            }
                            
                            break;
                            
                        case 5: // set down pointer
                            
                            
                            if (i != 0) {
                                
                                (NodeArray[k + size[0] * j + size[1] * size[0] * i])->Neighbors[m] = NodeArray[k  + size[0] * j + size[1] * size[0] * (i - 1)];
                                
                                // printf("assign down pointer\n");
                                
                            }
                            
                            
                            else {
                                
                                NodeArray[k + size[0] * j + size[1] * size[0] * i]->Neighbors[m] = NULL; // north pointer goes out of bounds
                                
                                // printf("down pointer out of bounds\n");
                                
                            }
                            
                            break;
                            
                        default:
                            
                            printf("ERROR Detected!\n");
                            
                            exit(1);
                            
                            break;
                            
                    }
                    
                }
            }
        }
    }
    endNode = NodeArray[goalLocation];
    
    startNode = NodeArray[startingLocation];
    
   
    
    startNode->costToArriveAtNode = 0;
    
    SearchList = new LinkedList;
    
    
    
    ClosedList = new LinkedList;
    
    SearchList->Append(startNode);


};



MyMaze::~MyMaze() {

    for (int i = 0;i < size[0] * size[1] * size[2];i++)
    
        delete NodeArray[i];
    
    free(NodeArray);
    
    free(Maze);
    
    delete SearchList;
    
    delete ClosedList;
    
}



MyMaze::MyMaze(const char * myfile) {
    
    
    stringLocation = 0;
    
    size[0] = size[1] = size[2] = 0; // 0 size variables

    ifstream infile;
    
    infile.open(myfile);
    
    std::string str = "";
    
    if (myfile == NULL) {
        
        printf("No such file found!\n");
        
        return;
    }
    
    int xflag = 0;
    
    int yflag = 0;
    
    
    getline(infile,str);
    
    size[2] = str[0] - '0';
    
    getline(infile,str);
    
    while (!infile.eof()) {
        
        // first value is size[2]
        
        getline(infile,str);
        

        if (!xflag) {
            
            size[0] = (int)(str.length());
           
            xflag = true;
        }
        
        else if (!yflag) {
        
            size[1]++;
        
        }
        
        if (str[0] == '\0')
            
            yflag++;
        
    }
    
    infile.close();

    printf("Dimensions are x:%i y:%i z:%i\n",size[0],size[1],size[2]);
    
    
    Maze = (int *)(malloc((size[0] * size[1] * size[2]) * sizeof(int )));
    
    for (int i = 0;i < size[2];i++) {
        
        for (int j = 0;j < size[1];j++) {
            
            for (int k = 0;k < size[0];k++) {
                
                tempArray[0] = k;
            
                tempArray[1] = j;
                
                tempArray[2] = i;
                
                
                Maze[k + size[0] * j + size[0] * size[1] * i] = 0;
                
            }
        }
    }
    
    
    FILE * samefile = fopen(myfile, "r");
    
    if (samefile == NULL) {
        
        printf("Error opening file!\n");
        
    }
    
    int location = 0;
    
    int scanner;
    
    while ((scanner = fgetc(samefile)) != EOF) {
        
    
        switch (scanner) {
        
            case ('B'):
                
            Maze[location] = 2;
                
                currentLocation = startingLocation = location;
        
                break;
            
            case ('E'):
                
                Maze[location] = 3;
                
                goalLocation = location;
                
                break;
                
            case (','):
                
            case ('.'):
                
                Maze[location] = 0;
                
                break;
                
            case ('#'):
                
                Maze[location] = 1;
                
                break;
            default:
                
                    /* eliminate blank spacing  */
                
                continue;
                
                break;
        }
        
        location++;
    }
    
    fclose(samefile);
    
    PrintMaze();
    
    Initialize();
}

int MyMaze::SearchNeighbors(MyNode * start,MyNode * end) {
    
        
    if (start->location == end->location) {
        
        return true;
        
    }
    
    else {
        
        for (int i = 0;i < 6;i++) { // search each neighbor and find cheapest solution
            
            if (start->Neighbors[i]) { // make sure the neighbor node exists and if so, set its cost
                
                if (Maze[ start->Neighbors[i]->location] != 1) {
                
                    start->Neighbors[i]->costToArriveAtNode = start->costToArriveAtNode + 1;
                    
                }
                
                else start->Neighbors[i]->costToArriveAtNode = MAX_COST;
            
            }
            
        }
        
        
        for (int i = 0;i < 6;i++ ) {

            if ((start->Neighbors[i]) && ((start->Neighbors[i])->GetTotalCost() < MAX_COST) && (!(SearchList->isOnList(start->Neighbors[i])) )) {// if neighbor is a valid node that we haven't visited before
                
                start->Neighbors[i]->parent = start;      // set parent node if it's a valid node 


                SearchList->Append(start->Neighbors[i]);    // add it to the search list
            }
        }
        
        
        start->minimumCostToGoal = MAX_COST;            // make sure we don't revisit start node in SearchList
        
        MyNode * temp = SearchList->FindCheapest();     // find the cheapest node
        
        if (temp) {                                     // if we have a node
  
            ClosedList->Append(temp);               // add it to the list of nodes to search
                
            
            return SearchNeighbors(temp,end); // perform search operation on cheapest node
        }

        else {
            
            printf("Not escapable!\n");
        
            return false; // not escapable
            
        }
        
    }
    
};



int MyMaze::locationToX(int loc) {

    return  (loc  % size[0]);

};



int MyMaze::locationToY(int loc) {

    return ((loc / size[0]) % size[1]);

};



int MyMaze::locationToZ(int loc) {

    return ((loc / (size[0] * size[1])) % size[2]);

};



int MyMaze::showChar(MyNode * first, MyNode * second) {
    
    char tempChar = 'C';
    
// assumes first and second are right next to each other
    
    if (FindEstimatedNumberOfSteps(first, second) == 1) { // error checking
    
        SetTempToDirection(first, second);
    
        
    if ((tempArray[0] == -1) && (tempArray[1] == 0) && (tempArray[2] == 0))
     
        tempChar = 'W';
    
    else if ((tempArray[0] == 1) && (tempArray[1] == 0) && (tempArray[2] == 0))
        
        tempChar = 'E';
    
    else if ((tempArray[1] == 1) && (tempArray[0] == 0) && (tempArray[2] == 0))   // kludge to make sure we have values of N and S that make intuitive sense on the screen
    
        tempChar = 'S';
    
    else if ((tempArray[1] == -1) && (tempArray[0] == 0) && (tempArray[2] == 0))
    
        tempChar = 'N';
    
    else if ((tempArray[2] == 1) && (tempArray[1] == 0) && (tempArray[0] == 0))
    
        tempChar = 'U';
    
    else if ((tempArray[2] == -1) && (tempArray[1] == 0) && (tempArray[0] == 0))
    
        tempChar = 'D';
    
    
    if (tempChar != 'C') {
        
     //   printf ("Final Direction %c stringLocation %i\n",tempChar,stringLocation);

        solutionString[stringLocation] = tempChar; // add tempChar to solutionString
        
        stringLocation++;
        
        solutionString[stringLocation] = '\n';
        
        
        return true;
    }
        
    else {
        
        printf("The estimated Number of steps is %i\n",FindEstimatedNumberOfSteps(first, second));
        
        printf("The steps to take are %i %i %i\n",tempArray[0],tempArray[1],tempArray[2]);
        
        return false;
    
        
    }
    
    }
    
    else {

        printf("Estimated Number of Steps is %i\n",FindEstimatedNumberOfSteps(first, second));
        
        printf("First is ");
        
        first->PrintNode();
        
        printf("second is ");
        
        second->PrintNode();
        
        return false;

    }    
}

void MyMaze::FindDirections() {
    
    int foo;
    
    MyNode* temp = NodeArray[goalLocation];
    
    
    while (temp->parent) {
        
        foo = showChar(temp->parent,temp);
        
        temp = temp->parent;
        
    }

};



void MyMaze::SetTempToDirection(MyNode * End, MyNode * Begin) {

    tempArray[0] = (locationToX(Begin->location) - locationToX(End->location));

    tempArray[1] = (locationToY(Begin->location) - locationToY(End->location));

    tempArray[2] = (locationToZ(Begin->location) - locationToZ(End->location));

};



int MyMaze::FindEstimatedNumberOfSteps(MyNode * beginPoint, MyNode * endPoint) {
    
    int sum = 0;
    

    // which looks cleaner? startPoint or finishingPoint
    
    int myStartX = locationToX(beginPoint->location);
    
    int myStartY = locationToY(beginPoint->location);
    
    int myStartZ = locationToZ(beginPoint->location);
    
    int startPoint[3] = {myStartX,myStartY,myStartZ };
    
    
    int finishingPoint[3] = {locationToX(endPoint->location),locationToY(endPoint->location),locationToZ(endPoint->location)};
                                                                                                  

    for (int i = 0;i < 3;i++) {
        
        sum += abs(finishingPoint[i] - startPoint[i]);
        
    }

    return sum;
};



void MyMaze::PrintMaze() {
    
    printf("Drawing Object-Oriented Maze\n");
    
    int mytempArray[3];
    
    for (int i = 0;i < size[2];i++) {
        
        for (int j = 0;j < size[1];j++) {
            
            for (int k = 0;k < size[0];k++) {
                
                mytempArray[0] = k;
                
                mytempArray[1] = j;
                
                mytempArray[2] = i;
                
                printf("%i",Maze[k + size[0] * j + size[1] * size[0] * i]);
            }
            
            printf("\n");
        }
        
        printf("\n");
    }
    
};



void MyMaze::PrintSolution() {
    
    printf("Escapable: ");

    for (int i = (stringLocation - 1); i >= 0; i--)
        
        printf("%c",solutionString[i]);
    
};


