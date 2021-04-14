#include "libasm.h"

void announcement(char *texto);

void ft_test_strlen()
{
	char texto[400];

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
/*	if (strcmp(texto, "NEXT") == 0)
	{

	}
*/
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
