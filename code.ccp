// Student Assignment Management System
// Full C++ Project using OOP + File Handling

#include <iostream>
#include <fstream>
#include <string>
using namespace std;

class Assignment {
private:
    int id;
    string title;
    string subject;
    string studentName;
    string dueDate;

public:
    void addAssignment() {
        ofstream file("assignments.txt", ios::app);

        cout << "\nEnter Assignment ID: ";
        cin >> id;
        cin.ignore();

        cout << "Enter Assignment Title: ";
        getline(cin, title);

        cout << "Enter Subject Name: ";
        getline(cin, subject);

        cout << "Enter Student Name: ";
        getline(cin, studentName);

        cout << "Enter Due Date: ";
        getline(cin, dueDate);

        file << id << "|"
             << title << "|"
             << subject << "|"
             << studentName << "|"
             << dueDate << endl;

        file.close();

        cout << "\nAssignment Added Successfully!\n";
    }

    void viewAssignments() {
        ifstream file("assignments.txt");
        string line;

        cout << "\n===== Assignment Records =====\n";

        while (getline(file, line)) {
            cout << line << endl;
        }

        file.close();
    }

    void searchAssignment() {
        ifstream file("assignments.txt");

        int searchId;
        bool found = false;
        string line;

        cout << "\nEnter Assignment ID to Search: ";
        cin >> searchId;

        while (getline(file, line)) {
            string temp = "";

            for (char ch : line) {
                if (ch == '|')
                    break;
                temp += ch;
            }

            int fileId = stoi(temp);

            if (fileId == searchId) {
                cout << "\nAssignment Found:\n";
                cout << line << endl;
                found = true;
                break;
            }
        }

        if (!found) {
            cout << "\nAssignment Not Found!\n";
        }

        file.close();
    }

    void deleteAssignment() {
        ifstream file("assignments.txt");
        ofstream tempFile("temp.txt");

        int deleteId;
        bool found = false;
        string line;

        cout << "\nEnter Assignment ID to Delete: ";
        cin >> deleteId;

        while (getline(file, line)) {
            string temp = "";

            for (char ch : line) {
                if (ch == '|')
                    break;
                temp += ch;
            }

            int fileId = stoi(temp);

            if (fileId != deleteId) {
                tempFile << line << endl;
            } else {
                found = true;
            }
        }

        file.close();
        tempFile.close();

        remove("assignments.txt");
        rename("temp.txt", "assignments.txt");

        if (found) {
            cout << "\nAssignment Deleted Successfully!\n";
        } else {
            cout << "\nAssignment Not Found!\n";
        }
    }
};

class Login {
private:
    string username = "admin";
    string password = "1234";

public:
    bool loginSystem() {
        string u, p;

        cout << "========== LOGIN ==========\n";

        cout << "Username: ";
        cin >> u;

        cout << "Password: ";
        cin >> p;

        if (u == username && p == password) {
            cout << "\nLogin Successful!\n";
            return true;
        } else {
            cout << "\nInvalid Username or Password!\n";
            return false;
        }
    }
};

int main() {
    Login log;
    Assignment obj;

    if (!log.loginSystem()) {
        return 0;
    }

    int choice;

    do {
        cout << "\n\n===== STUDENT ASSIGNMENT MANAGEMENT SYSTEM =====\n";
        cout << "1. Add Assignment\n";
        cout << "2. View Assignments\n";
        cout << "3. Search Assignment\n";
        cout << "4. Delete Assignment\n";
        cout << "5. Exit\n";

        cout << "\nEnter Your Choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            obj.addAssignment();
            break;

        case 2:
            obj.viewAssignments();
            break;

        case 3:
            obj.searchAssignment();
            break;

        case 4:
            obj.deleteAssignment();
            break;

        case 5:
            cout << "\nExiting Program...\n";
            break;

        default:
            cout << "\nInvalid Choice!\n";
        }

    } while (choice != 5);

    return 0;
}
