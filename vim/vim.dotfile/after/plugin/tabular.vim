" Configure Tabularize
if exists(":Tabularize")
  nmap <Leader>t<bar> :Tabularize /<bar><CR>
  vmap <Leader>t<bar> :Tabularize /<bar><CR>
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
  nmap <Leader>t, :Tabularize /,\zs<CR>
  vmap <Leader>t, :Tabularize /,\zs<CR>
endif
