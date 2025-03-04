/**
 * @file my_string.c
 * @author Matthew Kistner
 * @collaborators NAMES OF PEOPLE THAT YOU COLLABORATED WITH HERE
 * @brief Your implementation of these famous 3 string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2023-03-xx
 */

#include <stddef.h>
#include "my_string.h"
/**
 * @brief Calculate the length of a string
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
    int sizeS = 0;
    while (*s != 0) {
        s++;
        sizeS++;
    }
    return sizeS;
}

/**
 * @brief Compare two strings
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
    size_t c = 0;
    while (*s1 == *s2 && c <= n) {
        s1++;
        s2++;
        c++;
        if (*s1 == 0 || *s2 == 0) {
            break;
        }
    }
    if (*s1 == *s2) {
        return 0;
    } else if (*s1 > *s2) {
        return *s1 - *s2;
    } else {
        return *s1 - *s2;
    }
}

/**
 * @brief Copy a string
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
    size_t iterate = 0;
    while (n >= iterate && *src != 0) {
        *dest = *src;
        src++;
        dest++;
        iterate++;
    }
    if (iterate != n) {
        for (size_t k = iterate; k < n; k++) {
            *dest = 0;
            dest++;
        }
    }
    return dest - n;
}

/**
 * @brief Concatenates two strings and stores the result
 * in the destination string
 *
 * @param dest The destination string
 * @param src The source string
 * @param n The maximum number of bytes from src to concatenate
 * @return char* a pointer same as dest
 */
char *my_strncat(char *dest, const char *src, size_t n)
{
    size_t lenDest= 0;
    while (*dest != 0) {
        dest++;
        lenDest++;
    }
    size_t i = 0;
    while (i < n) {
        *dest = *src;
        dest++;
        src++;
        i++;
        lenDest++;
    }
    return dest - lenDest;
}

/**
 * @brief Copies the character c into the first n
 * bytes of memory starting at *str
 *
 * @param str The pointer to the block of memory to fill
 * @param c The character to fill in memory
 * @param n The number of bytes of memory to fill
 * @return char* a pointer same as str
 */
void *my_memset(void *str, int c, size_t n)
{
    unsigned char *ret = str;
    size_t len = 0;
    while (len <  n) {
        *ret = c;
        ret++;
        len++;
    }
    return ret - len;
}

/**
 * @brief Finds the first instance of c in str
 * and removes it from str in place
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 */
void remove_first_instance(char *str, char c){
    while (*str != c) {
        str++;
    }
    if (*str == 0) {
        return;
    }
    while (*(str + 1) != 0) {
        *str = *(str + 1);
        str++;
    }
    *str = 0;
    return;
}

/**
 * @brief Finds the first instance of c in str
 * and replaces it with the contents of replaceStr
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 * @param replaceStr The pointer to the string we are replacing c with
 */
void replace_character_with_string(char *str, char c, char *replaceStr) {
    //checks if replaceStr is longer than 0
    size_t repLen = my_strlen(replaceStr);
    if (repLen == 0) {
        remove_first_instance(str, c);
        return;
    }

    //length of str
    size_t len = my_strlen(str);
    //iterations
    size_t iteration = 0;
    //helps for putting anything after the replacement string
    char keep = *str;

    while (iteration < len) {
        if (keep == c) {
            break;
        }
        keep = *(str + iteration + 1);
        iteration++;
    }
    //ensures the cycle has not gone out of bounds
    if ((iteration + 1) >= len) {
        return;
    }

    
    size_t iteration2 = len;
    size_t i = 0;
    while (iteration2 > iteration) {
        *(str + iteration2 + repLen - 1) = *(str + len - i);
        i++;
        iteration2--;
    }

    size_t j = 0;
    while (j < repLen) {
        *(str + iteration) = *(replaceStr + j);
        iteration++;
        j++;
    }
    return;
}

/**
 * @brief Remove the first character of str (ie. str[0]) IN ONE LINE OF CODE.
 * No loops allowed. Assume non-empty string
 * @param str A pointer to a pointer of the string
 */
void remove_first_character(char **str) {
    (*str)++;
    return;
}