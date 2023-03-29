#include "console.h"

#define VGA_WIDTH       80
#define VGA_HEIGHT      25
#define BYTES_PER_CHAR  2

#define is_special_char(c) ((c) <= 31)

static void handle_special_char(char c);

char *const VGA_BUFFER = (char*) 0xb8000;
static unsigned int terminal_position = 0;

void clear_terminal()
{
    for (int i = 0; i < VGA_WIDTH * VGA_HEIGHT * BYTES_PER_CHAR;)
    {
        VGA_BUFFER[i++] = 0;
        VGA_BUFFER[i++] = 7;
    }
}

void print_character(char c)
{
    if (is_special_char(c))
    {
        handle_special_char(c);
    }
    else
    {
        VGA_BUFFER[terminal_position++] = c;
        VGA_BUFFER[terminal_position++] = 7;
    }
}

void print_character_with_color(char c, Color background, Color foreground)
{
    if (is_special_char(c))
    {
        handle_special_char(c);
    }
    else
    {
        VGA_BUFFER[terminal_position++] = c;
        VGA_BUFFER[terminal_position++] = (background << 4) | foreground;

    }
}

void print_string(const char *str)
{
    while (*str != '\0')
    {
        print_character(*str++);
    }
}

void print_string_with_color(const char *str, Color background, Color foreground)
{
    while (*str != '\0')
    {
        print_character_with_color(*str++, background, foreground);
    }
}


void print_line(const char *str)
{
    print_string(str);
    print_character('\n');
}

void print_line_with_color(const char *str, Color background, Color foreground)
{
    print_string_with_color(str, background, foreground);
    print_character('\n');
}

static void handle_newline_character()
{
    terminal_position += (BYTES_PER_CHAR * VGA_WIDTH) - (terminal_position % (BYTES_PER_CHAR * VGA_WIDTH));
}

static void handle_special_char(char c)
{
    switch(c)
    {
        case '\n':
            handle_newline_character();
            break;
    }
}

