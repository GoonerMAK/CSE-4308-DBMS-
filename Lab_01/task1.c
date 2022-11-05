#include<stdio.h>
#include <string.h>
#include <stdlib.h>

int main()
	{
    FILE *fp = fopen("C:\\grades.txt","r");         /// declaration of file pointer and opening the file

    const char semicolon[2] = ";";             ///  the delimiter

    char *token;

    int arr[49] = {0}, crr[49] = {0};        ///  arr[] contains the ID and crr[] contains the semester

    int i=0, j=0, k=0, index=0;

    float max = 0, brr[49] = {0};          ///  brr[] contains the GPA


    if (fp != NULL)                 /// checking for error
    {
        char line[20];

        while(fgets(line, sizeof line, fp) )
        {
            ///  strtok splits the strings
            token = strtok(line, semicolon);     ///  Delimiters are in the brackets
            arr[i] = atoi(token);               ///   storing only the ID(s)
            i++;
            printf("%s", token);


            token = strtok(NULL, semicolon);
            printf(" %s", token);
            brr[j] = atof(token);                ///  storing the GPA(s)
            j++;


            token = strtok(NULL, semicolon);
            printf(" %s", token);
            crr[k] = atoi(token);              ///  storing the semesters
            k++;
        }


    fclose(fp);    /// closing file

    for(int i=0 ; i<49 ; i++)
	{
	    if( brr[i] > max )      /// finding out the max GPA
        {
            max = brr[i];
            index = i;     ///  storing the index where we found the max GPA
        }
	}

	printf("\nID: %d  GPA: %.02f", arr[index], max);
	/// printing the max GPA ID with the help of index

    return 0;

}

}





//            while( token != NULL )
//            {
//                printf("%s ", token);
//                token = strtok(NULL, semicolon);
//            }


//            for(i=0 ; i<1 ; i++)
//            {
//                if(i==0)
//                {
//                    int x = atoi( token );
//
//                    arr[j] = x;                  /// storing the ID(s)
//                    j++;
//
//                    printf("%s\n",token);
//
//                    token = strtok(NULL, semicolon);
//                }
//
//
//                if(i == 0)
//                {
//                    float grade = atof(token);
//
//                    if( grade > max )
//                    {
//                        max = grade;
//                        index = k;
//
//                    }
//
//                    k++;
//
//                     printf("%.02f\n",atof(token));
//                }
//
//            }
//



//
//
//
//        while(fgets(line, sizeof line, fp) != NULL)
//        {
//            token2 = strtok(line, semicolon);
//
//            token2 = strtok(NULL, semicolon);
//
//
//
//            for(i=0 ; i<1 ; i++)
//            {
//                if(i==0)
//                {
//                    max2 = atof(token);
//
//                    if( max2 == max )
//                    {
//                        ans = atof(token2);
//                    }
//
//                    // printf("%s %s\n",token2, token);
//
//                    // token = strtok(NULL, semicolon);
//                }
//
////                else
////                {
////                    // printf("%.02f\n",atof(token));
////                }
//
//            }
//
//        }
//
//
//    }
//
//
//




// int x = atoi(str);

// double d = atof(str);
