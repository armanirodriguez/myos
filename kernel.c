#include "console.h"
#include "keyboard.h"

const char prompt[] = "shell >";

void main(void) 
{
    clear_terminal();
    print_string_with_color(prompt, BLACK,LIGHT_CYAN);
    unsigned char byte;
    print_string("Cursor Position: ");
    print_integer(get_cursor_position());
    print_line("");
    while (1) {
        
        update_cursor();
        while ((byte = scan())) {
            print_character(charmap[byte]);
        }
    }
    return;
}