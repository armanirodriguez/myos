#include "console.h"

void main(void) 
{
    clear_terminal();
    print_character('H');
    print_character('e');
    const char str[] = "llo World";
    print_line(str);
    const char str1[] = "Today";
    print_string(str1);
    return;
}
