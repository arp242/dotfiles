" TODO: Limit to just @Spell with e.g. sun keyword?
" https://css-tricks.com/words-avoid-educational-writing/
augroup avoid_words
	autocmd!
	autocmd Syntax *
		\  hi link AvoidWords SpellBad
		\| match AvoidWords /\c\v<(obviously|basically|simply|of\scourse|clearly|just|everyone\sknows|however|so,)>/
augroup end
