#ifndef H_CONSOLE
#define H_CONSOLE

typedef enum {
    BLACK = 0,
    BLUE,
    GREEN,
    CYAN,
    RED,
    MAGENTA,
    BROWN,
    LIGHT_GRAY,
    DARK_GRAY,
    LIGHT_BLUE,
    LIGHT_GREEN,
    LIGHT_CYAN,
    LIGHT_RED,
    LIGHT_MAGENTA,
    YELLOW,
    WHITE
} Color;

void clear_terminal();
void print_character(char c);
void print_character_with_color(char c, Color background, Color foreground);
void print_string(const char *str);
void print_string_with_color(const char *str, Color background, Color foreground);
void print_line(const char *str);
void print_line_with_color(const char *str, Color background, Color foreground);

#endif
