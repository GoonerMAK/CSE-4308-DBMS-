#include<stdio.h>
#include<string.h>
#include<stdlib.h>

int main()
{
    FILE *fp, *fp2;            /// declaration of file pointer
    char line[30], line2[30]; ///  two char arrays to store rows of two files
    char *name[26][10];      ///   2D char array to store the name
    int ids[26] = {0}, ids2[49] = {0};    ///   to store ID(s)
    float gpa[49] = {0};

    fp = fopen("C://studentInfo.txt", "r");

    fp2 = fopen("C://grades.txt", "r");

        int i=0, j=0;

        while(fgets(line, sizeof line, fp))
        {
            char *token = strtok(line, ";");

            ids[i++] = atoi(token);     ///  storing ID(s) of studentInfo.txt
            printf("%s", token);


            token = strtok(NULL, ";");
            name[j][10] = token;           /// storing names
            printf(" %s\n", name[j][10]);
            j++;

        }

        puts("");

        int k=0, t=0;

        while( fgets(line2, sizeof line2, fp2) )
        {
            char *token = strtok(line2, ";");
            ids2[t] = atoi(token);
            printf("%d", ids2[t]);     /// storing ID(s) of grades.txt
            t++;

            token = strtok(NULL, ";");

            gpa[k] = atof(token);    ///  storing GPA(s)
            printf(" %.02f\n", gpa[k]);
            k++;
        }

        int id, flag = 0, name_index = 0, gpa_index = 0;
        scanf("%d", &id);
            ///  ID input

        for( int i=0; i<26 ; i++ )
        {
            if( ids[i] == id )    /// if ID matches with the database
            {
                name_index = i;   /// getting the name index
                break;
            }
        }

                for(int i=0 ; i<49 ; i++)
                {
                    if( ids2[i] == id )   /// then it gets the GPA
                    {
                        gpa_index = i;
                        flag = 1;
                        break;
                    }
                }

        // printf("Name: %d   CGPA: %d", name_index, gpa_index);

        if( flag == 1 )            ///  name and the GPA
        {
            printf("\nName: %s   CGPA: %.02f", name[0][10], gpa[gpa_index]);
        }

        else             ///  if the ID is not in the Database
        {
            printf("\nNOT FOUND!");
        }

    return 0;
}
