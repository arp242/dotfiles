" Convert from <a> to Markdown; expect cursor to be on "<" in "<a " tag.
"   hello <a href="ASD">hello</a> world
"   hello [hello](ASD) world
"let @m  = "df\""        " Delete to "
"let @m .= "\"udt\""     " delete/yank url
"let @m .= "xx"          " Remove ">
"let @m .= "i[\<Esc>"    " Insert [ for text description
"let @m .= "f<i](\<Esc>" " End text
"let @m .= "\"up"        " Insert URL
"let @m .= "f<i)\<Esc>"  " End )
"let @m .= "lxxxx"       " Remove </a>
