#include "libasm.h"


void ft_test_strdup()
{
	char *strdup1;
	char *strdup2;

	char string[350];

	printf("\n\nType the string you want to strdup: ");
	scanf("\n%[^\n]", string);

	if (strcmp(string, "QUIT") == 0)
	{
		announcement("QUIT");
		exit(0);
	}
	if (strcmp(string, "BACK") == 0)
	{
		announcement("FT_READ");
		ft_test_read();
		return ;
	}
	if (strcmp(string, "NEXT") == 0)
	{
		printf("\nThere is no next! This is the last test. \nPay attention please...");
		ft_test_strdup();
		return ;
	}
	if (strcmp(string, "EMPTY") == 0)
	{
		strdup1 = strdup("");
		strdup2 = ft_strdup("");

		printf("- strdup: %s", strdup1);
		printf("\n- ft_strdup: %s", strdup2);

		free(strdup1);
		free(strdup2);

		ft_test_strdup();
	}

	strdup1 = strdup(string);
	strdup2 = ft_strdup(string);

	printf("- strdup: %s", strdup1);
	printf("\n- ft_strdup: %s", strdup2);

	free(strdup1);
	free(strdup2);

	ft_test_strdup();
}

void ft_test_read()
{
	int fd3;

	char buf[350];
	char buf2[350];
	char text[350];
	int count;

	printf("\n\nType the requirements to open.\n");
	printf("File Descriptor: 3 (texto1.txt / texto2.txt): ");
	scanf("%d", &fd3);
	printf("Text (Random text. For NEXT, QUIT, etc...): ");
	scanf("\n%[^\n]", text);
	printf("Count: ");
	scanf("%d", &count);

	if (fd3 > 3)
		fd3++;

	if (strcmp(text, "QUIT") == 0)
	{
		announcement("QUIT");
		exit(0);
	}
	if (strcmp(text, "BACK") == 0)
	{
		announcement("FT_WRITE");
		ft_test_write();
		return ;
	}
	if (strcmp(text, "NEXT") == 0)
	{
		printf("\n");
		announcement("FT_STRDUP");
		ft_test_strdup();
		return ;
	}

	int ret1 = read(fd3, buf, count);
	if (ret1 < 0)
	{
		printf("- return read: %d\n", ret1);
		printf("- read errno / msg: %i - %s\n", errno, strerror(errno));
		errno = 0;
	}
	int ret2 = ft_read(fd3+1, buf2, count);
	if (ret2 < 0)
	{
		printf("- return ft_read: %d\n", ret1);
		printf("- ft_read errno / msg: %i - %s\n", errno, strerror(errno));
		ft_test_read();
	}

	printf("- return read: %d\n", ret1);
	printf("- return ft_read: %d\n", ret2);


	buf[count] = '\0';
	buf2[count] = '\0';
	printf("- return buffer of read: %s\n", buf);
	printf("- return buffer of ft_read: %s\n", buf2);

	ft_test_read();
}

void ft_test_write()
{
	int fd;
	char buf[350];
	int count;

	printf("\n\nType the requirements to write.\n");
	printf("File Descriptor: 0 (SI), 1 (SO), 2 (SE): ");
	scanf("%d", &fd);
	printf("Buffer: ");
	scanf("\n%[^\n]", buf);
	printf("Count: ");
	scanf("%d", &count);

	if (strcmp(buf, "QUIT") == 0)
	{
		announcement("QUIT");
		exit(0);
	}
	if (strcmp(buf, "BACK") == 0)
	{
		announcement("FT_STRCMP");
		ft_test_strcmp();
		return ;
	}
	if (strcmp(buf, "NEXT") == 0)
	{
		printf("\n");
		announcement("FT_READ");
		ft_test_read();
		return ;
	}
	if (strcmp(buf, "EMPTY") == 0)
		strcpy(buf, "");

	write(1, "- write: ", 10);
	errno = 0;
	int ret1 = write(fd, buf, count);
	if (ret1 < 0)
	{
		write(1, "\n- return write: -1\n", 21);
		write(1, "- write errno / msg: ", 22);
		write(1, ft_itoa(errno), ft_strlen(ft_itoa(errno)));
		write(1, " - ", 4);
		write(1, strerror(errno), strlen(strerror(errno)));
		errno = 0;
	}
	write(1, "\n- ft_write: ", 13);
	int ret2 = ft_write(fd, buf, count);
	if (ret2 < 0)
	{
		write(1, "\n- return ft_write: -1\n", 24);
		write(1, "- ft_write errno / msg: ", 25);
		write(1, ft_itoa(errno), ft_strlen(ft_itoa(errno)));
		write(1, " - ", 4);
		write(1, strerror(errno), strlen(strerror(errno)));
		errno = 0;
		ft_test_write();
	}

	printf("\n- return write: %d\n", ret1);
	printf("- return ft_write: %d", ret2);

	ft_test_write();
}

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
	if (strcmp(string1, "NEXT") == 0 || strcmp(string2, "NEXT") == 0)
	{
		printf("\n");
		announcement("FT_WRITE");
		ft_test_write();
		return ;
	}
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
	if (strcmp(texto, "FT_WRITE") == 0)
	{
		printf("		*************************");
		printf("\n		*	FT_WRITE	*\n");
		printf("		*************************");
	}
	if (strcmp(texto, "FT_READ") == 0)
	{
		printf("		*************************");
		printf("\n		*	FT_READ		*\n");
		printf("		*************************");
	}
	if (strcmp(texto, "FT_STRDUP") == 0)
	{
		printf("		*************************");
		printf("\n		*	FT_STRDUP	*\n");
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
	open("texto1.txt", O_RDONLY);
	open("texto2.txt", O_RDONLY);

	//announcement("START");

	//announcement("FT_STRLEN");
	//ft_test_strlen();

	ft_test_strdup();

	return (0);
}
