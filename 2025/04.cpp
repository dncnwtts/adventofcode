#include <iostream>
#include <vector>
#include <string>
#include <fstream>

using namespace std;

int main() {

	ifstream inputStream;
	string strVar;
	int size = 136;
	char oldarray[size+2][size+2];
	char newarray[size+2][size+2];
	int i = 1;
	int num_adjacent = 0;
	int access = 0;


	inputStream.open("04_input.txt");
	while (inputStream >> strVar)
	{
		for (int j = 1; j <= size; j++) {
		    oldarray[i][j] = strVar[j-1];
		    newarray[i][j] = strVar[j-1];
		}
		i++;
	}
	inputStream.close();


	for (i = 1; i<=size; i++) {
		for (int j = 1; j<=size; j++) {
			if (oldarray[i][j] == '@') {
			    num_adjacent = 0;
				if (oldarray[i-1][j] == '@') num_adjacent++;
				if (oldarray[i+1][j] == '@') num_adjacent++;
				if (oldarray[i][j-1] == '@') num_adjacent++;
				if (oldarray[i][j+1] == '@') num_adjacent++;
				if (oldarray[i-1][j+1] == '@') num_adjacent++;
				if (oldarray[i+1][j-1] == '@') num_adjacent++;
				if (oldarray[i-1][j-1] == '@') num_adjacent++;
				if (oldarray[i+1][j+1] == '@') num_adjacent++;

			    if (num_adjacent < 4) {
				    access++;
				    newarray[i][j] = 'x';
			    }
			}
		}
	}
	cout << access << endl;


	access = 0;
	int num_removed = 0;
	int num_removed_old = -1;
	int file_num = 0;
	for (i = 0; i<size+2; i++) 
        {
		for (int j=0; j<size+2; j++)
		{
	             newarray[i][j] = oldarray[i][j];
	        }
        }


	while (num_removed != num_removed_old) {
	    num_removed_old = num_removed;
	    for (i = 1; i<=size; i++) {
	    	for (int j = 1; j<=size; j++) {
	    		if (oldarray[i][j] == '@') {
	    		    num_adjacent = 0;
	    			if (oldarray[i-1][j] == '@') num_adjacent++;
	    			if (oldarray[i+1][j] == '@') num_adjacent++;
	    			if (oldarray[i][j-1] == '@') num_adjacent++;
	    			if (oldarray[i][j+1] == '@') num_adjacent++;
	    			if (oldarray[i-1][j+1] == '@') num_adjacent++;
	    			if (oldarray[i+1][j-1] == '@') num_adjacent++;
	    			if (oldarray[i-1][j-1] == '@') num_adjacent++;
	    			if (oldarray[i+1][j+1] == '@') num_adjacent++;

	    		    if (num_adjacent < 4) {
	    			    access++;
				    if (oldarray[i][j] == '@') {
					    newarray[i][j] = '.';
					    num_removed++;
				    }

	    		    }
	    		}
	    	}
	    }


	    /*
	     * For plotting.
            ofstream myfile;
	    string str = to_string(file_num);
            myfile.open (str);
	    for (i = 1; i<= size; i++) {
	    	for (int j = 1; j<= size; j++) {
			if (newarray[i][j] == '@') {
	    		    myfile << 1 << " ";
			}
			else {
				myfile << 0 << " ";
			}
	    	}
	    	myfile << endl;
	    }
            myfile.close();
	    */

	    file_num++;
	    for (i = 1; i<= size; i++) {
	    	for (int j = 1; j<= size; j++) {
	    		oldarray[i][j] = newarray[i][j];
	    	}
	    }

	}

	cout << num_removed << endl;


	return 0;
}
