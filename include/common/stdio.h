
#ifndef STDIO_H
#define STDIO_H

char getc(void);
void putc(char c);

// copy till newline, or till buflen
void gets(char *buf, int buflen);
void puts(const char *c);

#endif