#include "console.h"
#include "keyboard.h"
#include "lib.h"

const char prompt[] = "~>";
const char banner[] = "Welcome to ArmaniOS\nRun 'help' for a list of available commands\n\n";




void main(void) 
{
    char command_buf[64], args_buf[128];
    init_terminal();
    clear_terminal();
    print_line(banner);
    while (1)
    {
        print_string_with_color(prompt, BLACK,LIGHT_CYAN);
        read_command(command_buf,args_buf);
        if (handle_command(command_buf, args_buf) < 0) 
        {
            return;
        }
    }
    return;
}
