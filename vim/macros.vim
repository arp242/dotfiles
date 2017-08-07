" Predefined macros.

" Add KO translation string; expect cursor to be anywhere in opening tag.
"   Hello <div>asd</div> world
"   Hello <div data-bind="text: app.tl('asd')"></div> world
let @t  = "f>l"    " Put cursor after >
let @t .= "vt<xh"  " Remove everything insde the tag
let @t .= "i data-bind=\"text: app.tl('\<Esc>pa')\"\<Esc>"  " Put what we yanked in KO syntax

" Convert from <a> to Markdown; expect cursor to be on "<" in "<a " tag.
"   hello <a href="ASD">hello</a> world
"   hello [hello](ASD) world
let @m  = "df\""        " Delete to "
let @m .= "\"udt\""     " delete/yank url
let @m .= "xx"          " Remove ">
let @m .= "i[\<Esc>"    " Insert [ for text description
let @m .= "f<i](\<Esc>" " End text
let @m .= "\"up"        " Insert URL
let @m .= "f<i)\<Esc>"  " End )
let @m .= "lxxxx"       " Remove </a>

" Wrap Go error; cursor can be anywher on the line, but must be in "return".
"   return err
"   return errors.Wrap(err, "")
let @w  = "^"                   " Start of line
let @w .= "w"                   " Skip past return
let @w .= "ierrors.Wrap(\<Esc>" " Insert
let @w .= "$"                   " Skip past err
let @w .= "a)\<Esc>"            " Insert, leaving cursor on closing )
let @w .= "i, \"\"\<C-o>h"
