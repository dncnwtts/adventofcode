#include <iostream>
#include <string>
#include <fstream>
using namespace std;


bool isValid(long num) {
	string output =  to_string(num);

	if ((output.length() % 2) == 1) {
		return 1;
	}
	else
	{
		if (output.substr(0, output.length()/2) == output.substr(output.length()/2, output.length())) {
			return 0;
		}
		else {
			return 1;
		}
        }
}


bool isValid2(long num) {
	string output =  to_string(num);
	string substr;
	string substr2;
	int ok;

	for (int i = output.length() / 2; i > 0; i--) {
		if ((output.length() % i) == 0) {
		   ok = 0;
		   substr = output.substr(0, i);
		   for (int j = 1; j < output.length()/substr.length(); j++){
		   	substr2 = output.substr(j*substr.length(), substr.length());
		   	if (substr != substr2){
		   		ok++;
		   		break;
		   	}
		   	else {
		   		ok = 0;
		   	}
		   }
		   if (ok == 0) {
		   	return 0;
		   }
		}

	}
	return 1;
}

int part1()
{


	string testString("11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124");

	long i;
	long j;
	long k;

	long range_start = -1;
	long range_end   = -1;
	long pivot = 0;

	j = 0;
	long start_num;
	long final_num;

	long num_invalid_ids = 0;

	for (long i = 0; i < testString.length(); i++) {
		if (testString[i] == ',') {
			range_start = range_end + 1;
			range_end = i;
			for (long j = range_start; j < range_end; j ++ ) {
				if (testString[j] == '-') {
					start_num = stol(testString.substr(range_start, j - range_start));
					final_num = stol(testString.substr(j+1, range_end - j - 1));
					for (k = start_num; k <= final_num; k++) {
						if (!isValid(k)) num_invalid_ids += k;
					}
				}
			}

		}
	}
	for (long j = range_end + 1; j < testString.length(); j ++ ) {
		if (testString[j] == '-') {
			start_num = stol(testString.substr(range_end+1, j - range_end - 1));
			final_num = stol(testString.substr(j+1, testString.length()));
			for (k = start_num; k <= final_num; k++) {
			        if (!isValid(k)) num_invalid_ids += k;
			}
		}
	}


	cout << num_invalid_ids << endl;

	return 0;

}

int part2()
{


	string testString("11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124");

	long i;
	long j;
	long k;

	long range_start = -1;
	long range_end   = -1;
	long pivot = 0;

	j = 0;
	long start_num;
	long final_num;

	long num_invalid_ids = 0;

	for (long i = 0; i < testString.length(); i++) {
		if (testString[i] == ',') {
			range_start = range_end + 1;
			range_end = i;
			for (long j = range_start; j < range_end; j ++ ) {
				if (testString[j] == '-') {
					start_num = stol(testString.substr(range_start, j - range_start));
					final_num = stol(testString.substr(j+1, range_end - j - 1));
					for (k = start_num; k <= final_num; k++) {
						if (!isValid2(k)) num_invalid_ids += k;
					}
				}
			}

		}
	}
	for (long j = range_end + 1; j < testString.length(); j ++ ) {
		if (testString[j] == '-') {
			start_num = stol(testString.substr(range_end+1, j - range_end - 1));
			final_num = stol(testString.substr(j+1, testString.length()));
			for (k = start_num; k <= final_num; k++) {
			        if (!isValid2(k)) num_invalid_ids += k;
			}
		}
	}


	cout << num_invalid_ids << endl;

	return 0;

}

int main() {
	part1();
	part2();
}
