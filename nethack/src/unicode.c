/*  SCCS Id: @(#)end.c  3.5 2011/01/19  */
/* Copyright (c) Patric Mueller.            */
/* NetHack may be freely redistributed.  See license for details. */

#include "hack.h"

/** CP437 to Unicode mapping according to the Unicode Consortium
 * http://unicode.org/Public/MAPPINGS/VENDORS/MICSFT/PC/CP437.TXT */
static glyph_t cp437_to_unicode[] = {
    0x00c7, /* LATIN CAPITAL LETTER C WITH CEDILLA */
    0x00fc, /* LATIN SMALL LETTER U WITH DIAERESIS */
    0x00e9, /* LATIN SMALL LETTER E WITH ACUTE */
    0x00e2, /* LATIN SMALL LETTER A WITH CIRCUMFLEX */
    0x00e4, /* LATIN SMALL LETTER A WITH DIAERESIS */
    0x00e0, /* LATIN SMALL LETTER A WITH GRAVE */
    0x00e5, /* LATIN SMALL LETTER A WITH RING ABOVE */
    0x00e7, /* LATIN SMALL LETTER C WITH CEDILLA */
    0x00ea, /* LATIN SMALL LETTER E WITH CIRCUMFLEX */
    0x00eb, /* LATIN SMALL LETTER E WITH DIAERESIS */
    0x00e8, /* LATIN SMALL LETTER E WITH GRAVE */
    0x00ef, /* LATIN SMALL LETTER I WITH DIAERESIS */
    0x00ee, /* LATIN SMALL LETTER I WITH CIRCUMFLEX */
    0x00ec, /* LATIN SMALL LETTER I WITH GRAVE */
    0x00c4, /* LATIN CAPITAL LETTER A WITH DIAERESIS */
    0x00c5, /* LATIN CAPITAL LETTER A WITH RING ABOVE */
    0x00c9, /* LATIN CAPITAL LETTER E WITH ACUTE */
    0x00e6, /* LATIN SMALL LIGATURE AE */
    0x00c6, /* LATIN CAPITAL LIGATURE AE */
    0x00f4, /* LATIN SMALL LETTER O WITH CIRCUMFLEX */
    0x00f6, /* LATIN SMALL LETTER O WITH DIAERESIS */
    0x00f2, /* LATIN SMALL LETTER O WITH GRAVE */
    0x00fb, /* LATIN SMALL LETTER U WITH CIRCUMFLEX */
    0x00f9, /* LATIN SMALL LETTER U WITH GRAVE */
    0x00ff, /* LATIN SMALL LETTER Y WITH DIAERESIS */
    0x00d6, /* LATIN CAPITAL LETTER O WITH DIAERESIS */
    0x00dc, /* LATIN CAPITAL LETTER U WITH DIAERESIS */
    0x00a2, /* CENT SIGN */
    0x00a3, /* POUND SIGN */
    0x00a5, /* YEN SIGN */
    0x20a7, /* PESETA SIGN */
    0x0192, /* LATIN SMALL LETTER F WITH HOOK */
    0x00e1, /* LATIN SMALL LETTER A WITH ACUTE */
    0x00ed, /* LATIN SMALL LETTER I WITH ACUTE */
    0x00f3, /* LATIN SMALL LETTER O WITH ACUTE */
    0x00fa, /* LATIN SMALL LETTER U WITH ACUTE */
    0x00f1, /* LATIN SMALL LETTER N WITH TILDE */
    0x00d1, /* LATIN CAPITAL LETTER N WITH TILDE */
    0x00aa, /* FEMININE ORDINAL INDICATOR */
    0x00ba, /* MASCULINE ORDINAL INDICATOR */
    0x00bf, /* INVERTED QUESTION MARK */
    0x2310, /* REVERSED NOT SIGN */
    0x00ac, /* NOT SIGN */
    0x00bd, /* VULGAR FRACTION ONE HALF */
    0x00bc, /* VULGAR FRACTION ONE QUARTER */
    0x00a1, /* INVERTED EXCLAMATION MARK */
    0x00ab, /* LEFT-POINTING DOUBLE ANGLE QUOTATION MARK */
    0x00bb, /* RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK */
    0x2591, /* LIGHT SHADE */
    0x2592, /* MEDIUM SHADE */
    0x2593, /* DARK SHADE */
    0x2502, /* BOX DRAWINGS LIGHT VERTICAL */
    0x2524, /* BOX DRAWINGS LIGHT VERTICAL AND LEFT */
    0x2561, /* BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE */
    0x2562, /* BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE */
    0x2556, /* BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE */
    0x2555, /* BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE */
    0x2563, /* BOX DRAWINGS DOUBLE VERTICAL AND LEFT */
    0x2551, /* BOX DRAWINGS DOUBLE VERTICAL */
    0x2557, /* BOX DRAWINGS DOUBLE DOWN AND LEFT */
    0x255d, /* BOX DRAWINGS DOUBLE UP AND LEFT */
    0x255c, /* BOX DRAWINGS UP DOUBLE AND LEFT SINGLE */
    0x255b, /* BOX DRAWINGS UP SINGLE AND LEFT DOUBLE */
    0x2510, /* BOX DRAWINGS LIGHT DOWN AND LEFT */
    0x2514, /* BOX DRAWINGS LIGHT UP AND RIGHT */
    0x2534, /* BOX DRAWINGS LIGHT UP AND HORIZONTAL */
    0x252c, /* BOX DRAWINGS LIGHT DOWN AND HORIZONTAL */
    0x251c, /* BOX DRAWINGS LIGHT VERTICAL AND RIGHT */
    0x2500, /* BOX DRAWINGS LIGHT HORIZONTAL */
    0x253c, /* BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL */
    0x255e, /* BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE */
    0x255f, /* BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE */
    0x255a, /* BOX DRAWINGS DOUBLE UP AND RIGHT */
    0x2554, /* BOX DRAWINGS DOUBLE DOWN AND RIGHT */
    0x2569, /* BOX DRAWINGS DOUBLE UP AND HORIZONTAL */
    0x2566, /* BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL */
    0x2560, /* BOX DRAWINGS DOUBLE VERTICAL AND RIGHT */
    0x2550, /* BOX DRAWINGS DOUBLE HORIZONTAL */
    0x256c, /* BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL */
    0x2567, /* BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE */
    0x2568, /* BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE */
    0x2564, /* BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE */
    0x2565, /* BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE */
    0x2559, /* BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE */
    0x2558, /* BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE */
    0x2552, /* BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE */
    0x2553, /* BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE */
    0x256b, /* BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE */
    0x256a, /* BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE */
    0x2518, /* BOX DRAWINGS LIGHT UP AND LEFT */
    0x250c, /* BOX DRAWINGS LIGHT DOWN AND RIGHT */
    0x2588, /* FULL BLOCK */
    0x2584, /* LOWER HALF BLOCK */
    0x258c, /* LEFT HALF BLOCK */
    0x2590, /* RIGHT HALF BLOCK */
    0x2580, /* UPPER HALF BLOCK */
    0x03b1, /* GREEK SMALL LETTER ALPHA */
    0x00df, /* LATIN SMALL LETTER SHARP S */
    0x0393, /* GREEK CAPITAL LETTER GAMMA */
    0x03c0, /* GREEK SMALL LETTER PI */
    0x03a3, /* GREEK CAPITAL LETTER SIGMA */
    0x03c3, /* GREEK SMALL LETTER SIGMA */
    0x00b5, /* MICRO SIGN */
    0x03c4, /* GREEK SMALL LETTER TAU */
    0x03a6, /* GREEK CAPITAL LETTER PHI */
    0x0398, /* GREEK CAPITAL LETTER THETA */
    0x03a9, /* GREEK CAPITAL LETTER OMEGA */
    0x03b4, /* GREEK SMALL LETTER DELTA */
    0x221e, /* INFINITY */
    0x03c6, /* GREEK SMALL LETTER PHI */
    0x03b5, /* GREEK SMALL LETTER EPSILON */
    0x2229, /* INTERSECTION */
    0x2261, /* IDENTICAL TO */
    0x00b1, /* PLUS-MINUS SIGN */
    0x2265, /* GREATER-THAN OR EQUAL TO */
    0x2264, /* LESS-THAN OR EQUAL TO */
    0x2320, /* TOP HALF INTEGRAL */
    0x2321, /* BOTTOM HALF INTEGRAL */
    0x00f7, /* DIVISION SIGN */
    0x2248, /* ALMOST EQUAL TO */
    0x00b0, /* DEGREE SIGN */
    0x2219, /* BULLET OPERATOR */
    0x00b7, /* MIDDLE DOT */
    0x221a, /* SQUARE ROOT */
    0x207f, /* SUPERSCRIPT LATIN SMALL LETTER N */
    0x00b2, /* SUPERSCRIPT TWO */
    0x25a0, /* BLACK SQUARE */
    0x00a0, /* NO-BREAK SPACE */
};

/* DEC Special Graphic Character Set aka VT 100 graphics.
 * Only the last 32 characters are significantly different from ASCII
 * http://support.attachmate.com/techdocs/1184.html */
static glyph_t dec_graphics_to_unicode[] = {
    0x25c6, /* BLACK DIAMOND */
    0x2592, /* MEDIUM SHADE */
    0x0009, /* CHARACTER TABULATION */
    0x000c, /* FORM FEED */
    0x000d, /* CARRIAGE RETURN */
    0x000a, /* LINE FEED */
    0x00b0, /* DEGREE SIGN */
    0x00b1, /* PLUS-MINUS SIGN */
    0x000a, /* NEW LINE (=LINE FEED) */
    0x000b, /* LINE TABULATION */
    0x2518, /* BOX DRAWINGS LIGHT UP AND LEFT */
    0x2510, /* BOX DRAWINGS LIGHT DOWN AND LEFT */
    0x250c, /* BOX DRAWINGS LIGHT DOWN AND RIGHT */
    0x2514, /* BOX DRAWINGS LIGHT UP AND RIGHT */
    0x253c, /* BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL */
    0x00a0, /*_NO-BREAK SPACE */
    0x00a0, /*_NO-BREAK SPACE */
    0x2500, /* BOX DRAWINGS LIGHT HORIZONTAL */
    0x00a0, /*_NO-BREAK SPACE */
    0x00a0, /*_NO-BREAK SPACE */
    0x251c, /* BOX DRAWINGS LIGHT VERTICAL AND RIGHT */
    0x2524, /* BOX DRAWINGS LIGHT VERTICAL AND LEFT */
    0x2534, /* BOX DRAWINGS LIGHT UP AND HORIZONTAL */
    0x252c, /* BOX DRAWINGS LIGHT DOWN AND HORIZONTAL */
    0x2502, /* BOX DRAWINGS LIGHT VERTICAL */
    0x2264, /* LESS-THAN OR EQUAL TO */
    0x2265, /* GREATER-THAN OR EQUAL TO */
    0x03c0, /* GREEK SMALL LETTER PI */
    0x2260, /* NOT EQUAL TO */
    0x00a3, /* POUND SIGN */
    0x00b7, /* MIDDLE DOT */
    0x00a0, /*_NO-BREAK SPACE */
};

/** Returns unicode codepoint of character according to selected graphics mode. */
glyph_t
get_unicode_codepoint(int ch)
{
    if (ch <= 0xFF) {
        if (ch < 0x80) {
            return ch;
        } else if (iflags.IBMgraphics) {
            return cp437_to_unicode[ch-0x80];
        } else if (iflags.DECgraphics && ch >= 0xE0) {
            return dec_graphics_to_unicode[ch-0xE0];
        }
    }
    return ch;
}

#ifdef UTF8_GLYPHS
/** Prints a Unicode codepoint as UTF-8 encoded byte sequence.
 * Originally from Ray Chason's Unicode proof of concept patch. */
int
pututf8char(glyph_t c)
{
    if (c < 0x80) {
        putchar(c);
    } else if(c < 0x800) {
        putchar(0xC0 | (c>>6));
        putchar(0x80 | (c & 0x3F));
    } else if (c < 0x10000) {
        putchar(0xE0 | (c>>12));
        putchar(0x80 | (c>>6 & 0x3F));
        putchar(0x80 | (c & 0x3F));
    } else if (c < 0x200000) {
        putchar(0xF0 | (c>>18));
        putchar(0x80 | (c>>12 & 0x3F));
        putchar(0x80 | (c>>6 & 0x3F));
        putchar(0x80 | (c & 0x3F));
    }

    return 0;
}
#endif

/*unicode.c*/
