#include "libasm.h"


void ft_test_strcmp()
{
	char string1[350];
	char string2[350];

	printf("\n\nType the strings you want to strcmp.\n");
	printf("String 1: ");
	scanf("\n%[^\n]", string1);
	printf("String 2: ");
	scanf("\n%[^\n]", string2);
	printf("\n");

	if (strcmp(string1, "QUIT") == 0 || strcmp(string2, "QUIT") == 0)
	{
		announcement("QUIT");
		exit(0);
	}
	if (strcmp(string1, "BACK") == 0 || strcmp(string2, "BACK") == 0)
	{
		announcement("FT_STRCPY");
		ft_test_strcpy();
		return ;
	}
	/*if (strcmp(string1, "NEXT") == 0 || strcmp(string2, "NEXT") == 0)
	{
		printf("\n");
		announcement("FT_WRITE");
		ft_test_write();
		return ;
	}*/
	if (strcmp(string1, "EMPTY") == 0)
		strcpy(string1, "");
	if (strcmp(string2, "EMPTY") == 0)
		strcpy(string2, "");

	printf("- strcmp:	%d\n", strcmp(string1, string2));
	printf("- ft_strcmp:	%d", ft_strcmp(string1, string2));

	ft_test_strcmp();
}


void ft_test_strcpy()
{
	char src1[350];
	char dest1[350];

	printf("\n\nType the strings you want to strcpy.\n");
	printf("Source: ");
	scanf("\n%[^\n]", src1);
	printf("Destination: ");
	scanf("\n%[^\n]", dest1);
	printf("\n");

	char src2[350];			  //
	char dest2[350];		 //  This section puts the src1 and srcs2 to the same value.
	strcpy(src2, src1);		//	This section puts the dest1 and dest2 to the same value.
	strcpy(dest2, dest1);  //

	if (strcmp(src1, "QUIT") == 0 || strcmp(dest1, "QUIT") == 0)
	{
		announcement("QUIT");
		exit(0);
	}
	if (strcmp(src1, "BACK") == 0 || strcmp(dest1, "BACK") == 0)
	{
		announcement("FT_STRLEN");
		ft_test_strlen();
		return ;
	}
	if (strcmp(src1, "NEXT") == 0 || strcmp(dest1, "NEXT") == 0)
	{
		announcement("FT_STRCMP");
		ft_test_strcmp();
		return ;
	}
	if (strcmp(src1, "EMPTY") == 0)
	{
		strcpy(src1, "");
		strcpy(src2, "");
	}
	if (strcmp(dest1, "EMPTY") == 0)
	{
		strcpy(dest1, "");
		strcpy(dest2, "");
	}

	strcpy(dest2, src2);
	ft_strcpy(dest1, src1);

	printf("- strcpy:	%s\n", dest2);
	printf("- ft_strcpy:	%s", dest1);

	ft_test_strcpy();
}


void ft_test_strlen()
{
	char texto[350];

	printf("\n\nType the string you want to strlen: ");
	scanf("\n%[^\n]", texto);

	if (strcmp(texto, "QUIT") == 0)
	{
		announcement("QUIT");
		exit(0);
	}
	if (strcmp(texto, "BACK") == 0)
	{
		printf("\nThere is no back! This is the first test. \nPay attention please...");
		ft_test_strlen();
		return ;
	}
	if (strcmp(texto, "NEXT") == 0)
	{
		printf("\n");
		announcement("FT_STRCPY");
		ft_test_strcpy();
		return ;
	}
	if (strcmp(texto, "EMPTY") == 0)
	{
		printf("- strlen:	%ld\n", strlen(""));
		printf("- ft_strlen:	%ld", ft_strlen(""));
		ft_test_strlen();
		return ;
	}
	printf("- strlen:	%ld\n", strlen(texto));
	printf("- ft_strlen:	%ld", ft_strlen(texto));
	ft_test_strlen();
}

void announcement(char *texto)
{
	if (strcmp(texto, "START") == 0)
	{
		printf("\n------------------------------------------------------------------------");
		printf("\n\nThis is a tester made by TiSantos.\n");
		printf("\nTo type an empty string type 'EMPTY' all caps.");
		printf("\nTo quit at any time type 'QUIT' all caps.");
		printf("\nFor the next test type 'NEXT' to go back type 'BACK' all caps.\n\n");
	}
	if (strcmp(texto, "FT_STRLEN") == 0)
	{
		printf("		*************************");
		printf("\n		*	FT_STRLEN	*\n");
		printf("		*************************");
	}
	if (strcmp(texto, "FT_STRCPY") == 0)
	{
		printf("		*************************");
		printf("\n		*	FT_STRCPY	*\n");
		printf("		*************************");
	}
	if (strcmp(texto, "FT_STRCMP") == 0)
	{
		printf("		*************************");
		printf("\n		*	FT_STRCMP	*\n");
		printf("		*************************");
	}
	if (strcmp(texto, "QUIT") == 0)
	{
		printf("\nDon't forget to 'bash clean.sh' to clean the mess.\n");
		printf("Quitting the application!\n");
		printf("\n\nASM Tester.");
		printf("\nOlbrieno v1.2\n\n");
	}
}

int main()
{
	announcement("START");

	announcement("FT_STRLEN");
	ft_test_strlen();

	return (0);
}
