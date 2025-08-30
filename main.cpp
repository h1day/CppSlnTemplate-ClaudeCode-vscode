// main.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

// Test function to trigger cl.exe (MSVC) warnings
void test_function() {
    int unused_variable;                // C4101: unreferenced local variable
    
    int x = 3.14;                       // C4244: conversion from 'double' to 'int'
    
    if (x = 5) {                        // C4706: assignment within conditional expression
        cout << "Warning test" << endl;
    }

    // Signed/unsigned comparison warning
    unsigned int ui = 10;
    int si = -5;
    if (ui > si) {                      // C4018: signed/unsigned mismatch
        cout << "Comparison warning" << endl;
    }
}

int main()
{
    std::cout << "Hello World!\n";
    test_function();
    return 0;
}

// How to Run and Debug:
// 
// In Visual Studio 2022:
//   Run program: Ctrl + F5 or Debug > Start Without Debugging menu
//   Debug program: F5 or Debug > Start Debugging menu
//
// In VS Code:
//   Run program: Ctrl + F5 or use "Run Without Debugging" from Run menu
//   Debug program: F5 or use "Start Debugging" from Run menu
//   Build: Ctrl + Shift + P > "Tasks: Run Task" > "Build Debug"

// Getting Started Tips:
// 
// In Visual Studio 2022:
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. To reopen this project, go to File > Open > Project and select the .sln file
//
// In VS Code:
//   1. Use the Explorer panel (Ctrl + Shift + E) to view files
//   2. Use the Source Control panel (Ctrl + Shift + G) to connect to source control
//   3. Use the Terminal (Ctrl + @) to see build output and run commands
//   4. Use the Problems panel (Ctrl + Shift + M) to view errors and warnings
//   5. Add files to project: Use VS2022 or manually edit .vcxproj file
//   6. To reopen this project, use File > Open Folder and select this directory
