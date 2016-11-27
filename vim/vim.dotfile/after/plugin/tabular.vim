" Configure Tabularize
if exists(":Tabularize")
  nmap <Leader>g<bar> :Tabularize /<bar><CR>
  vmap <Leader>g<bar> :Tabularize /<bar><CR>
  nmap <Leader>g= :Tabularize /=<CR>
  vmap <Leader>g= :Tabularize /=<CR>
  nmap <Leader>g: :Tabularize /:\zs<CR>
  vmap <Leader>g: :Tabularize /:\zs<CR>
  nmap <Leader>g, :Tabularize /,\zs<CR>
  vmap <Leader>g, :Tabularize /,\zs<CR>
endif
