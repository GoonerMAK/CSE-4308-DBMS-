#include<stdio.h>
#include <string.h>
#include <stdlib.h>

int main()
	{
    FILE *fp = fopen("C:\\grades.txt","r");     /// declaration of file pointer and opening the file

    const char semicolon[2] = ";";         /// the delimiter

    char *token;

    int arr[49] = {0}, crr[49] = {0};     ///  arr[] contains the ID and crr[] contains the semesters

    int i=0, j=0, k=0, index=0, flag = 1, id, semester;

    float max = 0, ans,  brr[49] = {0}, gpa;   ///  brr[] contains the GPA(s)

    scanf("%d%f%d", &id, &gpa, &semester);   /// reading input
    puts("");

    if (fp != NULL)                 /// checking for error
    {
        char line[20];

        while(fgets(line, sizeof line, fp) )
        {
            token = strtok(line, semicolon);     ///  Delimiters are in the brackets
            arr[i] = atoi(token);               ///   storing only the ID(s)
            i++;
            printf("%s", token);


            token = strtok(NULL, semicolon);
            printf(" %s", token);
            brr[j] = atof(token);             ///  storing the GPA(s)
            j++;


            token = strtok(NULL, semicolon);
            printf(" %s", token);
            crr[k] = atoi(token);           ///  storing the semesters
            k++;

        }


            for(int i=0 ; i<49 ; i++)
            {                        ///  checking whether the input ID is correct or not
                if( id == arr[i]  ||  id == 0)
                {
                    flag = 0;
                    printf("\nINVALID");
                    break;
                }
            }
                                  ///  checking whether the input GPA is correct or not
            if( gpa > 4.00  ||  gpa < 2.50 )
            {
                flag = 0;
                printf("\nINVALID");
            }
                            ///  checking whether the input semester is correct or not
            if( semester < 1  ||  semester > 8 )
            {
                flag = 0;
                printf("\nINVALID");
            }

            fclose(fp);     /// closing file


        if( flag == 1 )
        {

            fp = fopen("C:\\grades.txt", "a");     /// adding data as a new row


                fprintf(fp, "%d;%f;%d\n", id, gpa, semester);
                fclose(fp);
        }

    }

    return 0;
}


// int x = atoi(str);

// double d = atof(str);

